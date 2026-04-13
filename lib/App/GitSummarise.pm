package App::GitSummarise;

use v5.40;
use utf8;
use feature 'class';
no warnings 'experimental::class';

use Getopt::Long qw(GetOptions);
use File::Find qw(find);
use File::Spec;
use Cwd qw(abs_path);
use Git::Repository;
use OpenAPI::Client::OpenAI;

class App::GitSummarise {
    field $dir           = "$ENV{HOME}/git";
    field $model         = 'gpt-5.4-mini';
    field $max_input_len = 30_000;
    field $month;
    field $year;

    ADJUST {
        GetOptions(
            'month=i'         => \$month,
            'year=i'          => \$year,
            'dir=s'           => \$dir,
            'model=s'         => \$model,
            'max-input-len=i' => \$max_input_len,
        ) or die $self->_usage;

        die $self->_usage unless defined $month && defined $year;

        $self->_validate_inputs;

        die "OPENAI_API_KEY is not set in the environment\n"
            unless defined $ENV{OPENAI_API_KEY} && length $ENV{OPENAI_API_KEY};
    }

    method run {
        my ($since, $until, $label) = $self->_month_range;

        my @repos = $self->_find_git_repos;

        unless (@repos) {
            warn "No repos found\n";
            return;
        }

        my $client = OpenAPI::Client::OpenAI->new;

        for my $repo (@repos) {
            next unless $self->_repo_has_commits($repo);

            my $log = $self->_git_month_log($repo, $since, $until);
            next unless defined $log && $log =~ /\S/;

            my $summary = $self->_summarise_repo_changes(
                client      => $client,
                repo        => $repo,
                month_label => $label,
                log         => $self->_truncate_text($log),
            );

            next unless defined $summary && length $summary;

            say '## ', $self->_repo_display_name($repo);
            say '';
            say $summary;
            say "\n---\n";
        }
    }

    method _usage {
        return <<"END_USAGE";
Usage:
  git-month-summary --month N --year YYYY [--dir PATH] [--model MODEL]

Examples:
  git-month-summary --month 3 --year 2026
  git-month-summary --month 3 --year 2026 --dir /home/git/personal
  git-month-summary --month 3 --year 2026 --model gpt-5.4

Options:
  --month         Month number (1-12)
  --year          Four-digit year
  --dir           Root directory to search (default: ~/git)
  --model         OpenAI model (default: gpt-5.4-mini)
  --max-input-len Max characters of git log sent to the model (default: 30000)
END_USAGE
    }

    method _validate_inputs {
        die "--month must be between 1 and 12\n"
            unless $month >= 1 && $month <= 12;

        die "--year must be a sensible four-digit year\n"
            unless $year >= 1970 && $year <= 2100;

        my $abs = abs_path($dir)
            // die "Cannot resolve directory '$dir'\n";

        die "'$abs' is not a directory\n" unless -d $abs;

        $dir = $abs;
    }

    method _month_range {
        my $start = sprintf '%04d-%02d-01 00:00:00', $year, $month;

        my ($next_year, $next_month) = $month == 12
            ? ($year + 1, 1)
            : ($year, $month + 1);

        my $end = sprintf '%04d-%02d-01 00:00:00', $next_year, $next_month;

        my @names = qw(
            January February March April May June
            July August September October November December
        );

        my $label = sprintf '%s %04d', $names[$month - 1], $year;

        return ($start, $end, $label);
    }

    method _find_git_repos {
        my %seen;
        my @repos;

        find(
            {
                wanted => sub {
                    return unless -d $_;

                    return unless $_ =~ /\.git$/;

                    push @repos, $File::Find::dir;
                    $File::Find::prune = 1;

                    return;
                },
                no_chdir => 1,
            },
            $dir,
        );

        if (-d File::Spec->catdir($dir, '.git')) {
            my $abs = abs_path($dir);
            push @repos, $abs if defined $abs && !$seen{$abs}++;
        }

        return sort @repos;
    }

    method _git_month_log ($repo, $since, $until) {
        my $r   = Git::Repository->new(work_tree => $repo);
        my $cmd = $r->command(
            'log',
            '--no-merges',
            "--since=$since",
            "--until=$until",
            '--date=short',
            '--pretty=format:commit %H%nAuthor: %an <%ae>%nDate: %ad%nSubject: %s%n%n%b%n---',
            '--stat=120,80',
        );

        local $/ = undef;
        my $stdout = readline $cmd->stdout;
        my $stderr = readline $cmd->stderr;
        $cmd->close;

        if ($cmd->exit != 0) {
            warn "git log failed for $repo: $stderr\n";
            return;
        }

        return $stdout // '';
    }

    method _summarise_repo_changes (%args) {
        my $client      = $args{client};
        my $repo        = $args{repo};
        my $month_label = $args{month_label};
        my $log         = $args{log};

        my $prompt = <<"END_PROMPT";
You are summarising a month's Git work for the maintainer of a software project.

Repository:
$repo

Month:
$month_label

Please write a concise summary in British English.

Requirements:
- 2 to 5 bullet points
- focus on what changed, not on commit mechanics
- mention themes such as bug fixes, refactoring, new features, documentation, tests, deployment, build or configuration work
- if the changes are small, say so plainly
- do not invent anything that is not supported by the git log
- do not mention hashes unless they are genuinely useful

Git log follows:

$log
END_PROMPT

        my $tx = eval {
            $client->createChatCompletion(
                {
                    body => {
                        model       => $model,
                        temperature => 0.2,
                        messages    => [
                            {
                                role    => 'system',
                                content => 'You produce careful, factual development summaries.',
                            },
                            {
                                role    => 'user',
                                content => $prompt,
                            },
                        ],
                    },
                }
            );
        };

        if ($@) {
            warn "OpenAI request failed for $repo: $@\n";
            return;
        }

        my $res = $tx->res;
        unless ($res && $res->is_success) {
            my $body = eval { $res->body } // '(no response body)';
            warn "OpenAI API error for $repo: " . ($res ? $res->code : 'unknown') . " $body\n";
            return;
        }

        my $json = $res->json;
        my $text = $json->{choices}[0]{message}{content};

        unless (defined $text && length $text) {
            warn "OpenAI returned no summary for $repo\n";
            return;
        }

        $text =~ s/\A\s+//;
        $text =~ s/\s+\z//;

        return $text;
    }

    method _truncate_text ($text) {
        return $text if length($text) <= $max_input_len;

        my $truncated = substr($text, 0, $max_input_len);
        $truncated .= "\n\n[... git log truncated before sending to the model ...]\n";
        return $truncated;
    }

    method _repo_display_name ($repo) {
        my $name = $repo;
        $name =~ s/^\Q$dir\E\/?//;
        return $name eq '' ? $repo : $name;
    }

    method _repo_has_commits ($repo) {
        my $r = eval { Git::Repository->new(work_tree => $repo) };
        return 0 unless $r;
        eval { $r->run('rev-parse', '--verify', 'HEAD') };
        return $@ ? 0 : 1;
    }
}

1;
