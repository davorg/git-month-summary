use v5.40;
use Test2::V0;
use FindBin '$Bin';
use lib "$Bin/../lib";
use File::Temp qw(tempdir);
use Test::MockModule;
use Capture::Tiny qw(capture_stderr);

require App::GitSummarise;

# Helper: build an App::GitSummarise with controlled CLI args and env.
sub make_app {
    my (%opts) = @_;
    my $month = $opts{month} // 3;
    my $year  = $opts{year}  // 2026;
    my $dir   = $opts{dir}   // tempdir(CLEANUP => 1);

    local $ENV{OPENAI_API_KEY} = 'test-key';
    local @ARGV = ('--month', $month, '--year', $year, '--dir', $dir);

    return App::GitSummarise->new;
}

# -----------------------------------------------------------------------
# _repo_has_commits
# -----------------------------------------------------------------------

subtest '_repo_has_commits - returns true when HEAD exists' => sub {
    my $mock = Test::MockModule->new('Git::Repository');
    $mock->mock('new', sub { return bless {}, 'Git::Repository' });
    $mock->mock('run', sub { return 'abc123def456abc123def456abc123def456abc123' });

    my $app = make_app();
    ok $app->_repo_has_commits('/fake/repo'), 'returns true when rev-parse succeeds';
};

subtest '_repo_has_commits - returns false when HEAD does not exist' => sub {
    my $mock = Test::MockModule->new('Git::Repository');
    $mock->mock('new', sub { return bless {}, 'Git::Repository' });
    $mock->mock('run', sub { die "fatal: ambiguous argument 'HEAD'\n" });

    my $app = make_app();
    my $result;
    my $stderr = capture_stderr { $result = $app->_repo_has_commits('/fake/empty') };
    ok !$result, 'returns false when rev-parse fails (empty repo)';
};

subtest '_repo_has_commits - returns false when repo cannot be opened' => sub {
    my $mock = Test::MockModule->new('Git::Repository');
    $mock->mock('new', sub { die "Not a git repository\n" });

    my $app = make_app();
    my $result;
    my $stderr = capture_stderr { $result = $app->_repo_has_commits('/not/a/repo') };
    ok !$result, 'returns false when Git::Repository constructor fails';
};

# -----------------------------------------------------------------------
# _git_month_log
# -----------------------------------------------------------------------

my $sample_log = <<'END_LOG';
commit abc123def456abc123def456abc123def456abc123
Author: Alice <alice@example.com>
Date: 2026-03-15
Subject: Add new feature

Body of the commit message.
---
END_LOG

subtest '_git_month_log - returns log output on success' => sub {
    my $mock = Test::MockModule->new('Git::Repository');
    $mock->mock('new', sub { return bless {}, 'Git::Repository' });
    $mock->mock('run', sub { return $sample_log });

    my $app = make_app();
    my $log = $app->_git_month_log(
        '/fake/repo',
        '2026-03-01 00:00:00',
        '2026-04-01 00:00:00',
    );

    is $log, $sample_log, 'returns the git log output';
};

subtest '_git_month_log - returns empty string when log is empty' => sub {
    my $mock = Test::MockModule->new('Git::Repository');
    $mock->mock('new', sub { return bless {}, 'Git::Repository' });
    $mock->mock('run', sub { return '' });

    my $app = make_app();
    my $log = $app->_git_month_log(
        '/fake/repo',
        '2026-03-01 00:00:00',
        '2026-04-01 00:00:00',
    );

    is $log, '', 'returns empty string when there are no commits in range';
};

subtest '_git_month_log - returns undef and warns when repo cannot be opened' => sub {
    my $mock = Test::MockModule->new('Git::Repository');
    $mock->mock('new', sub { die "Not a git repository\n" });

    my $app = make_app();
    my $log;
    my $stderr = capture_stderr {
        $log = $app->_git_month_log(
            '/not/a/repo',
            '2026-03-01 00:00:00',
            '2026-04-01 00:00:00',
        );
    };

    is $log, undef, 'returns undef when repository cannot be opened';
    like $stderr, qr/Could not open git repository/, 'warning is emitted to stderr';
};

subtest '_git_month_log - returns undef and warns when git log fails' => sub {
    my $mock = Test::MockModule->new('Git::Repository');
    $mock->mock('new', sub { return bless {}, 'Git::Repository' });
    $mock->mock('run', sub { die "git log failed for some reason\n" });

    my $app = make_app();
    my $log;
    my $stderr = capture_stderr {
        $log = $app->_git_month_log(
            '/fake/repo',
            '2026-03-01 00:00:00',
            '2026-04-01 00:00:00',
        );
    };

    is $log, undef, 'returns undef when git log command fails';
    like $stderr, qr/git log failed/, 'warning is emitted to stderr';
};

subtest '_git_month_log - passes correct date range to git log' => sub {
    my @captured_args;
    my $mock = Test::MockModule->new('Git::Repository');
    $mock->mock('new', sub { return bless {}, 'Git::Repository' });
    $mock->mock('run', sub {
        my ($self, @args) = @_;
        @captured_args = @args;
        return $sample_log;
    });

    my $app   = make_app();
    my $since = '2026-03-01 00:00:00';
    my $until = '2026-04-01 00:00:00';
    $app->_git_month_log('/fake/repo', $since, $until);

    ok grep({ $_ eq "--since=$since" } @captured_args), '--since is passed to git log';
    ok grep({ $_ eq "--until=$until" } @captured_args), '--until is passed to git log';
    ok grep({ $_ eq '--no-merges'    } @captured_args), '--no-merges is passed to git log';
};

done_testing;
