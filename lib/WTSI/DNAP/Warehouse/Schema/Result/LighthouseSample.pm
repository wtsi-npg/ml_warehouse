
package WTSI::DNAP::Warehouse::Schema::Result::LighthouseSample;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::LighthouseSample

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

=head1 TABLE: C<lighthouse_sample>

=cut

__PACKAGE__->table('lighthouse_sample');

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 mongodb_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Auto-generated id from MongoDB

=head2 root_sample_id

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Id for this sample provided by the Lighthouse lab

=head2 cog_uk_id

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 cog_uk_id_unique

  data_type: 'tinyint'
  default_value: 1
  is_nullable: 1

A flag to indicate cog_uk_id should be unique. NULL allows reuse of the ID in another row.

=head2 rna_id

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Lighthouse lab-provided id made up of plate barcode and well

=head2 plate_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Barcode of plate sample arrived in, from rna_id

=head2 coordinate

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Well position from plate sample arrived in, from rna_id

=head2 result

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Covid-19 test result from the Lighthouse lab

=head2 date_tested_string

  data_type: 'varchar'
  is_nullable: 1
  size: 255

When the covid-19 test was carried out by the Lighthouse lab

=head2 date_tested

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

date_tested_string in date format

=head2 source

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Lighthouse centre that the sample came from

=head2 lab_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Id of the lab, within the Lighthouse centre

=head2 ch1_target

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ch1_result

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ch1_cq

  data_type: 'decimal'
  is_nullable: 1
  size: [11,8]

=head2 ch2_target

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ch2_result

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ch2_cq

  data_type: 'decimal'
  is_nullable: 1
  size: [11,8]

=head2 ch3_target

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ch3_result

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ch3_cq

  data_type: 'decimal'
  is_nullable: 1
  size: [11,8]

=head2 ch4_target

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ch4_result

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ch4_cq

  data_type: 'decimal'
  is_nullable: 1
  size: [11,8]

=head2 filtered_positive

  data_type: 'tinyint'
  is_nullable: 1

Filtered positive result value

=head2 filtered_positive_version

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Filtered positive version

=head2 filtered_positive_timestamp

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Filtered positive timestamp

=head2 lh_sample_uuid

  data_type: 'varchar'
  is_nullable: 1
  size: 36

Sample uuid created in crawler

=head2 lh_source_plate_uuid

  data_type: 'varchar'
  is_nullable: 1
  size: 36

Source plate uuid created in crawler

=head2 created_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

When this record was inserted

=head2 updated_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

When this record was last updated

=head2 must_sequence

  data_type: 'tinyint'
  is_nullable: 1

PAM provided value whether sample is of high importance

=head2 preferentially_sequence

  data_type: 'tinyint'
  is_nullable: 1

PAM provided value whether sample is important

=head2 is_current

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

Identifies if this sample has the most up to date information for the same rna_id

=head2 current_rna_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  'id',
  { data_type => 'integer', is_auto_increment => 1, is_nullable => 0 },
  'mongodb_id',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'root_sample_id',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'cog_uk_id',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'cog_uk_id_unique',
  { data_type => 'tinyint', default_value => 1, is_nullable => 1 },
  'rna_id',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'plate_barcode',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'coordinate',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'result',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'date_tested_string',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'date_tested',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'source',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'lab_id',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ch1_target',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ch1_result',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ch1_cq',
  { data_type => 'decimal', is_nullable => 1, size => [11, 8] },
  'ch2_target',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ch2_result',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ch2_cq',
  { data_type => 'decimal', is_nullable => 1, size => [11, 8] },
  'ch3_target',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ch3_result',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ch3_cq',
  { data_type => 'decimal', is_nullable => 1, size => [11, 8] },
  'ch4_target',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ch4_result',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ch4_cq',
  { data_type => 'decimal', is_nullable => 1, size => [11, 8] },
  'filtered_positive',
  { data_type => 'tinyint', is_nullable => 1 },
  'filtered_positive_version',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'filtered_positive_timestamp',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'lh_sample_uuid',
  { data_type => 'varchar', is_nullable => 1, size => 36 },
  'lh_source_plate_uuid',
  { data_type => 'varchar', is_nullable => 1, size => 36 },
  'created_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'updated_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'must_sequence',
  { data_type => 'tinyint', is_nullable => 1 },
  'preferentially_sequence',
  { data_type => 'tinyint', is_nullable => 1 },
  'is_current',
  { data_type => 'tinyint', default_value => 0, is_nullable => 0 },
  'current_rna_id',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key('id');

=head1 UNIQUE CONSTRAINTS

=head2 C<index_lighthouse_sample_on_cog_uk_id_and_cog_uk_id_unique>

=over 4

=item * L</cog_uk_id>

=item * L</cog_uk_id_unique>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'index_lighthouse_sample_on_cog_uk_id_and_cog_uk_id_unique',
  ['cog_uk_id', 'cog_uk_id_unique'],
);

=head2 C<index_lighthouse_sample_on_current_rna_id>

=over 4

=item * L</current_rna_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'index_lighthouse_sample_on_current_rna_id',
  ['current_rna_id'],
);

=head2 C<index_lighthouse_sample_on_lh_sample_uuid>

=over 4

=item * L</lh_sample_uuid>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'index_lighthouse_sample_on_lh_sample_uuid',
  ['lh_sample_uuid'],
);

=head2 C<index_lighthouse_sample_on_mongodb_id>

=over 4

=item * L</mongodb_id>

=back

=cut

__PACKAGE__->add_unique_constraint('index_lighthouse_sample_on_mongodb_id', ['mongodb_id']);

=head2 C<index_lighthouse_sample_on_root_sample_id_and_rna_id_and_result>

=over 4

=item * L</root_sample_id>

=item * L</rna_id>

=item * L</result>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'index_lighthouse_sample_on_root_sample_id_and_rna_id_and_result',
  ['root_sample_id', 'rna_id', 'result'],
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2023-01-11 17:05:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:biTpuTArvOWbpdvsuXUCZg

our $VERSION = '0';

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 SYNOPSIS

=head1 DESCRIPTION

Result class definition in DBIx binding for the multi-lims warehouse database.

=head2 Ct values

ch1_target, ch1_result, ch1_cq
ch2_target, ch2_result, ch2_cq
ch3_target, ch3_result, ch3_cq
ch4_target, ch4_result, ch4_cq

The 'target' is a gene, something like ORF1ab or E-Gene.
The 'result' is the result of the test, something like Positive,
Negative or Void.
The 'value' is the actual Ct/Cq value.

Not all lighthouse sample have these values defined. One of the genes is an
extraction control gene MS2

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

Copyright (C) 2021, 2022 Genome Research Ltd.

This file is part of the ml_warehouse package
L<https://github.com/wtsi-npg/ml_warehouse>.

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
