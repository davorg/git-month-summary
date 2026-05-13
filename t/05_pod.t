use v5.40;

BEGIN {
    unless ( $ENV{AUTHOR_TESTING} ) {
        require Test::More;
        Test::More::plan( skip_all => 'Author tests. Set AUTHOR_TESTING=1 to run.' );
    }
}

use Test::Pod 1.00;
all_pod_files_ok();
