package CSS::Tiny::Styles;

use warnings;
use strict;

use version; our $VERSION = qv('0.0.3');

use base 'CSS::Tiny';

use CSS::Tiny::Style;

sub selectors {
    my $self = shift;
    return keys %{ $self };
}

sub styles {
    my $self = shift;
    my @styles = $self->_sorted_styles;

    return @styles;
}

sub _sorted_styles {
    my $self = shift;
    my @styles = sort { $a->specificity <=> $b->specificity } $self->_all_styles;
    return @styles;
}

sub _all_styles {
    my $self = shift;
    my @res;
    while (my ($selector, $properties) = each %{ $self }) {
        push @res, CSS::Tiny::Style->new($selector, $properties);
    }
    return @res;
}

our $AUTOLOAD;

sub AUTOLOAD {
    my $self = shift;

    my $attr = $AUTOLOAD;
    $attr =~ s/.*:://;

    no strict 'refs'; ## no critic

    return unless exists $self->{$attr};
    return CSS::Tiny::Style->new($attr, $self->{$attr});
}


sub style {
    my $self = shift;
    my $style = shift;

    return unless exists $self->{$style};
    return CSS::Tiny::Style->new($style, $self->{$style});
}

1;

__END__

=head1 NAME

CSS::Tiny - Object oriented interface to CSS stylesheets

=head1 VERSION

This document describes CSS::Tiny version 0.0.3

=head1 INTERFACE 

=head2 selectors

Returns a list of selector strings.

=head2 styles

Returns a list of style strings.

=head2 style

Returns a CSS::Tiny::Style object for given style.

=head1 AUTHOR

Simone Cesano  C<< <scesano@cpan.org> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2007, Simone Cesano C<< <scesano@cpan.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
