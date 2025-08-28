
package WTSI::DNAP::Warehouse::Schema::Result::EseqFlowcell;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::EseqFlowcell

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components('InflateColumn::DateTime');

=head1 TABLE: C<eseq_flowcell>

=cut

__PACKAGE__->table('eseq_flowcell');

=head1 ACCESSORS

=head2 id_eseq_flowcell_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database, id value can change

=head2 id_flowcell_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 255

LIMs-specific flowcell id, batch_id for Sequencescape

=head2 last_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of last update

=head2 recorded_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of warehouse update

=head2 id_sample_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

Sample id, see 'sample.id_sample_tmp'

=head2 id_study_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

Study id, see 'study.id_study_tmp'

=head2 id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 10

LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE

=head2 lane

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 0

Flowcell lane number, 1 or 2

=head2 entity_type

  data_type: 'varchar'
  is_nullable: 0
  size: 30

Library type: library_indexed, library_indexed_spike

=head2 tag_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 30

Tag sequence

=head2 tag2_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 30

Tag sequence for tag 2

=head2 pipeline_id_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 60

LIMs-specific pipeline identifier that unambiguously defines library type

=head2 bait_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

WTSI-wide name that uniquely identifies a bait set

=head2 requested_insert_size_from

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Requested insert size min value

=head2 requested_insert_size_to

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Requested insert size max value

=head2 id_pool_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

Most specific LIMs identifier associated with the pool

=head2 id_library_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Earliest LIMs identifier associated with library creation

=head2 primer_panel

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Primer Panel name

=head2 entity_id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

Most specific LIMs identifier associated with this lane or plex or spike

=cut

__PACKAGE__->add_columns(
  'id_eseq_flowcell_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'id_flowcell_lims',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'last_updated',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  'recorded_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  'id_sample_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  'id_study_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  'id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 10 },
  'lane',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 0 },
  'entity_type',
  { data_type => 'varchar', is_nullable => 0, size => 30 },
  'tag_sequence',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
  'tag2_sequence',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
  'pipeline_id_lims',
  { data_type => 'varchar', is_nullable => 1, size => 60 },
  'bait_name',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'requested_insert_size_from',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'requested_insert_size_to',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'id_pool_lims',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
  'id_library_lims',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'primer_panel',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'entity_id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_eseq_flowcell_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_eseq_flowcell_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<index_eseq_flowcell_on_composition_keys>

=over 4

=item * L</id_flowcell_lims>

=item * L</lane>

=item * L</tag_sequence>

=item * L</tag2_sequence>

=item * L</id_lims>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'index_eseq_flowcell_on_composition_keys',
  [
    'id_flowcell_lims',
    'lane',
    'tag_sequence',
    'tag2_sequence',
    'id_lims',
  ],
);

=head1 RELATIONS

=head2 eseq_product_metrics

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::EseqProductMetric>

=cut

__PACKAGE__->has_many(
  'eseq_product_metrics',
  'WTSI::DNAP::Warehouse::Schema::Result::EseqProductMetric',
  { 'foreign.id_eseq_flowcell_tmp' => 'self.id_eseq_flowcell_tmp' },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sample

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::Sample>

=cut

__PACKAGE__->belongs_to(
  'sample',
  'WTSI::DNAP::Warehouse::Schema::Result::Sample',
  { id_sample_tmp => 'id_sample_tmp' },
  { is_deferrable => 1, on_delete => 'RESTRICT', on_update => 'RESTRICT' },
);

=head2 study

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::Study>

=cut

__PACKAGE__->belongs_to(
  'study',
  'WTSI::DNAP::Warehouse::Schema::Result::Study',
  { id_study_tmp => 'id_study_tmp' },
  { is_deferrable => 1, on_delete => 'RESTRICT', on_update => 'RESTRICT' },
);


# Created by DBIx::Class::Schema::Loader v0.07053 @ 2025-07-09 15:17:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vvf9oJQUIOq8HbHoq4ioOg


# You can replace this text with custom code or comments, and it will be preserved on regeneration

use Readonly;

our $VERSION = '0';

=head1 SUBROUTINES/METHODS

=head2 sample_id

=head2 sample_name

=head2 sample_supplier_name

=head2 study_name

=cut

#####
# Delegations below are provided to ensure compatibility with SeqQC viewer code.
#

Readonly my %DELEGATION_TO_SAMPLE => {
    'sample_id'                => 'id_sample_lims',
    'sample_name'              => 'name',
    'sample_supplier_name'     => 'supplier_name',
};

Readonly my %DELEGATION_TO_STUDY => {
    'study_name'                          => 'name',
};

foreach my $rel (qw(sample study)) {

  my $attr = q[_] . $rel . q[_row];
  my $del  = $rel eq 'sample' ? \%DELEGATION_TO_SAMPLE : \%DELEGATION_TO_STUDY;

  has $attr => ( isa        => 'Maybe[WTSI::DNAP::Warehouse::Schema::Result::' . ucfirst $rel . ']',
                 is         => 'ro',
                 weak_ref   => 1,
                 lazy_build => 1,
                 handles    => $del,
  );

  __PACKAGE__->meta->add_method('_build_' . $attr, sub {my $r = shift; return $r->$rel;} );

  foreach my $method ( keys %{$del} ) {
    around $method => sub {
      my ($orig, $self) = @_;
      return $self->$attr ? $self->$orig() : undef;
    };
  }
}

__PACKAGE__->meta->make_immutable;

1;

=head1 SYNOPSIS

=head1 DESCRIPTION

DBIx model for C<eseq_flowcell> table, which contains LIMS data for
Element Biosciences flowcells.

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item Moose

=item MooseX::NonMoose

=item MooseX::MarkAsMethods

=item DBIx::Class::Core

=item Readonly

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia E<lt>mg8@sanger.ac.ukE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2025 Genome Research Ltd.

This file is part of NPG.

NPG is free software: you can redistribute it and/or modify
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
