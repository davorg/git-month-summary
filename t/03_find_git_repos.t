use v5.40;
use Test2::V0;
use FindBin '$Bin';
use lib "$Bin/../lib";
use File::Temp qw(tempdir);
use File::Spec;
use Cwd qw(abs_path);

require App::GitSummarise;

# Helper: create an App::GitSummarise scoped to a given dir.
sub make_app {
    my ($dir) = @_;
    local $ENV{OPENAI_API_KEY} = 'test-key';
    local @ARGV = ('--month', 3, '--year', 2026, '--dir', $dir);
    return App::GitSummarise->new;
}

# Helper: create a bare .git directory to simulate a git repo.
sub make_fake_repo {
    my ($base, @parts) = @_;
    my $repo_dir = File::Spec->catdir($base, @parts);
    my $git_dir  = File::Spec->catdir($repo_dir, '.git');
    mkdir $repo_dir or die "mkdir $repo_dir: $!";
    mkdir $git_dir  or die "mkdir $git_dir: $!";
    return abs_path($repo_dir);
}

# -----------------------------------------------------------------------
# _find_git_repos
# -----------------------------------------------------------------------

subtest 'finds a single repo' => sub {
    my $root = tempdir(CLEANUP => 1);
    my $repo = make_fake_repo($root, 'project');
    my $app  = make_app($root);

    my @found = $app->_find_git_repos;
    is scalar(@found), 1,     'found exactly one repo';
    is $found[0],      $repo, 'found the correct repo path';
};

subtest 'finds multiple repos' => sub {
    my $root  = tempdir(CLEANUP => 1);
    my $repo1 = make_fake_repo($root, 'alpha');
    my $repo2 = make_fake_repo($root, 'beta');
    my $repo3 = make_fake_repo($root, 'gamma');
    my $app   = make_app($root);

    my @found = $app->_find_git_repos;
    is scalar(@found), 3, 'found three repos';
    is \@found, bag { item $repo1; item $repo2; item $repo3; end }, 'all repos found';
};

subtest 'repos are returned in sorted order' => sub {
    my $root  = tempdir(CLEANUP => 1);
    my $repo_z = make_fake_repo($root, 'zzz');
    my $repo_a = make_fake_repo($root, 'aaa');
    my $repo_m = make_fake_repo($root, 'mmm');
    my $app   = make_app($root);

    my @found = $app->_find_git_repos;
    is \@found, [$repo_a, $repo_m, $repo_z], 'repos are sorted alphabetically';
};

subtest 'nested repos are also discovered' => sub {
    my $root  = tempdir(CLEANUP => 1);
    my $outer = make_fake_repo($root, 'outer');
    # Create a repo nested inside the outer working tree
    my $inner = make_fake_repo($outer, 'inner');
    my $app = make_app($root);

    my @found = $app->_find_git_repos;
    is scalar(@found), 2, 'both outer and inner repos are found';
    ok grep({ $_ eq $outer } @found), 'outer repo is found';
    ok grep({ $_ eq $inner } @found), 'inner (nested) repo is found';
};

subtest 'empty root directory returns no repos' => sub {
    my $root = tempdir(CLEANUP => 1);
    my $app  = make_app($root);

    my @found = $app->_find_git_repos;
    is scalar(@found), 0, 'no repos found in empty directory';
};

subtest 'root dir itself is a repo' => sub {
    my $root = tempdir(CLEANUP => 1);
    # Make the root itself a git repo
    mkdir File::Spec->catdir($root, '.git');
    my $app = make_app($root);

    my @found = $app->_find_git_repos;
    ok scalar(@found) >= 1, 'at least one repo found';
    ok grep({ $_ eq abs_path($root) } @found), 'root dir itself is included';
};

done_testing;
