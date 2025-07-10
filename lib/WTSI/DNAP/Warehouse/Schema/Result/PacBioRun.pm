
package WTSI::DNAP::Warehouse::Schema::Result::PacBioRun;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::PacBioRun

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

=head1 TABLE: C<pac_bio_run>

=cut

__PACKAGE__->table('pac_bio_run');

=head1 ACCESSORS

=head2 id_pac_bio_tmp

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

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

Sample id, see 'study.id_study_tmp'

=head2 id_pac_bio_run_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

Lims specific identifier for the pacbio run

=head2 pac_bio_run_uuid

  data_type: 'varchar'
  is_nullable: 1
  size: 36

Uuid identifier for the pacbio run

=head2 cost_code

  data_type: 'varchar'
  is_nullable: 0
  size: 20

Valid WTSI cost-code

=head2 id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 10

LIM system identifier

=head2 tag_identifier

  data_type: 'varchar'
  is_nullable: 1
  size: 30

Tag index within tag set, NULL if untagged

=head2 tag_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 50

Tag sequence for tag

=head2 tag_set_id_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 20

LIMs-specific identifier of the tag set for tag

=head2 tag_set_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

WTSI-wide tag set name for tag

=head2 tag2_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 tag2_set_id_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 tag2_set_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 tag2_identifier

  data_type: 'varchar'
  is_nullable: 1
  size: 30

=head2 plate_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 255

The human readable barcode for the plate loaded onto the machine

=head2 plate_uuid_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 36

The plate uuid

=head2 well_label

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The well identifier for the plate, A1-H12

=head2 well_uuid_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 36

The well uuid

=head2 pac_bio_library_tube_id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 255

LIMS specific identifier for originating library tube

=head2 pac_bio_library_tube_uuid

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The uuid for the originating library tube

=head2 pac_bio_library_tube_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The name of the originating library tube

=head2 pac_bio_library_tube_legacy_id

  data_type: 'integer'
  is_nullable: 1

Legacy library_id for backwards compatibility.

=head2 library_created_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of library creation

=head2 pac_bio_run_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Name of the run

=head2 pipeline_id_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 60

LIMS-specific pipeline identifier that unambiguously defines library type (eg. Sequel-v1, IsoSeq-v1)

=head2 comparable_tag_identifier

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 comparable_tag2_identifier

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 plate_number

  data_type: 'integer'
  is_nullable: 1

The number of the plate that goes onto the sequencing machine. Necessary as an identifier for multi-plate support.

=head2 pac_bio_library_tube_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 255

The barcode of the originating library tube

=cut

__PACKAGE__->add_columns(
  'id_pac_bio_tmp',
  { data_type => 'integer', is_auto_increment => 1, is_nullable => 0 },
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
  'id_pac_bio_run_lims',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
  'pac_bio_run_uuid',
  { data_type => 'varchar', is_nullable => 1, size => 36 },
  'cost_code',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
  'id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 10 },
  'tag_identifier',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
  'tag_sequence',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'tag_set_id_lims',
  { data_type => 'varchar', is_nullable => 1, size => 20 },
  'tag_set_name',
  { data_type => 'varchar', is_nullable => 1, size => 100 },
  'tag2_sequence',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'tag2_set_id_lims',
  { data_type => 'varchar', is_nullable => 1, size => 20 },
  'tag2_set_name',
  { data_type => 'varchar', is_nullable => 1, size => 100 },
  'tag2_identifier',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
  'plate_barcode',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'plate_uuid_lims',
  { data_type => 'varchar', is_nullable => 0, size => 36 },
  'well_label',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'well_uuid_lims',
  { data_type => 'varchar', is_nullable => 0, size => 36 },
  'pac_bio_library_tube_id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'pac_bio_library_tube_uuid',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'pac_bio_library_tube_name',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'pac_bio_library_tube_legacy_id',
  { data_type => 'integer', is_nullable => 1 },
  'library_created_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'pac_bio_run_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'pipeline_id_lims',
  { data_type => 'varchar', is_nullable => 1, size => 60 },
  'comparable_tag_identifier',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'comparable_tag2_identifier',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'plate_number',
  { data_type => 'integer', is_nullable => 1 },
  'pac_bio_library_tube_barcode',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_pac_bio_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_pac_bio_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<unique_pac_bio_entry>

=over 4

=item * L</id_lims>

=item * L</id_pac_bio_run_lims>

=item * L</well_label>

=item * L</comparable_tag_identifier>

=item * L</comparable_tag2_identifier>

=item * L</plate_number>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'unique_pac_bio_entry',
  [
    'id_lims',
    'id_pac_bio_run_lims',
    'well_label',
    'comparable_tag_identifier',
    'comparable_tag2_identifier',
    'plate_number',
  ],
);

=head1 RELATIONS

=head2 pac_bio_product_metrics

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::PacBioProductMetric>

=cut

__PACKAGE__->has_many(
  'pac_bio_product_metrics',
  'WTSI::DNAP::Warehouse::Schema::Result::PacBioProductMetric',
  { 'foreign.id_pac_bio_tmp' => 'self.id_pac_bio_tmp' },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8m4j5HXVJPZCbKPdPokivA


our $VERSION = '0';

=head2 get_tags

Returns an array containing tag_sequence and tag2_sequence values in that
order.  If no tag_sequence is present, but tag2_sequence is present, only
tag2_sequence will be in the array, this case is not expected to occur
frequently.

=cut

sub get_tags{
  my $self = shift;
  my $tags = [
    $self->tag_sequence?$self->tag_sequence:(),
    $self->tag2_sequence?$self->tag2_sequence:()
  ];
  return $tags;
}

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

Copyright (C) 2015,2017,2020,2021,2023 Genome Research Ltd.

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

