
package WTSI::DNAP::Warehouse::Schema::Result::PacBioRunWellMetric;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::PacBioRunWellMetric

=head1 DESCRIPTION

Status and run information by well and some basic QC data from SMRT Link

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

=head1 TABLE: C<pac_bio_run_well_metrics>

=cut

__PACKAGE__->table('pac_bio_run_well_metrics');

=head1 ACCESSORS

=head2 id_pac_bio_rw_metrics_tmp

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 id_pac_bio_product

  data_type: 'char'
  is_nullable: 0
  size: 64

Product id

=head2 pac_bio_run_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Lims specific identifier for the pacbio run

=head2 well_label

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The well identifier for the plate, A1-H12

=head2 qc_seq_state

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Current sequencing QC state

=head2 qc_seq_state_is_final

  data_type: 'tinyint'
  is_nullable: 1

A flag marking the sequencing QC state as final (1) or not final (0)

=head2 qc_seq_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

The date the current sequencing QC state was assigned

=head2 qc_seq

  data_type: 'tinyint'
  is_nullable: 1

The final sequencing QC outcome as 0(failed), 1(passed) or NULL

=head2 instrument_type

  data_type: 'varchar'
  is_nullable: 0
  size: 32

The instrument type e.g. Sequel

=head2 instrument_name

  data_type: 'varchar'
  is_nullable: 1
  size: 32

The instrument name e.g. SQ54097

=head2 chip_type

  data_type: 'varchar'
  is_nullable: 1
  size: 32

The chip type e.g. 8mChip

=head2 sl_hostname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

SMRT Link server hostname

=head2 sl_run_uuid

  data_type: 'varchar'
  is_nullable: 1
  size: 36

SMRT Link specific run uuid

=head2 ts_run_name

  data_type: 'varchar'
  is_nullable: 1
  size: 32

The PacBio run name

=head2 movie_name

  data_type: 'varchar'
  is_nullable: 1
  size: 32

The PacBio movie name

=head2 movie_minutes

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Movie time (collection time) in minutes

=head2 created_by

  data_type: 'varchar'
  is_nullable: 1
  size: 32

Created by user name recorded in SMRT Link

=head2 binding_kit

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Binding kit version

=head2 sequencing_kit

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Sequencing kit version

=head2 sequencing_kit_lot_number

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Sequencing Kit lot number

=head2 cell_lot_number

  data_type: 'varchar'
  is_nullable: 1
  size: 32

SMRT Cell Lot Number

=head2 ccs_execution_mode

  data_type: 'varchar'
  is_nullable: 1
  size: 32

The PacBio ccs exection mode e.g. OnInstument, OffInstument or None

=head2 include_kinetics

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 1

Include kinetics information where ccs is run

=head2 hifi_only_reads

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 1

CCS was run on the instrument and only HiFi reads were included in the export from the instrument

=head2 heteroduplex_analysis

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 1

Analysis has been run on the instrument to detect and resolve heteroduplex reads

=head2 loading_conc

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

SMRT Cell loading concentration (pM)

=head2 run_start

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of run started

=head2 run_complete

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of run complete

=head2 run_transfer_complete

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of run transfer complete

=head2 run_status

  data_type: 'varchar'
  is_nullable: 1
  size: 32

Last recorded status, primarily to explain runs not completed.

=head2 well_start

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of well started

=head2 well_complete

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of well complete

=head2 well_status

  data_type: 'varchar'
  is_nullable: 1
  size: 32

Last recorded status, primarily to explain wells not completed.

=head2 chemistry_sw_version

  data_type: 'varchar'
  is_nullable: 1
  size: 32

The PacBio chemistry software version

=head2 instrument_sw_version

  data_type: 'varchar'
  is_nullable: 1
  size: 32

The PacBio instrument software version

=head2 primary_analysis_sw_version

  data_type: 'varchar'
  is_nullable: 1
  size: 32

The PacBio primary analysis software version

=head2 control_num_reads

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

The number of control reads

=head2 control_concordance_mean

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [8,6]

The average concordance between the control raw reads and the control reference sequence

=head2 control_concordance_mode

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

The modal value from the concordance between the control raw reads and the control reference sequence

=head2 control_read_length_mean

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

The mean polymerase read length of the control reads

=head2 local_base_rate

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [8,6]

The average base incorporation rate, excluding polymerase pausing events

=head2 polymerase_read_bases

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

Calculated by multiplying the number of productive (P1) ZMWs by the mean polymerase read length

=head2 polymerase_num_reads

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

The number of polymerase reads

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

=head2 unique_molecular_bases

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

The unique molecular yield in bp

=head2 productive_zmws_num

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Number of productive ZMWs

