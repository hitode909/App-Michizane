use strict;
use Test::More 0.98;

use App::Michizane;

is App::Michizane::trim('hi'), 'hi', 'without indent';
is App::Michizane::trim(' hi '), 'hi', 'with indent';

done_testing;
