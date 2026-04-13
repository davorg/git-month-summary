requires 'Getopt::Long';
requires 'File::Find';
requires 'File::Spec';
requires 'Cwd';
requires 'Git::Repository';
requires 'OpenAPI::Client::OpenAI';

on 'test' => sub {
    requires 'Test2::V0';
    requires 'Test::MockModule';
    requires 'Capture::Tiny';
};

on 'develop' => sub {
    requires 'Test::Pod'          => '1.00';
    requires 'Test::Pod::Coverage' => '1.00';
};
