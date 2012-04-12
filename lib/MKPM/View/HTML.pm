package MKPM::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

MKPM::View::HTML - TT View for MKPM

=head1 DESCRIPTION

TT View for MKPM.

=head1 SEE ALSO

L<MKPM>

=head1 AUTHOR

Tony Edwardson

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