=head2 p0_num

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Number of empty ZMWs with no high quality read detected

=head2 p1_num

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Number of ZMWs with a high quality read detected

=head2 p2_num

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Number of other ZMWs, signal detected but no high quality read

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

=head2 hifi_read_bases

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

The number of HiFi bases

=head2 hifi_num_reads

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

The number of HiFi reads

=head2 hifi_read_length_mean

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

The mean HiFi read length

=head2 hifi_read_quality_median

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

The median HiFi base quality

=head2 hifi_number_passes_mean

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

The mean number of passes per HiFi read

=head2 hifi_low_quality_read_bases

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

The number of HiFi bases filtered due to low quality (<Q20)

=head2 hifi_low_quality_num_reads

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

The number of HiFi reads filtered due to low quality (<Q20)

=head2 hifi_low_quality_read_length_mean

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

The mean length of HiFi reads filtered due to low quality (<Q20)

=head2 hifi_low_quality_read_quality_median

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

The median base quality of HiFi bases filtered due to low quality (<Q20)

=cut

__PACKAGE__->add_columns(
  'id_pac_bio_rw_metrics_tmp',
  { data_type => 'integer', is_auto_increment => 1, is_nullable => 0 },
  'id_pac_bio_product',
  { data_type => 'char', is_nullable => 0, size => 64 },
  'pac_bio_run_name',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'well_label',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'qc_seq_state',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'qc_seq_state_is_final',
  { data_type => 'tinyint', is_nullable => 1 },
  'qc_seq_date',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'qc_seq',
  { data_type => 'tinyint', is_nullable => 1 },
  'instrument_type',
  { data_type => 'varchar', is_nullable => 0, size => 32 },
  'instrument_name',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'chip_type',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'sl_hostname',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'sl_run_uuid',
  { data_type => 'varchar', is_nullable => 1, size => 36 },
  'ts_run_name',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'movie_name',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'movie_minutes',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'created_by',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'binding_kit',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'sequencing_kit',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'sequencing_kit_lot_number',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'cell_lot_number',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'ccs_execution_mode',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'include_kinetics',
  { data_type => 'tinyint', extra => { unsigned => 1 }, is_nullable => 1 },
  'hifi_only_reads',
  { data_type => 'tinyint', extra => { unsigned => 1 }, is_nullable => 1 },
  'heteroduplex_analysis',
  { data_type => 'tinyint', extra => { unsigned => 1 }, is_nullable => 1 },
  'loading_conc',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'run_start',
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
  'run_transfer_complete',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'run_status',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'well_start',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'well_complete',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'well_status',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'chemistry_sw_version',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'instrument_sw_version',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'primary_analysis_sw_version',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'control_num_reads',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'control_concordance_mean',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [8, 6],
  },
  'control_concordance_mode',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'control_read_length_mean',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'local_base_rate',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [8, 6],
  },
  'polymerase_read_bases',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'polymerase_num_reads',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'polymerase_read_length_mean',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'polymerase_read_length_n50',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_length_mean',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_length_n50',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'unique_molecular_bases',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'productive_zmws_num',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'p0_num',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'p1_num',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'p2_num',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
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
  'hifi_read_bases',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'hifi_num_reads',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'hifi_read_length_mean',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'hifi_read_quality_median',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'hifi_number_passes_mean',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'hifi_low_quality_read_bases',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'hifi_low_quality_num_reads',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'hifi_low_quality_read_length_mean',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'hifi_low_quality_read_quality_median',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_pac_bio_rw_metrics_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_pac_bio_rw_metrics_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<pac_bio_metrics_run_well>

=over 4

=item * L</pac_bio_run_name>

=item * L</well_label>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'pac_bio_metrics_run_well',
  ['pac_bio_run_name', 'well_label'],
);

=head2 C<pac_bio_rw_metrics_id_product>

=over 4

=item * L</id_pac_bio_product>

=back

=cut

__PACKAGE__->add_unique_constraint('pac_bio_rw_metrics_id_product', ['id_pac_bio_product']);

=head1 RELATIONS

=head2 pac_bio_product_metrics

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::PacBioProductMetric>

=cut

__PACKAGE__->has_many(
  'pac_bio_product_metrics',
  'WTSI::DNAP::Warehouse::Schema::Result::PacBioProductMetric',
  {
    'foreign.id_pac_bio_rw_metrics_tmp' => 'self.id_pac_bio_rw_metrics_tmp',
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2023-02-23 11:12:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ibpsNGR8Zp+PA0gTvmPUkw

our $VERSION = '0';

__PACKAGE__->meta->make_immutable;
1;

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

Copyright (C) 2021 Genome Research Limited

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

