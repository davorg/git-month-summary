use v5.40;
use Test2::V0;
use FindBin '$Bin';
use lib "$Bin/../lib";
use File::Temp qw(tempdir);
use Cwd qw(abs_path);

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
# _month_range
# -----------------------------------------------------------------------

subtest '_month_range - March 2026' => sub {
    my $app = make_app(month => 3, year => 2026);
    my ($since, $until, $label) = $app->_month_range;

    is $since, '2026-03-01 00:00:00', 'since is first of March';
    is $until, '2026-04-01 00:00:00', 'until is first of April';
    is $label, 'March 2026',          'label is "March 2026"';
};

subtest '_month_range - December rolls over to next year' => sub {
    my $app = make_app(month => 12, year => 2025);
    my ($since, $until, $label) = $app->_month_range;

    is $since, '2025-12-01 00:00:00', 'since is first of December';
    is $until, '2026-01-01 00:00:00', 'until rolls over to first of January next year';
    is $label, 'December 2025',        'label is "December 2025"';
};

subtest '_month_range - January' => sub {
    my $app = make_app(month => 1, year => 2024);
    my ($since, $until, $label) = $app->_month_range;

    is $since, '2024-01-01 00:00:00', 'since is first of January';
    is $until, '2024-02-01 00:00:00', 'until is first of February';
    is $label, 'January 2024',         'label is "January 2024"';
};

# -----------------------------------------------------------------------
# _truncate_text
# -----------------------------------------------------------------------

subtest '_truncate_text - short text is unchanged' => sub {
    my $app  = make_app();
    my $text = 'A' x 100;
    is $app->_truncate_text($text), $text, 'text shorter than limit is returned unchanged';
};

subtest '_truncate_text - text at exact limit is unchanged' => sub {
    my $app  = make_app();
    my $text = 'B' x 30_000;
    is $app->_truncate_text($text), $text, 'text exactly at limit is returned unchanged';
};

subtest '_truncate_text - long text is truncated with notice' => sub {
    my $app   = make_app();
    my $text  = 'C' x 40_000;
    my $result = $app->_truncate_text($text);

    ok length($result) < length($text), 'truncated text is shorter than original';
    like $result, qr/\Q[... git log truncated before sending to the model ...]\E/,
        'truncation notice is appended';
};

subtest '_truncate_text - custom max-input-len is respected' => sub {
    my $tmpdir = tempdir(CLEANUP => 1);
    local $ENV{OPENAI_API_KEY} = 'test-key';
    local @ARGV = ('--month', 3, '--year', 2026, '--dir', $tmpdir, '--max-input-len', 50);
    my $app = App::GitSummarise->new;

    my $short = 'A' x 30;
    is $app->_truncate_text($short), $short, 'text within custom limit is unchanged';

    my $long   = 'B' x 100;
    my $result = $app->_truncate_text($long);
    like $result, qr/\A[B]{50}/, 'result starts with first 50 chars of original';
    like $result, qr/\Q[... git log truncated before sending to the model ...]\E/,
        'truncation notice is present after truncation';
};

# -----------------------------------------------------------------------
# _repo_display_name
# -----------------------------------------------------------------------

subtest '_repo_display_name - strips base dir prefix' => sub {
    my $tmpdir  = tempdir(CLEANUP => 1);
    my $abs_dir = abs_path($tmpdir);
    my $app     = make_app(dir => $tmpdir);

    is $app->_repo_display_name("$abs_dir/myrepo"),
        'myrepo',
        'strips the base directory prefix';
};

subtest '_repo_display_name - nested path' => sub {
    my $tmpdir  = tempdir(CLEANUP => 1);
    my $abs_dir = abs_path($tmpdir);
    my $app     = make_app(dir => $tmpdir);

    is $app->_repo_display_name("$abs_dir/org/subrepo"),
        'org/subrepo',
        'returns relative path for nested repo';
};

subtest '_repo_display_name - when repo equals dir, returns abs path' => sub {
    my $tmpdir  = tempdir(CLEANUP => 1);
    my $abs_dir = abs_path($tmpdir);
    my $app     = make_app(dir => $tmpdir);

    is $app->_repo_display_name($abs_dir),
        $abs_dir,
        'returns abs path when repo is the base dir itself';
};

done_testing;
