use v5.16;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'App::GitSummarise',
    AUTHOR           => 'Dave Cross <dave@perlhacks.com>',
    VERSION_FROM     => 'lib/App/GitSummarise.pm',
    ABSTRACT_FROM    => 'lib/App/GitSummarise.pm',
    LICENSE          => 'artistic_2',
    MIN_PERL_VERSION => '5.040000',
    EXE_FILES        => ['bin/git-month-summary'],
    PREREQ_PM        => {
        'Getopt::Long'            => 0,
        'File::Find'              => 0,
        'File::Spec'              => 0,
        'Cwd'                     => 0,
        'Git::Repository'         => 0,
        'OpenAPI::Client::OpenAI' => 0,
    },
    TEST_REQUIRES => {
        'Test2::V0'        => 0,
        'Test::MockModule' => 0,
        'Capture::Tiny'    => 0,
    },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources   => {
            repository => {
                type => 'git',
                url  => 'https://github.com/davorg/git-month-summary.git',
                web  => 'https://github.com/davorg/git-month-summary',
            },
            bugtracker => {
                web => 'https://github.com/davorg/git-month-summary/issues',
            },
        },
    },
);
