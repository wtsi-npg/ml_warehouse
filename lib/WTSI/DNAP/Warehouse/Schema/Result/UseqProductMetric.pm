
package WTSI::DNAP::Warehouse::Schema::Result::UseqProductMetric;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::UseqProductMetric

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

=head1 TABLE: C<useq_product_metrics>

=cut

__PACKAGE__->table('useq_product_metrics');

=head1 ACCESSORS

=head2 id_useq_pr_metrics_tmp

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

=head2 id_useq_wafer_tmp

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

Foreign key, see 'useq_wafer.id_useq_wafer_tmp'

=head2 id_run

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

NPG run identifier

=head2 tag_index

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

NPG tag index

=head2 id_useq_product

  data_type: 'char'
  is_nullable: 0
  size: 64

Product id

=head2 is_sequencing_control

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 1

A boolean flag. If true, this is an internal control

=head2 ultimagen_index_label

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Ultimagen barcode label

=head2 ultimagen_index_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Ultimagen barcode sequence

=head2 ultimagen_sample_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Name the sample is deplexed under by Ultimagen Genomics, see also ultima:Sample_ID iRODS metadata

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

Number of reads on a wafer assigned to this library after deplexing

=head2 tag_decode_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

Percent of reads on a wafer, which is assigned to this library after deplexing

=head2 q20_yield_kb

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Yield in KBs at and above Q20

=head2 q30_yield_kb

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Yield in KBs at and above Q30

=head2 total_yield_kb

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Overall sample yield in KBs

=cut

__PACKAGE__->add_columns(
  'id_useq_pr_metrics_tmp',
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
  'id_useq_wafer_tmp',
  { data_type => 'bigint', is_foreign_key => 1, is_nullable => 1 },
  'id_run',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  'tag_index',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'id_useq_product',
  { data_type => 'char', is_nullable => 0, size => 64 },
  'is_sequencing_control',
  { data_type => 'tinyint', default_value => 0, is_nullable => 1 },
  'ultimagen_index_label',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ultimagen_index_sequence',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ultimagen_sample_id',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
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
  'q20_yield_kb',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q30_yield_kb',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'total_yield_kb',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_useq_pr_metrics_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_useq_pr_metrics_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<useq_prm_product_unique>

=over 4

=item * L</id_useq_product>

=back

=cut

__PACKAGE__->add_unique_constraint('useq_prm_product_unique', ['id_useq_product']);

=head1 RELATIONS

=head2 run

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::UseqRunMetric>

=cut

__PACKAGE__->belongs_to(
  'run',
  'WTSI::DNAP::Warehouse::Schema::Result::UseqRunMetric',
  { id_run => 'id_run' },
  { is_deferrable => 1, on_delete => 'CASCADE', on_update => 'RESTRICT' },
);

=head2 useq_wafer

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::UseqWafer>

=cut

__PACKAGE__->belongs_to(
  'useq_wafer',
  'WTSI::DNAP::Warehouse::Schema::Result::UseqWafer',
  { id_useq_wafer_tmp => 'id_useq_wafer_tmp' },
  {
    is_deferrable => 1,
    join_type     => 'LEFT',
    on_delete     => 'SET NULL',
    on_update     => 'RESTRICT',
  },
);


# Created by DBIx::Class::Schema::Loader v0.07053 @ 2025-11-19 19:16:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lpcmKPLzwN7tA7WYIbAiJg


# You can replace this text with custom code or comments, and it will be preserved on regeneration

our $VERSION = '0';

__PACKAGE__->meta->make_immutable;

1;

=head1 SUBROUTINES/METHODS

=head1 SYNOPSIS

=head1 DESCRIPTION

DBIx model for useq_product_metrics, which contains product-level data for
runs performed on Ultima Genomics instruments.

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item Moose

=item MooseX::NonMoose

=item MooseX::MarkAsMethods

=item MooseX::Aliases

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
