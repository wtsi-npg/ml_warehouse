--
-- Add new columns to iseq_product_metrics table
--
ALTER TABLE `iseq_product_metrics`
ADD COLUMN `rna_mitochondrial_percent_tpm` FLOAT UNSIGNED DEFAULT NULL
COMMENT 'Percentage of mitochondrial genes TPM (transcripts per million) detected'
AFTER `rna_globin_percent_tpm`;


ALTER TABLE `iseq_product_metrics` \
ADD COLUMN target_filter varchar(30) DEFAULT NULL \
  COMMENT 'Filter used to produce the target stats file' \
  AFTER gbs_pass_rate, \
ADD COLUMN target_length bigint(12) unsigned DEFAULT NULL \
  COMMENT 'The total length of the target regions' \
  AFTER target_filter,\
ADD COLUMN target_mapped_reads bigint(20) unsigned DEFAULT NULL \
  COMMENT 'The number of mapped reads passing the target filter' \
  AFTER target_length, \
ADD COLUMN target_proper_pair_mapped_reads bigint(20) unsigned DEFAULT NULL \
  COMMENT 'The number of proper pair mapped reads passing the target filter' \
  AFTER target_mapped_reads, \
ADD COLUMN target_mapped_bases bigint(20) unsigned DEFAULT NULL \
  COMMENT 'The number of mapped bases passing the target filter' \
  AFTER target_proper_pair_mapped_reads, \
ADD COLUMN target_coverage_threshold int(4) DEFAULT NULL \
  COMMENT 'The coverage threshold used in the target perc target greater than depth calculation' \
  AFTER target_mapped_bases, \
ADD COLUMN target_percent_gt_coverage_threshold float(5,2) DEFAULT NULL \
  COMMENT 'The percentage of the target covered at greater than the depth specified' \
  AFTER target_coverage_threshold;
