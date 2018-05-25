
package WTSI::DNAP::Warehouse::Schema::Result::PacBioRunMetric;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::PacBioRunMetric

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

=head1 TABLE: C<pac_bio_run_metrics>

=cut

__PACKAGE__->table('pac_bio_run_metrics');

=head1 ACCESSORS

=head2 id_pac_bio_run_metrics_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

=head2 id_pac_bio_run_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

Lims specific identifier for the pacbio run

=head2 well_label

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The well identifier for the plate, A1-H12

=head2 instrument_type

  data_type: 'varchar'
  is_nullable: 0
  size: 20

The instrument type e.g. Sequel

=head2 instrument_name

  data_type: 'varchar'
  is_nullable: 1
  size: 32

The instrument name e.g. SQ54097

=head2 run_started

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of run started

=head2 run_completed

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of run complete

=head2 estimated_yield_kb

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Calculated by multiplying the number of productive (P1) ZMWs by the mean polymerase read length - in kb

=head2 num_reads

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 adapter_dimer_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

The percentage of pre-filter ZMWs which have observed inserts of 0-10 bp

=head2 short_insert_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

The percentage of pre-filter ZMWs which have observed inserts of 11-100 bp

=head2 p0_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

Empty ZMW with no high quality read detected

=head2 p1_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

ZMW with a high quality read detected

=head2 p2_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

Other, signal detected but no high quality read

=head2 polymerase_read_length_mean

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

The mean high-quality read length of all polymerase reads

=head2 polymerase_read_length_n50

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Fifty percent of the trimmed read length of all polymerase reads are longer than this value

=head2 insert_length_mean

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

The average subread length, considering only the longest subread from each ZMW

=head2 insert_length_n50

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Fifty percent of the subreads are longer than this value when considering only the longest subread from each ZMW

=cut

__PACKAGE__->add_columns(
  'id_pac_bio_run_metrics_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'id_pac_bio_run_lims',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
  'well_label',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'instrument_type',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
  'instrument_name',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'run_started',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'run_completed',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'estimated_yield_kb',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'num_reads',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'adapter_dimer_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'short_insert_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'p0_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'p1_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'p2_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'polymerase_read_length_mean',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'polymerase_read_length_n50',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_length_mean',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_length_n50',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_pac_bio_run_metrics_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_pac_bio_run_metrics_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<pac_run_metrics_run_well_index>

=over 4

=item * L</id_pac_bio_run_lims>

=item * L</well_label>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'pac_run_metrics_run_well_index',
  ['id_pac_bio_run_lims', 'well_label'],
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2018-05-25 14:33:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fazLHBSSCpmshMTkBn8P+g


our $VERSION = '0';

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

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2018 Genome Research Limited

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

