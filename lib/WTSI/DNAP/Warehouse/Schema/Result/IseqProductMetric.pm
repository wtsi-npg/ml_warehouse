
package WTSI::DNAP::Warehouse::Schema::Result::IseqProductMetric;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::IseqProductMetric

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

=head1 TABLE: C<iseq_product_metrics>

=cut

__PACKAGE__->table('iseq_product_metrics');

=head1 ACCESSORS

=head2 id_iseq_pr_metrics_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

=head2 id_iseq_product

  data_type: 'char'
  is_nullable: 1
  size: 64

Product id

=head2 last_changed

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

Date this record was created or changed

=head2 id_iseq_flowcell_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

Flowcell id, see 'iseq_flowcell.id_iseq_flowcell_tmp'

=head2 id_run

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

NPG run identifier

=head2 position

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

Flowcell lane number

=head2 tag_index

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Tag index, NULL if lane is not a pool

=head2 iseq_composition_tmp

  data_type: 'varchar'
  is_nullable: 1
  size: 300

JSON representation of the composition object, the column might be deleted in future

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

=head2 tag_sequence4deplexing

  data_type: 'varchar'
  is_nullable: 1
  size: 30

Tag sequence used for deplexing the lane, common suffix might have been truncated

=head2 actual_forward_read_length

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Actual forward read length, bp

=head2 actual_reverse_read_length

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Actual reverse read length, bp

=head2 indexing_read_length

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Indexing read length, bp

=head2 tag_decode_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 tag_decode_count

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

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

=head2 insert_size_num_modes

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 insert_size_normal_fit_confidence

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [3,2]

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

=head2 num_reads

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 percent_mapped

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 percent_duplicate

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 chimeric_reads_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

mate_mapped_defferent_chr_5 as percentage of all

=head2 human_percent_mapped

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 human_percent_duplicate

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 genotype_sample_name_match

  data_type: 'varchar'
  is_nullable: 1
  size: 8

=head2 genotype_sample_name_relaxed_match

  data_type: 'varchar'
  is_nullable: 1
  size: 8

=head2 genotype_mean_depth

  data_type: 'float'
  is_nullable: 1
  size: [7,2]

=head2 mean_bait_coverage

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [8,2]

=head2 on_bait_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 on_or_near_bait_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 verify_bam_id_average_depth

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [11,2]

=head2 verify_bam_id_score

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [6,5]

=head2 verify_bam_id_snp_count

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 rna_exonic_rate

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

Exonic Rate is the fraction mapping within exons

=head2 rna_percent_end_2_reads_sense

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

Percentage of intragenic End 2 reads that were sequenced in the sense direction.

=head2 rna_rrna_rate

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

rRNA Rate is per total reads

=head2 rna_genes_detected

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Number of genes detected with at least 5 reads.

=head2 rna_norm_3_prime_coverage

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

3 prime n-based normalization: n is the transcript length at that end; norm is the ratio between the coverage at the 3 prime end and the average coverage of the full transcript, averaged over all transcripts

=head2 rna_norm_5_prime_coverage

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

5 prime n-based normalization: n is the transcript length at that end; norm is the ratio between the coverage at the 5 prime end and the average coverage of the full transcript, averaged over all transcripts

=head2 rna_intronic_rate

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

Intronic rate is the fraction mapping within introns

=head2 rna_transcripts_detected

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Number of transcripts detected with at least 5 reads

=head2 rna_globin_percent_tpm

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

Percentage of globin genes TPM (transcripts per million) detected

=head2 rna_mitochondrial_percent_tpm

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

Percentage of mitochondrial genes TPM (transcripts per million) detected

=head2 gbs_call_rate

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

The GbS call rate is the fraction of loci called on the relevant primer panel

=head2 gbs_pass_rate

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

The GbS pass rate is the fraction of loci called and passing filters on the relevant primer panel

=head2 nrd_percent

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

Percent of non-reference discordance

=head2 target_filter

  data_type: 'varchar'
  is_nullable: 1
  size: 30

Filter used to produce the target stats file

=head2 target_length

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

The total length of the target regions

=head2 target_mapped_reads

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

The number of mapped reads passing the target filter

=head2 target_proper_pair_mapped_reads

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

The number of proper pair mapped reads passing the target filter

=head2 target_mapped_bases

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

The number of mapped bases passing the target filter

=head2 target_coverage_threshold

  data_type: 'integer'
  is_nullable: 1

