
package WTSI::DNAP::Warehouse::Schema::Result::IseqExternalProductMetric;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::IseqExternalProductMetric - Externally computed metrics for data sequenced at WSI

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

=head1 TABLE: C<iseq_external_product_metrics>

=cut

__PACKAGE__->table('iseq_external_product_metrics');

=head1 ACCESSORS

=head2 id_iseq_ext_pr_metrics_tmp

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

Datetime this record was created

=head2 last_changed

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

Datetime this record was created or changed

=head2 supplier_sample_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Sample name given by the supplier, as recorded by WSI

=head2 plate_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Stock plate barcode, as recorded by WSI

=head2 library_id

  data_type: 'integer'
  is_nullable: 1

WSI library identifier

=head2 file_name

  data_type: 'varchar'
  is_nullable: 0
  size: 300

Comma-delimitered alphabetically sorted list of file names, which unambigiously define WSI sources of data

=head2 file_path

  data_type: 'varchar'
  is_nullable: 0
  size: 760

Comma-delimitered alphabetically sorted list of full external file paths for the files in file_names column as uploaded by WSI

=head2 md5_staging

  data_type: 'char'
  is_nullable: 1
  size: 32

WSI validation hex MD5, not set for multiple source files

=head2 manifest_upload_status

  data_type: 'char'
  is_nullable: 1
  size: 15

WSI manifest upload status, one of 'IN PROGRESS', 'DONE', 'FAIL', not set for multiple source files

=head2 manifest_upload_status_change_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Date the status of manifest upload is changed by WSI

=head2 id_iseq_product

  data_type: 'char'
  is_nullable: 1
  size: 64

product id

=head2 iseq_composition_tmp

  data_type: 'varchar'
  is_nullable: 1
  size: 600

JSON representation of the composition object, the column might be deleted in future

=head2 id_iseq_pr_metrics_tmp

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

An optional foreign key for a record in iseq_product_metrics if this row and the row in the product table is for the same product

=head2 id_archive_product

  data_type: 'char'
  is_nullable: 1
  size: 64

Archive ID for data product

=head2 processing_status

  data_type: 'char'
  is_nullable: 1
  size: 15

One of 'PASS', 'HOLD', 'INSUFFICIENT', 'FAIL'

=head2 qc_overall_assessment

  data_type: 'char'
  is_nullable: 1
  size: 4

Final data product criteria evaluation outcome as 'PASS' or 'FAIL'

=head2 qc_status

  data_type: 'char'
  is_nullable: 1
  size: 15

One of 'PASS', 'HOLD', 'INSUFFICIENT', 'FAIL'

=head2 sequencing_start_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Sequencing start date obtained from the CRAM file header, not set for multiple source files

=head2 upload_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Upload date, not set for multiple source files

=head2 md5_validation_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Date of MD5 validation, not set for multiple source files

=head2 processing_start_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Processing start date

=head2 analysis_start_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 analysis_end_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 archival_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Date made available or pushed to archive service

=head2 archive_conformation_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Date of confirmation of integrity of data products by archive service

=head2 md5

  data_type: 'char'
  is_nullable: 1
  size: 32

External validation hex MD5, not set for multiple source files

=head2 md5_validation

  data_type: 'char'
  is_nullable: 1
  size: 4

Outcome of MD5 validation as 'PASS' or 'FAIL', not set for multiple source files

=head2 format_validation

  data_type: 'char'
  is_nullable: 1
  size: 4

Outcome of format validation as 'PASS' or 'FAIL', not set for multiple source files

=head2 upload_status

  data_type: 'char'
  is_nullable: 1
  size: 4

Upload status as 'PASS' or 'FAIL', 'PASS' if both MD5 and format validation are 'PASS', not set for multiple source files

=head2 instrument_id

  data_type: 'varchar'
  is_nullable: 1
  size: 256

Comma separated sorted list of instrument IDs obtained from the CRAM file header(s)

=head2 flowcell_id

  data_type: 'varchar'
  is_nullable: 1
  size: 256

Comma separated sorted list of flowcell IDs obtained from the CRAM file header(s)

=head2 annotation

  data_type: 'varchar'
  is_nullable: 1
  size: 256

annotation regarding data provenance, i.e. is sequence data from first pass, re-run, top-up etc.

=head2 min_read_length

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 1

Minimum read length observed in the data file

