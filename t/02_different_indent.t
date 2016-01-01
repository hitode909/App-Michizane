use strict;
use Test::More 0.98;
use t::test;

use App::Michizane;

my $michizane = App::Michizane->new;

my $dir = t::test->prepare_test_project('one_two_with_different_indent');
chdir $dir;

subtest 'match' => sub {
    is_deeply $michizane->horizontal(q(my $one)), [q(my $one = 1;), q(my $one = 'one';)];
    is_deeply $michizane->vertical(q(my $one = 1;)), [q(my $two = 2;)];
};

subtest 'not match' => sub {
    is_deeply $michizane->horizontal(q(my $three)), [];
    is_deeply $michizane->vertical(q(my $three = 3;)), [];
};

done_testing;
