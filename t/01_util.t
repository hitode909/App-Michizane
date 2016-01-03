use strict;
use Test::More 0.98;

use App::Michizane;

subtest 'trim' => sub {
    is App::Michizane::trim('hi'), 'hi', 'without indent';
    is App::Michizane::trim(' hi '), 'hi', 'with indent';
};

subtest 'shorten' => sub {
    is App::Michizane::shorten('hi'), '';
    is App::Michizane::shorten('hello world'), 'world';
};

subtest 'merge' => sub {
    is App::Michizane::merge('my $user = User->new', 'my $user = User->new', 'my $user = User->new'), 'my $user = User->new';
    is App::Michizane::merge('my $user = User', '= User', 'my $user1 = User->new;'), 'my $user = User->new;';
};

done_testing;