The coverage threshold used in the target perc target greater than depth calculation

=head2 target_percent_gt_coverage_threshold

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

The percentage of the target covered at greater than the depth specified

=cut

__PACKAGE__->add_columns(
  'id_iseq_pr_metrics_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'id_iseq_product',
  { data_type => 'char', is_nullable => 1, size => 64 },
  'last_changed',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    default_value => 'CURRENT_TIMESTAMP',
    is_nullable => 1,
  },
  'id_iseq_flowcell_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  'id_run',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  'position',
  {
    data_type => 'smallint',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  'tag_index',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'iseq_composition_tmp',
  { data_type => 'varchar', is_nullable => 1, size => 300 },
  'qc_seq',
  { data_type => 'tinyint', is_nullable => 1 },
  'qc_lib',
  { data_type => 'tinyint', is_nullable => 1 },
  'qc',
  { data_type => 'tinyint', is_nullable => 1 },
  'tag_sequence4deplexing',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
  'actual_forward_read_length',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'actual_reverse_read_length',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'indexing_read_length',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'tag_decode_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'tag_decode_count',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_size_quartile1',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_size_quartile3',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_size_median',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_size_num_modes',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_size_normal_fit_confidence',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [3, 2],
  },
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
  'ref_match1_name',
  { data_type => 'varchar', is_nullable => 1, size => 100 },
  'ref_match1_percent',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'ref_match2_name',
  { data_type => 'varchar', is_nullable => 1, size => 100 },
  'ref_match2_percent',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
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
  'num_reads',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'percent_mapped',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'percent_duplicate',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'chimeric_reads_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'human_percent_mapped',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'human_percent_duplicate',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'genotype_sample_name_match',
  { data_type => 'varchar', is_nullable => 1, size => 8 },
  'genotype_sample_name_relaxed_match',
  { data_type => 'varchar', is_nullable => 1, size => 8 },
  'genotype_mean_depth',
  { data_type => 'float', is_nullable => 1, size => [7, 2] },
  'mean_bait_coverage',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [8, 2],
  },
  'on_bait_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'on_or_near_bait_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'verify_bam_id_average_depth',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [11, 2],
  },
  'verify_bam_id_score',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [6, 5],
  },
  'verify_bam_id_snp_count',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'rna_exonic_rate',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'rna_percent_end_2_reads_sense',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'rna_rrna_rate',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'rna_genes_detected',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'rna_norm_3_prime_coverage',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'rna_norm_5_prime_coverage',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'rna_intronic_rate',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'rna_transcripts_detected',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'rna_globin_percent_tpm',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'rna_mitochondrial_percent_tpm',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'gbs_call_rate',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'gbs_pass_rate',
  { data_type => 'float', extra => { unsigned => 1 }, is_nullable => 1 },
  'nrd_percent',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'target_filter',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
  'target_length',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'target_mapped_reads',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'target_proper_pair_mapped_reads',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'target_mapped_bases',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'target_coverage_threshold',
  { data_type => 'integer', is_nullable => 1 },
  'target_percent_gt_coverage_threshold',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_iseq_pr_metrics_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_iseq_pr_metrics_tmp');

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

=head2 iseq_run_lane_metric

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqRunLaneMetric>

=cut

__PACKAGE__->belongs_to(
  'iseq_run_lane_metric',
  'WTSI::DNAP::Warehouse::Schema::Result::IseqRunLaneMetric',
  { id_run => 'id_run', position => 'position' },
  {
    is_deferrable => 1,
    join_type     => 'LEFT',
    on_delete     => 'CASCADE',
    on_update     => 'NO ACTION',
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-01-29 17:35:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FN3wzhtXUQfMsEpoLU7vBA


# You can replace this text with custom code or comments, and it will be preserved on regeneration

our $VERSION = '0';

=head2 iseq_run_lane_metric

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqRunLaneMetric>

=cut

__PACKAGE__->belongs_to(
  'iseq_run_lane_metric_right',
  'WTSI::DNAP::Warehouse::Schema::Result::IseqRunLaneMetric',
  { id_run => 'id_run', position => 'position' },
  { is_deferrable => 1, join_type => 'RIGHT', on_delete => 'CASCADE', on_update => 'NO ACTION' },
);

=head2 iseq_run_status

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatus>

=cut

__PACKAGE__->has_many(
  'iseq_run_status',

  'WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatus',
  {
    'foreign.id_run'   => 'self.id_run',
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

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

