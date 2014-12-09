package WTSI::DNAP::Warehouse::Schema::Query::IseqFlowcell;

use Moose::Role;
use Carp;
use Readonly;

requires 'iseq_flowcell';

our $VERSION = '0';

Readonly::Scalar our $NON_INDEXED_LIBRARY      => q[library];
Readonly::Scalar our $CONTROL_LANE             => q[library_control];
Readonly::Scalar our $INDEXED_LIBRARY          => q[library_indexed];
Readonly::Scalar our $INDEXED_LIBRARY_SPIKE    => q[library_indexed_spike];

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Query::IseqFlowcell

=head1 SYNOPSIS

=head1 DESCRIPTION

A Moose role for retrieving flowcell rows.

=head1 SUBROUTINES/METHODS

=head2 id_flowcell_lims

LIMs specific flowcell id

=cut

has 'id_flowcell_lims'           => ( isa       => 'Maybe[Num]',
                                      is        => 'ro',
                                      required  => 0,
);

=head2 id_flowcell_manufacturer

Manufacturer flowcell id

=cut

has 'id_flowcell_manufacturer'  => ( isa        => 'Maybe[Str]',
                                     is         => 'ro',
                                     required   => 0,
);

=head2 query_resultset

DBIx resultset returned by the query
Readonly::Scalar my $FLOWCELL_LIMS_TABLE_NAME => q[IseqFlowcell];

=cut

has 'query_resultset'  => ( isa        => 'DBIx::Class::ResultSet',
                            is         => 'ro',
                            required   => 0,
                            lazy_build => 1,
                            clearer    => 'free_query_resultset',
);
sub _build_query_resultset {
  my $self = shift;

  if (!$self->id_flowcell_lims && !$self->id_flowcell_manufacturer) {
    croak q[Either id_flowcell_lim or flowcell_barcode should be defined];
  }

  my $query = $self->id_flowcell_lims ?
    {'id_flowcell_lims' => $self->id_flowcell_lims} :
    {'flowcell_barcode' => $self->id_flowcell_manufacturer};

  if ($self->can('position') && $self->position) {
    $query->{'position'} = $self->position;
  }

  return $self->iseq_flowcell->search(
    $query, {'order_by' => [qw(position tag_index)]});
}

no Moose::Role;

1;
__END__


=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item Carp

=item Readonly

=item Moose

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2014 Genome Research Limited

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