=head2 target_autosome_coverage_threshold

  data_type: 'integer'
  default_value: 15
  extra: {unsigned => 1}
  is_nullable: 1

Target autosome coverage threshold, defaults to 15

=head2 target_autosome_gt_coverage_threshold

  data_type: 'float'
  is_nullable: 1

Coverage percent at >= target_autosome_coverage_threshold X as a fraction

=head2 target_autosome_gt_coverage_threshold_assessment

  data_type: 'char'
  is_nullable: 1
  size: 4

'PASS' if target_autosome_percent_gt_coverage_threshold > 95%, 'FAIL' otherwise

=head2 verify_bam_id_score

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

FREEMIX value of sample contamination levels as a fraction

=head2 verify_bam_id_score_assessment

  data_type: 'char'
  is_nullable: 1
  size: 4

'PASS' if verify_bam_id_score > 0.01, 'FAIL' otherwise

=head2 double_error_fraction

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

Fraction of marker pairs with two read pairs evidencing parity and non-parity, may only be calculated if 1% <= verify_bam_id_score < 5%

=head2 contamination_assessment

  data_type: 'char'
  is_nullable: 1
  size: 4

'PASS' or 'FAIL' based on verify_bam_id_score_assessment and double_error_fraction < 0.2%

=head2 yield

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

sequence data quantity (Gb)

=head2 yield_q20

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 yield_q30

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 num_reads

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

Number of reads

=head2 gc_fraction_forward_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 gc_fraction_reverse_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 adapter_contamination

  data_type: 'varchar'
  is_nullable: 1
  size: 255

The maximum over adapters and cycles in reads/fragments as a fraction per file and RG. Values for first and second reads separated with ',', and values for individual files separated with '/'. e.g. '0.1/0.1/0.1/0.1,0.1/0.1/0.1/0.1'

=head2 adapter_contamination_assessment

  data_type: 'varchar'
  is_nullable: 1
  size: 255

'PASS', 'WARN', 'FAIL' per read and file. Multiple values are represented as forward slash-separated array of strings with a comma separating entries for paired-end 1 and 2 reads e.g. 'PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS'

=head2 pre_adapter_min_total_qscore

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 1

Minimum of TOTAL_QSCORE values in PreAdapter report from CollectSequencingArtifactMetrics

=head2 ref_bias_min_total_qscore

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 1

Minimum of TOTAL_QSCORE values in BaitBias report from CollectSequencingArtifactMetrics

=head2 target_proper_pair_mapped_reads_fraction

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 target_proper_pair_mapped_reads_assessment

  data_type: 'char'
  is_nullable: 1
  size: 4

'PASS' if target_proper_pair_mapped_reads_fraction > 0.95, 'FAIL' otherwise

=head2 insert_size_mean

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 insert_size_std

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 sequence_error_rate

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

Reported by samtools, as a fraction

=head2 basic_statistics_assessement

  data_type: 'varchar'
  is_nullable: 1
  size: 255

FastQC 'PASS', 'WARN', 'FAIL' per input file. Array of strings separated by '/', with a ',' separating entries for paired-end 1 and 2 reads. e.g. Four RG 'PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS'

=head2 overrepresented_sequences_assessement

  data_type: 'varchar'
  is_nullable: 1
  size: 255

FastQC 'PASS', 'WARN', 'FAIL' per input file. Array of strings separated by '/', with a ',' separating entries for paired-end 1 and 2 reads. e.g. Four RG 'PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS'

=head2 n_content_per_base_assessement

  data_type: 'varchar'
  is_nullable: 1
  size: 255

FastQC 'PASS', 'WARN', 'FAIL' per input file. Array of strings separated by '/', with a ',' separating entries for paired-end 1 and 2 reads. e.g. Four RG 'PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS'

=head2 sequence_content_per_base_assessement

  data_type: 'varchar'
  is_nullable: 1
  size: 255

FastQC 'PASS', 'WARN', 'FAIL' per input file. Array of strings separated by '/', with a ',' separating entries for paired-end 1 and 2 reads. e.g. Four RG 'PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS'

=head2 sequence_quality_per_base_assessement

  data_type: 'varchar'
  is_nullable: 1
  size: 255

FastQC 'PASS', 'WARN', 'FAIL' per input file. Array of strings separated by '/', with a ',' separating entries for paired-end 1 and 2 reads. e.g. Four RG 'PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS'

