[![Build Status](https://travis-ci.org/hitode909/App-Michizane.svg?branch=master)](https://travis-ci.org/hitode909/App-Michizane)
# NAME

michizane - The Code Predictor

# SYNOPSIS

    % michizane horizontal <query>
    % michizane vertical   <query>

# DESCRIPTION

Michizane predicts the code what you are going to type statistically.

Horizontal command shows horizontal complements. This command predicts the rest of your statement.

If you are typing `use str`, you will type `use strict`.

    % michizane horizontal 'use str'
    use strict;

Vertical command shows vertical complements. This command predicts the next line of your statement.

If you typed `use strict;`, you will type `use warnings;` or `use Test::More 0.98;` at next line.

    % michizane vertical 'use strict;'
    use Test::More 0.98;
    use warnings;

These candidates are collected from working git repository.

# LICENSE

Copyright (C) hitode909.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

hitode909 &lt;hitode909@gmail.com>
