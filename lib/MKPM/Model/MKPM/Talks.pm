package MKPM::Model::MKPM::Talks;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

=head1 NAME

MKPM::Model::MKPM::Talks - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

Tony Edwardson

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

sub talks {
	our $talks;
	do 'talks.pl';
	return $talks;
}
__PACKAGE__->meta->make_immutable;

1;
