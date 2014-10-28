
package WTSI::DNAP::Warehouse::Schema::Result::IseqRunLaneMetric;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::IseqRunLaneMetric

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

=head1 TABLE: C<iseq_run_lane_metrics>

=cut

__PACKAGE__->table('iseq_run_lane_metrics');

=head1 ACCESSORS

=head2 id_iseq_lane_metrics_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

=head2 id_iseq_flowcell_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

Flowcell id, see 'iseq_flowcell.id_iseq_flowcell_tmp'

=head2 flowcell_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 15

Manufacturer flowcell barcode or other identifier as recorded by NPG

=head2 id_run

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

NPG run identifier

=head2 position

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 0

Flowcell lane number

=head2 instrument_name

  data_type: 'char'
  is_nullable: 1
  size: 32

=head2 instrument_model

  data_type: 'char'
  is_nullable: 1
  size: 64

=head2 paired_read

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 cycles

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 cancelled

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

Boolen flag to indicate whether the run was cancelled

=head2 run_pending

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of run pending status

=head2 run_complete

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of run complete status

=head2 qc_complete

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of qc complete status

=head2 pf_cluster_count

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_cluster_count

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_cluster_density

  data_type: 'double precision'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [12,3]

=head2 pf_cluster_density

  data_type: 'double precision'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [12,3]

=head2 pf_bases

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q20_yield_kb_forward_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q20_yield_kb_reverse_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q30_yield_kb_forward_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q30_yield_kb_reverse_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q40_yield_kb_forward_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q40_yield_kb_reverse_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 tags_decode_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 tags_decode_cv

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 adapters_percent_forward_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 adapters_percent_reverse_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 insert_size_quartile1

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 insert_size_quartile3

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 insert_size_median

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 ref_match1_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 ref_match1_percent

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 ref_match2_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 ref_match2_percent

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 gc_percent_forward_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 gc_percent_reverse_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 sequence_mismatch_percent_forward_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [4,2]

=head2 sequence_mismatch_percent_reverse_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [4,2]

=cut

__PACKAGE__->add_columns(
  'id_iseq_lane_metrics_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'id_iseq_flowcell_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  'flowcell_barcode',
  { data_type => 'varchar', is_nullable => 1, size => 15 },
  'id_run',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 0 },
  'position',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 0 },
  'instrument_name',
  { data_type => 'char', is_nullable => 1, size => 32 },
  'instrument_model',
  { data_type => 'char', is_nullable => 1, size => 64 },
  'paired_read',
  {
    data_type => 'tinyint',
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  'cycles',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 0 },
  'cancelled',
  {
    data_type => 'tinyint',
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  'run_pending',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'run_complete',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'qc_complete',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'pf_cluster_count',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'raw_cluster_count',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'raw_cluster_density',
  {
    data_type => 'double precision',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [12, 3],
  },
  'pf_cluster_density',
  {
    data_type => 'double precision',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [12, 3],
  },
  'pf_bases',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'q20_yield_kb_forward_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q20_yield_kb_reverse_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q30_yield_kb_forward_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q30_yield_kb_reverse_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q40_yield_kb_forward_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q40_yield_kb_reverse_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'tags_decode_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'tags_decode_cv',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'adapters_percent_forward_read',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'adapters_percent_reverse_read',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'insert_size_quartile1',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_size_quartile3',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_size_median',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'ref_match1_name',
  { data_type => 'varchar', is_nullable => 1, size => 100 },
  'ref_match1_percent',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'ref_match2_name',
  { data_type => 'varchar', is_nullable => 1, size => 100 },
  'ref_match2_percent',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'gc_percent_forward_read',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'gc_percent_reverse_read',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'sequence_mismatch_percent_forward_read',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [4, 2],
  },
  'sequence_mismatch_percent_reverse_read',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [4, 2],
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_iseq_lane_metrics_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_iseq_lane_metrics_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<iseq_rlm_run_position_index>

=over 4

=item * L</id_run>

=item * L</position>

=back

=cut

__PACKAGE__->add_unique_constraint('iseq_rlm_run_position_index', ['id_run', 'position']);

=head1 RELATIONS

=head2 iseq_flowcell

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell>

=cut

__PACKAGE__->belongs_to(
  'iseq_flowcell',
  'WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell',
  { id_iseq_flowcell_tmp => 'id_iseq_flowcell_tmp' },
  {
    is_deferrable => 1,
    join_type     => 'LEFT',
    on_delete     => 'SET NULL',
    on_update     => 'NO ACTION',
  },
);

=head2 iseq_product_metrics

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqProductMetric>

=cut

__PACKAGE__->has_many(
  'iseq_product_metrics',
  'WTSI::DNAP::Warehouse::Schema::Result::IseqProductMetric',
  {
    'foreign.id_run'   => 'self.id_run',
    'foreign.position' => 'self.position',
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-10-28 10:26:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9xW/5qnB/RlnGJIKObC9cg

our $VERSION = '0';

##no critic (ProhibitStringyEval ProhibitPostfixControls ProhibitInterpolationOfLiterals)
with 'npg_qc::autoqc::role::rpt_key' if eval "require npg_qc::autoqc::role::rpt_key";
##use critic

__PACKAGE__->meta->make_immutable;

1;
__END__

=head1 SYNOPSIS

=head1 DESCRIPTION

Result class definition in DBIx binding for the multi-lims warehouse database.

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 SUBROUTINES/METHODS

=head1 DEPENDENCIES

=over

=item strict

=item warnings

=item Moose

=item MooseX::NonMoose

=item MooseX::MarkAsMethods

=item DBIx::Class::Core

=item DBIx::Class::InflateColumn::DateTime

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia E<lt>mg8@sanger.ac.ukE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2014 Genome Research Limited

This file is part of the ml_warehouse package L<https://github.com/wtsi-npg/ml_warehouse>.

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
