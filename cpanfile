requires 'perl', '5.008001';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'File::Copy::Recursive';
    requires 'File::Temp';
    requires 'File::Spec::Functions';
    requires 'FindBin';
};

