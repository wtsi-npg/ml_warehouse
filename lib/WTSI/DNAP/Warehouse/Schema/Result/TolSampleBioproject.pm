
package WTSI::DNAP::Warehouse::Schema::Result::TolSampleBioproject;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::TolSampleBioproject

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

=head1 TABLE: C<tol_sample_bioproject>

=cut

__PACKAGE__->table('tol_sample_bioproject');

=head1 ACCESSORS

=head2 id_tsb_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 id_sample_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

=head2 file

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 library_type

  data_type: 'enum'
  extra: {list => ['Chromium genome','Haplotagging','Hi-C','Hi-C - Arima v1','Hi-C - Arima v2','Hi-C - Dovetail','Hi-C - Omni-C','Hi-C - Qiagen','PacBio - CLR','PacBio - HiFi','ONT','RNA PolyA','RNA-seq dUTP eukaryotic','Standard','unknown','HiSeqX PCR free','PacBio - HiFi (ULI)','PacBio - IsoSeq','ATAC-seq']}
  is_nullable: 1

=head2 tolid

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 biosample_accession

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 bioproject_accession

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 date_added

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 date_updated

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 filename

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  'id_tsb_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'id_sample_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  'file',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'library_type',
  {
    data_type => 'enum',
    extra => {
      list => [
        'Chromium genome',
        'Haplotagging',
        'Hi-C',
        'Hi-C - Arima v1',
        'Hi-C - Arima v2',
        'Hi-C - Dovetail',
        'Hi-C - Omni-C',
        'Hi-C - Qiagen',
        'PacBio - CLR',
        'PacBio - HiFi',
        'ONT',
        'RNA PolyA',
        'RNA-seq dUTP eukaryotic',
        'Standard',
        'unknown',
        'HiSeqX PCR free',
        'PacBio - HiFi (ULI)',
        'PacBio - IsoSeq',
        'ATAC-seq',
      ],
    },
    is_nullable => 1,
  },
  'tolid',
  { data_type => 'varchar', is_nullable => 1, size => 40 },
  'biosample_accession',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'bioproject_accession',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'date_added',
  {
    data_type => 'timestamp',
    datetime_undef_if_invalid => 1,
    default_value => \'current_timestamp',
    is_nullable => 0,
  },
  'date_updated',
  {
    data_type => 'timestamp',
    datetime_undef_if_invalid => 1,
    default_value => \'current_timestamp',
    is_nullable => 0,
  },
  'filename',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_tsb_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_tsb_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<tol_sample_bioproject_file_index>

=over 4

=item * L</file>

=back

=cut

__PACKAGE__->add_unique_constraint('tol_sample_bioproject_file_index', ['file']);

=head1 RELATIONS

=head2 sample

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::Sample>

=cut

__PACKAGE__->belongs_to(
  'sample',
  'WTSI::DNAP::Warehouse::Schema::Result::Sample',
  { id_sample_tmp => 'id_sample_tmp' },
  {
    is_deferrable => 1,
    join_type     => 'LEFT',
    on_delete     => 'SET NULL',
    on_update     => 'RESTRICT',
  },
);


# Created by DBIx::Class::Schema::Loader v0.07052 @ 2024-10-09 15:42:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:P7s1muBNrElt8Hd3xqTL3w

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
