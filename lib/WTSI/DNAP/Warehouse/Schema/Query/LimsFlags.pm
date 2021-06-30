package WTSI::DNAP::Warehouse::Schema::Query::LimsFlags;

use Moose::Role;
use Readonly;

our $VERSION = '0';

Readonly::Scalar my $CLARITY_GCLP  => q[C_GCLP];
Readonly::Scalar my $SSCAPE        => q[SQSCP];

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Query::LimsFlags

=head1 SYNOPSIS

=head1 DESCRIPTION

A Moose role defining row-level methods for determining the origin of the data.

=head1 SUBROUTINES/METHODS

=head2 from_gclp

Returns true if the record originates from the GCLP LIMs.

=cut

sub from_gclp {
  my $self = shift;
  return $self->_is_from($CLARITY_GCLP);
}

=head2 from_sscape

Returns true if the record originates from the SSCAPE LIMs.

=cut

sub from_sscape {
  my $self = shift;
  return $self->_is_from($SSCAPE);
}

sub _is_from {
  my ($self, $flag) = @_;
  return $self->id_lims =~ /$flag/smx;
}

no Moose::Role;

1;
__END__


=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item Readonly

=item Moose::Role

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2015 Genome Research Ltd.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

=cut

