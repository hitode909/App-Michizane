package t::test;

use strict;
use warnings;
use utf8;

use FindBin;
use File::Spec::Functions qw/catfile/;
use File::Temp qw(tempdir);
use File::Copy::Recursive;

sub prepare_test_project {
    my ($class, $name) = @_;

    my $base_directory = catfile($FindBin::Bin, 'data', $name);
    my $tmpdir = tempdir;

    unless (-d $base_directory) {
        die "$name is not defined";
    }

    File::Copy::Recursive::dircopy($base_directory, $tmpdir);

    system "cd $tmpdir && git init --quiet && git config user.email 'test at example.com' &&  git config user.name 'Tester' && git add * && git commit --quiet -m 'init'";

    $tmpdir;
}

1;
