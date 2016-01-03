package App::Michizane;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

sub trim ($) {
    my ($str) = @_;
    $str =~ s{^\s*}{}r =~ s{\s*$}{}r;
}

sub shorten ($) {
    my ($str) = @_;
    $str =~ s{^\s*\S*\s*}{}r;
}

sub new {
    my ($class) = @_;

    bless {}, $class;
}

sub horizontal {
    my ($self, $query) = @_;

    unless (defined $query && length $query) {
        return [];
    }

    my @lines = `git grep --fixed-strings -h @{[ quotemeta($query) ]}`;

    unless (@lines) {
        return $self->horizontal(shorten $query);
    }

    my $counts = {};

    for my $line (@lines) {
        my $candidate = trim($line);
        next unless length $candidate;
        next if $candidate eq $query;
        # next unless $candidate =~ qr{\Q$query\E$};
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

