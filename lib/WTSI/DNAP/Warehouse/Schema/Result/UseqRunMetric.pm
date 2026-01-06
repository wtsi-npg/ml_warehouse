
package WTSI::DNAP::Warehouse::Schema::Result::UseqRunMetric;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::UseqRunMetric

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

=head1 TABLE: C<useq_run_metrics>

=cut

__PACKAGE__->table('useq_run_metrics');

=head1 ACCESSORS

=head2 last_changed

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

Date this record was created or changed

=head2 id_run

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

NPG run identifier

=head2 ultimagen_run_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Ultimagen  RunID

=head2 ultimagen_library_pool

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Ultimagen  Library_Pool

=head2 instrument_name

  data_type: 'char'
  is_nullable: 0
  size: 32

Instrument name in NPG tracking system

=head2 instrument_external_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Name assigned to the instrument by the manufacturer

=head2 instrument_model

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Instrument model

=head2 run_folder_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Instrument run folder name

=head2 run_priority

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 cancelled

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

Boolean flag to indicate whether the run was failed in some way or its data has been discarded

=head2 run_in_progress

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of run in progress status

=head2 run_archived

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

The date the run was released, ie QC-ed if applicable and fully archived

=head2 qc_seq

  data_type: 'tinyint'
  is_nullable: 1

Sequencing lane level QC outcome, a result of either manual or automatic assessment by core

=head2 num_reads

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

Number of reads for this wafer

=head2 input_num_reads

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

Number of input reads (before PF) for this wafer

=head2 tags_decode_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

An overall percent of pf reads assigned to expected barcodes and the control

=cut

__PACKAGE__->add_columns(
  'last_changed',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    default_value => 'CURRENT_TIMESTAMP',
    is_nullable => 1,
  },
  'id_run',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 0 },
  'ultimagen_run_id',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ultimagen_library_pool',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'instrument_name',
  { data_type => 'char', is_nullable => 0, size => 32 },
  'instrument_external_name',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'instrument_model',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'run_folder_name',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'run_priority',
  { data_type => 'tinyint', extra => { unsigned => 1 }, is_nullable => 1 },
  'cancelled',
  {
    data_type => 'tinyint',
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  'run_in_progress',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'run_archived',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'qc_seq',
  { data_type => 'tinyint', is_nullable => 1 },
  'num_reads',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'input_num_reads',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'tags_decode_percent',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_run>

=back

=cut

__PACKAGE__->set_primary_key('id_run');

=head1 RELATIONS

=head2 useq_product_metrics

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::UseqProductMetric>

=cut

__PACKAGE__->has_many(
  'useq_product_metrics',
  'WTSI::DNAP::Warehouse::Schema::Result::UseqProductMetric',
  { 'foreign.id_run' => 'self.id_run' },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07053 @ 2025-11-19 19:16:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RsottGX+x0akttPB33HfVA


# You can replace this text with custom code or comments, and it will be preserved on regeneration

our $VERSION = '0';

__PACKAGE__->meta->make_immutable;

1;

=head1 SUBROUTINES/METHODS

=head1 SYNOPSIS

=head1 DESCRIPTION

DBIx model for useq_run_metrics, which contains run-level information for
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