=head2 gc_content_per_sequence_assessement

  data_type: 'varchar'
  is_nullable: 1
  size: 255

FastQC 'PASS', 'WARN', 'FAIL' per input file. Array of strings separated by '/', with a ',' separating entries for paired-end 1 and 2 reads. e.g. Four RG 'PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS'

=head2 quality_scores_per_sequence_assessement

  data_type: 'varchar'
  is_nullable: 1
  size: 255

FastQC 'PASS', 'WARN', 'FAIL' per input file. Array of strings separated by '/', with a ',' separating entries for paired-end 1 and 2 reads. e.g. Four RG 'PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS'

=head2 sequence_duplication_levels_assessement

  data_type: 'varchar'
  is_nullable: 1
  size: 255

FastQC 'PASS', 'WARN', 'FAIL' per input file. Array of strings separated by '/', with a ',' separating entries for paired-end 1 and 2 reads. e.g. Four RG 'PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS'

=head2 sequence_length_distribution_assessement

  data_type: 'varchar'
  is_nullable: 1
  size: 255

FastQC 'PASS', 'WARN', 'FAIL' per input file. Array of strings separated by '/', with a ',' separating entries for paired-end 1 and 2 reads. e.g. Four RG 'PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS'

=head2 fastqc_overall_assessment

  data_type: 'char'
  is_nullable: 1
  size: 4

FastQC 'PASS' or 'FAIL'

=head2 nrd

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

Sample discordance levels at non-reference genotypes as a fraction

=head2 nrd_assessment

  data_type: 'char'
  is_nullable: 1
  size: 4

'PASS' based on nrd_persent < 2% or 'FAIL' or 'NA' if genotyping data not available for this sample

=head2 sex_reported

  data_type: 'char'
  is_nullable: 1
  size: 6

Sex as reported by sample supplier

=head2 sex_computed

  data_type: 'char'
  is_nullable: 1
  size: 6

Genetic sex as identified by sequence data

=cut

