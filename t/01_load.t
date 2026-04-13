use v5.40;
use Test2::V0;
use FindBin '$Bin';
use lib "$Bin/../lib";
use File::Temp qw(tempdir);
use Cwd qw(abs_path);

ok lives { require App::GitSummarise }, 'App::GitSummarise loads without errors'
    or bail_out('Cannot load App::GitSummarise');

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

subtest 'valid construction' => sub {
    my $tmpdir = tempdir(CLEANUP => 1);
    ok lives { make_app(dir => $tmpdir) }, 'object created successfully';
};

subtest 'dies without OPENAI_API_KEY' => sub {
    my $tmpdir = tempdir(CLEANUP => 1);
    local $ENV{OPENAI_API_KEY} = undef;
    local @ARGV = ('--month', 3, '--year', 2026, '--dir', $tmpdir);
    like dies { App::GitSummarise->new }, qr/OPENAI_API_KEY is not set/, 'dies without API key';
};

subtest 'dies without --month' => sub {
    my $tmpdir = tempdir(CLEANUP => 1);
    local $ENV{OPENAI_API_KEY} = 'test-key';
    local @ARGV = ('--year', 2026, '--dir', $tmpdir);
    like dies { App::GitSummarise->new }, qr/--month/, 'dies when --month missing';
};

subtest 'dies without --year' => sub {
    my $tmpdir = tempdir(CLEANUP => 1);
    local $ENV{OPENAI_API_KEY} = 'test-key';
    local @ARGV = ('--month', 3, '--dir', $tmpdir);
    like dies { App::GitSummarise->new }, qr/--year/, 'dies when --year missing';
};

subtest 'dies for invalid month' => sub {
    my $tmpdir = tempdir(CLEANUP => 1);
    local $ENV{OPENAI_API_KEY} = 'test-key';
    local @ARGV = ('--month', 13, '--year', 2026, '--dir', $tmpdir);
    like dies { App::GitSummarise->new }, qr/--month must be between 1 and 12/, 'month 13 is rejected';
};

subtest 'dies for invalid year' => sub {
    my $tmpdir = tempdir(CLEANUP => 1);
    local $ENV{OPENAI_API_KEY} = 'test-key';
    local @ARGV = ('--month', 3, '--year', 1969, '--dir', $tmpdir);
    like dies { App::GitSummarise->new }, qr/--year must be a sensible four-digit year/, 'year 1969 is rejected';
};

subtest 'dies for non-existent dir' => sub {
    local $ENV{OPENAI_API_KEY} = 'test-key';
    local @ARGV = ('--month', 3, '--year', 2026, '--dir', '/no/such/dir/xyz');
    like dies { App::GitSummarise->new }, qr{/no/such/dir/xyz}, 'non-existent dir is rejected';
};

done_testing;
