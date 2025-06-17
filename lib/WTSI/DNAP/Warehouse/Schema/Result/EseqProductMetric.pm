
package WTSI::DNAP::Warehouse::Schema::Result::EseqProductMetric;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::EseqProductMetric

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

=head1 TABLE: C<eseq_product_metrics>

=cut

__PACKAGE__->table('eseq_product_metrics');

=head1 ACCESSORS

=head2 id_eseq_pr_metrics_tmp

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

=head2 last_changed

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

Date this record was created or changed

=head2 id_eseq_product

  data_type: 'char'
  is_nullable: 0
  size: 64

Product id

=head2 id_eseq_flowcell_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

Foreign key, see 'eseq_flowcell.id_eseq_flowcell_tmp'

=head2 id_run

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

NPG run identifier

=head2 lane

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

Flowcell lane number

=head2 tag_index

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Lane-specific sequential unique index for a set of barcodes used to tag libraries derived from the same sample

=head2 eseq_composition_tmp

  data_type: 'varchar'
  is_nullable: 1
  size: 600

JSON representation of the composition object, the column might be deleted in future

=head2 elembio_samplename

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Name the sample is deplexed under by Element Biosciences software, corresponds to elembio:SampleName iRODS metadata

=head2 elembio_project

  data_type: 'varchar'
  is_nullable: 1
  size: 10

Project record for this library in Elembio output files. Ideally should correspond to study.id_study_lims

=head2 is_sequencing_control

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 1

A boolean flag. If true, this is PhiX control library

=head2 tag_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 30

Tag sequence used for deplexing the lane data, I1 read

=head2 tag2_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 30

Tag sequence used for deplexing the lane data, I2 read

=head2 qc_seq

  data_type: 'tinyint'
  is_nullable: 1

Sequencing lane level QC outcome, a result of either manual or automatic assessment by core

=head2 qc_lib

  data_type: 'tinyint'
  is_nullable: 1

Library QC outcome, a result of either manual or automatic assessment by core

=head2 qc

  data_type: 'tinyint'
  is_nullable: 1

Overall QC assessment outcome, a logical product (conjunction) of qc_seq and qc_lib values, defaults to the qc_seq value when qc_lib is not defined

=head2 tag_decode_count

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

Number of polonies (reads) assigned to this library after deplexing

=head2 tag_decode_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

Percent of polonies (reads) in a lane, which is assigned to this library after deplexing

=cut

__PACKAGE__->add_columns(
  'id_eseq_pr_metrics_tmp',
  {
    data_type => 'bigint',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'last_changed',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    default_value => 'CURRENT_TIMESTAMP',
    is_nullable => 1,
  },
  'id_eseq_product',
  { data_type => 'char', is_nullable => 0, size => 64 },
  'id_eseq_flowcell_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  'id_run',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  'lane',
  {
    data_type => 'smallint',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  'tag_index',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'eseq_composition_tmp',
  { data_type => 'varchar', is_nullable => 1, size => 600 },
  'elembio_samplename',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'elembio_project',
  { data_type => 'varchar', is_nullable => 1, size => 10 },
  'is_sequencing_control',
  { data_type => 'tinyint', default_value => 0, is_nullable => 1 },
  'tag_sequence',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
  'tag2_sequence',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
  'qc_seq',
  { data_type => 'tinyint', is_nullable => 1 },
  'qc_lib',
  { data_type => 'tinyint', is_nullable => 1 },
  'qc',
  { data_type => 'tinyint', is_nullable => 1 },
  'tag_decode_count',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'tag_decode_percent',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_eseq_pr_metrics_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_eseq_pr_metrics_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<eseq_pr_metrics_product_tagseq_unique>

=over 4

=item * L</id_eseq_product>

=item * L</tag_sequence>

=item * L</tag2_sequence>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'eseq_pr_metrics_product_tagseq_unique',
  ['id_eseq_product', 'tag_sequence', 'tag2_sequence'],
);

=head1 RELATIONS

=head2 eseq_flowcell

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::EseqFlowcell>

=cut

__PACKAGE__->belongs_to(
  'eseq_flowcell',
  'WTSI::DNAP::Warehouse::Schema::Result::EseqFlowcell',
  { id_eseq_flowcell_tmp => 'id_eseq_flowcell_tmp' },
  {
    is_deferrable => 1,
    join_type     => 'LEFT',
    on_delete     => 'SET NULL',
    on_update     => 'RESTRICT',
  },
);

=head2 eseq_run_lane_metric

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::EseqRunLaneMetric>

=cut

__PACKAGE__->belongs_to(
  'eseq_run_lane_metric',
  'WTSI::DNAP::Warehouse::Schema::Result::EseqRunLaneMetric',
  { id_run => 'id_run', lane => 'lane' },
  {
    is_deferrable => 1,
    join_type     => 'LEFT',
    on_delete     => 'CASCADE',
    on_update     => 'RESTRICT',
  },
);


# Created by DBIx::Class::Schema::Loader v0.07053 @ 2025-06-20 15:03:34
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tsd2HFu8VL69Q5TDkNC5gg


# You can replace this text with custom code or comments, and it will be preserved on regeneration

our $VERSION = '0';

__PACKAGE__->meta->make_immutable;

1;

=head1 SYNOPSIS

=head1 DESCRIPTION

DBIx model for eseq_product_metrics table, represents sequencing data products
from sequencing on Element Biosciences instruments.

=head1 CONFIGURATION AND ENVIRONMENT

=head1 SUBROUTINES/METHODS

=head1 DEPENDENCIES

=over

=item Moose

=item MooseX::NonMoose

=item MooseX::MarkAsMethods

=item DBIx::Class::Core

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
