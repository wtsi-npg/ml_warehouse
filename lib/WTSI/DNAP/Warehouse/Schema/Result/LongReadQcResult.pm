
package WTSI::DNAP::Warehouse::Schema::Result::LongReadQcResult;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::LongReadQcResult

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

=head1 TABLE: C<long_read_qc_result>

=cut

__PACKAGE__->table('long_read_qc_result');

=head1 ACCESSORS

=head2 id_long_read_qc_result_tmp

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 labware_barcode

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Barcode of the labware that was the source for the QC tests.

=head2 sample_id

  data_type: 'varchar'
  is_nullable: 0
  size: 255

External identifier for the sample(s).

=head2 assay_type

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Type of the QC test.

=head2 assay_type_key

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Unique identifier of the QC test.

=head2 units

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Unit of the value for example mg,ng etc

=head2 value

  data_type: 'varchar'
  is_nullable: 0
  size: 255

QC result value

=head2 id_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Identifier of the LIMS where QC was published from

=head2 id_long_read_qc_result_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 255

LIMS specific id for QC result

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

The date the qc_result was first created in LIMS

=head2 last_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

The date the qc_result was last updated in LIMS.

=head2 recorded_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of the latest warehouse update.

=head2 qc_status

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Status of the QC decision eg pass, fail etc

=head2 qc_status_decision_by

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Who made the QC status decision eg ToL, Long Read

=cut

__PACKAGE__->add_columns(
  'id_long_read_qc_result_tmp',
  { data_type => 'bigint', is_auto_increment => 1, is_nullable => 0 },
  'labware_barcode',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'sample_id',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'assay_type',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'assay_type_key',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'units',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'value',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'id_lims',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'id_long_read_qc_result_lims',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'created',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'last_updated',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'recorded_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'qc_status',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'qc_status_decision_by',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_long_read_qc_result_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_long_read_qc_result_tmp');


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2023-01-11 17:05:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HH5ToN9jXzAVaW1csHC0GQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration

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

Copyright (C) 2023 Genome Research Ltd.

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