__PACKAGE__->add_columns(
  'id_iseq_ext_pr_metrics_tmp',
  {
    data_type => 'bigint',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'created',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    default_value => 'CURRENT_TIMESTAMP',
    is_nullable => 1,
  },
  'last_changed',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    default_value => 'CURRENT_TIMESTAMP',
    is_nullable => 1,
  },
  'supplier_sample_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'plate_barcode',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'library_id',
  { data_type => 'integer', is_nullable => 1 },
  'file_name',
  { data_type => 'varchar', is_nullable => 0, size => 300 },
  'file_path',
  { data_type => 'varchar', is_nullable => 0, size => 760 },
  'md5_staging',
  { data_type => 'char', is_nullable => 1, size => 32 },
  'manifest_upload_status',
  { data_type => 'char', is_nullable => 1, size => 15 },
  'manifest_upload_status_change_date',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'id_iseq_product',
  { data_type => 'char', is_nullable => 1, size => 64 },
  'iseq_composition_tmp',
  { data_type => 'varchar', is_nullable => 1, size => 600 },
  'id_iseq_pr_metrics_tmp',
  {
    data_type => 'bigint',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  'id_archive_product',
  { data_type => 'char', is_nullable => 1, size => 64 },
  'processing_status',
  { data_type => 'char', is_nullable => 1, size => 15 },
  'qc_overall_assessment',
  { data_type => 'char', is_nullable => 1, size => 4 },
  'qc_status',
  { data_type => 'char', is_nullable => 1, size => 15 },
  'sequencing_start_date',
  { data_type => 'date', datetime_undef_if_invalid => 1, is_nullable => 1 },
  'upload_date',
  { data_type => 'date', datetime_undef_if_invalid => 1, is_nullable => 1 },
  'md5_validation_date',
  { data_type => 'date', datetime_undef_if_invalid => 1, is_nullable => 1 },
  'processing_start_date',
  { data_type => 'date', datetime_undef_if_invalid => 1, is_nullable => 1 },
  'analysis_start_date',
  { data_type => 'date', datetime_undef_if_invalid => 1, is_nullable => 1 },
  'analysis_end_date',
  { data_type => 'date', datetime_undef_if_invalid => 1, is_nullable => 1 },
  'archival_date',
  { data_type => 'date', datetime_undef_if_invalid => 1, is_nullable => 1 },
  'archive_conformation_date',
  { data_type => 'date', datetime_undef_if_invalid => 1, is_nullable => 1 },
  'md5',
  { data_type => 'char', is_nullable => 1, size => 32 },
  'md5_validation',
  { data_type => 'char', is_nullable => 1, size => 4 },
  'format_validation',
  { data_type => 'char', is_nullable => 1, size => 4 },
  'upload_status',
  { data_type => 'char', is_nullable => 1, size => 4 },
  'instrument_id',
  { data_type => 'varchar', is_nullable => 1, size => 256 },
  'flowcell_id',
  { data_type => 'varchar', is_nullable => 1, size => 256 },
  'annotation',
  { data_type => 'varchar', is_nullable => 1, size => 256 },
  'min_read_length',
  { data_type => 'tinyint', extra => { unsigned => 1 }, is_nullable => 1 },
  'target_autosome_coverage_threshold',
  {
    data_type => 'integer',
    default_value => 15,
    extra => { unsigned => 1 },
    is_nullable => 1,
  },
  'target_autosome_gt_coverage_threshold',
  { data_type => 'float', is_nullable => 1 },
  'target_autosome_gt_coverage_threshold_assessment',
  { data_type => 'char', is_nullable => 1, size => 4 },
  'verify_bam_id_score',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'verify_bam_id_score_assessment',
  { data_type => 'char', is_nullable => 1, size => 4 },
  'double_error_fraction',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'contamination_assessment',
  { data_type => 'char', is_nullable => 1, size => 4 },
  'yield',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'yield_q20',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'yield_q30',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'num_reads',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'gc_fraction_forward_read',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'gc_fraction_reverse_read',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'adapter_contamination',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'adapter_contamination_assessment',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'pre_adapter_min_total_qscore',
  { data_type => 'tinyint', extra => { unsigned => 1 }, is_nullable => 1 },
  'ref_bias_min_total_qscore',
  { data_type => 'tinyint', extra => { unsigned => 1 }, is_nullable => 1 },
  'target_proper_pair_mapped_reads_fraction',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'target_proper_pair_mapped_reads_assessment',
  { data_type => 'char', is_nullable => 1, size => 4 },
  'insert_size_mean',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_size_std',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'sequence_error_rate',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'basic_statistics_assessement',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'overrepresented_sequences_assessement',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'n_content_per_base_assessement',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'sequence_content_per_base_assessement',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'sequence_quality_per_base_assessement',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'gc_content_per_sequence_assessement',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'quality_scores_per_sequence_assessement',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'sequence_duplication_levels_assessement',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'sequence_length_distribution_assessement',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'fastqc_overall_assessment',
  { data_type => 'char', is_nullable => 1, size => 4 },
  'nrd',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'nrd_assessment',
  { data_type => 'char', is_nullable => 1, size => 4 },
  'sex_reported',
  { data_type => 'char', is_nullable => 1, size => 6 },
  'sex_computed',
  { data_type => 'char', is_nullable => 1, size => 6 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_iseq_ext_pr_metrics_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_iseq_ext_pr_metrics_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<iseq_ext_pr_file_path>

=over 4

=item * L</file_path>

=back

=cut

__PACKAGE__->add_unique_constraint('iseq_ext_pr_file_path', ['file_path']);

=head1 RELATIONS

=head2 iseq_external_product_components

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqExternalProductComponent>

=cut

__PACKAGE__->has_many(
  'iseq_external_product_components',
  'WTSI::DNAP::Warehouse::Schema::Result::IseqExternalProductComponent',
  { 'foreign.id_iseq_pr_tmp' => 'self.id_iseq_ext_pr_metrics_tmp' },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 iseq_product_metrics

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqProductMetric>

=cut

__PACKAGE__->belongs_to(
  'iseq_product_metrics',
  'WTSI::DNAP::Warehouse::Schema::Result::IseqProductMetric',
  { id_iseq_pr_metrics_tmp => 'id_iseq_pr_metrics_tmp' },
  {
    is_deferrable => 1,
    join_type     => 'LEFT',
    on_delete     => 'SET NULL',
    on_update     => 'NO ACTION',
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-10-11 15:05:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FV5Sel1KH2d5Bra0wTmLTw

our $VERSION = '0';

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 SYNOPSIS

=head1 DESCRIPTION

Result class definition for a table with externally computed metrics
for data sequenced at WSI.

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 SUBROUTINES/METHODS

=head1 DEPENDENCIES

=over

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

Copyright (C) 2019 Genome Research Limited

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

