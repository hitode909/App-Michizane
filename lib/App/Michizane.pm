package App::Michizane;
use 5.014;
use strict;
use warnings;

our $VERSION = "0.01";

# " hi " to "hi"
sub trim ($) {
    my ($str) = @_;
    $str =~ s{^\s*}{}r =~ s{\s*$}{}r;
}

# "hi there" to "there"
sub shorten ($) {
    my ($str) = @_;
    $str =~ s{^\s*\S*\s*}{}r;
}

# (my $a =, =, my $b = 2) to my $a = 2
sub merge ($$$) {
    my ($original, $query, $found) = @_;
    my $index1 = index($original, $query);
    my $index2 = index($found, $query);
    substr($original, 0, $index1) . substr($found, $index2);
}

sub new {
    my ($class) = @_;

    bless {}, $class;
}

sub horizontal {
    my ($self, $query, $skip) = @_;
    return [] unless defined $query && length $query;

    $skip ||= 0;
    my $short_query = $query;
    $short_query = shorten($short_query) for (1..$skip);

    unless (defined $short_query && length $short_query) {
        return [];
    }

    my @lines = `git grep --fixed-strings -h @{[ quotemeta($short_query) ]}`;

    unless (@lines) {
        return $self->horizontal($query, ++$skip);
    }

    my $counts = {};

    for my $line (@lines) {
        my $candidate = merge($query, $short_query, trim($line));
        next unless length $candidate;
        next if $candidate eq $short_query;
        $counts->{$candidate} ||= 0;
        $counts->{$candidate}++;
    }

    my @sorted = sort { $counts->{$b} <=> $counts->{$a}; } keys %$counts;

    \@sorted;
}

sub vertical {
    my ($self, $query) = @_;

    unless (defined $query && length $query) {
        return [];
    }

    my @lines = `git grep -A1 --fixed-strings -h @{[ quotemeta($query) ]}`;

    unless (@lines) {
        return [];
    }

    my $counts = {};

    while (@lines) {
        next unless trim(shift @lines) eq '--';

        my $header = trim(shift @lines);
        next unless length $header;
        next unless $header eq $query;

        my $candidate = trim(shift @lines);
        $counts->{$candidate} ||= 0;
        $counts->{$candidate}++;
    }

    my @sorted = sort { $counts->{$b} <=> $counts->{$a}; } keys %$counts;

    \@sorted;
}

1;
__END__

=encoding utf-8

=head1 NAME

App::Michizane - It's new $module

=head1 SYNOPSIS

    use App::Michizane;

=head1 DESCRIPTION

App::Michizane is ...

=head1 LICENSE

Copyright (C) hitode909.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

hitode909 E<lt>hitode909@gmail.comE<gt>

=cut

