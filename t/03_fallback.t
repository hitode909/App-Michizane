use strict;
use Test::More 0.98;
use t::test;

use App::Michizane;

my $michizane = App::Michizane->new;

my $dir = t::test->prepare_test_project('assignment_to_another_variable');
chdir $dir;

subtest 'empty input returns empty' => sub {
    is_deeply $michizane->horizontal(''), [];
    is_deeply $michizane->horizontal(), [];
    is_deeply $michizane->vertical(''), [];
    is_deeply $michizane->vertical(), [];
};

subtest 'fallback to User->*' => sub {
    is_deeply $michizane->horizontal(q(my $user = User->)), [q(my $user = User->new;)], 'fallback to User->';
    is_deeply $michizane->vertical(q(my $user = User->new;)), [], 'only for horizontal complement';
};

done_testing;
