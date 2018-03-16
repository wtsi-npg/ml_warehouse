-- The remaining index on (id_run, position, tag_index)
-- will provide effective indexing for the columns
-- (id_run, position).
ALTER TABLE iseq_product_metrics DROP INDEX iseq_pm_run_pos_index, DROP INDEX iseq_pr_metrics_lm_fk;

ALTER TABLE `iseq_product_metrics` 
ADD COLUMN `rna_exonic_rate` FLOAT UNSIGNED DEFAULT NULL 
COMMENT 'Exonic Rate is the fraction mapping within exons'
AFTER `verify_bam_id_snp_count`,
ADD COLUMN `rna_percent_end_2_reads_sense` FLOAT UNSIGNED DEFAULT NULL 
COMMENT 'Percentage of intragenic End 2 reads that were sequenced in the sense direction.'
AFTER `rna_exonic_rate`,
ADD COLUMN `rna_rrna_rate` FLOAT UNSIGNED DEFAULT NULL
COMMENT 'rRNA Rate is per total reads'
AFTER `rna_percent_end_2_reads_sense`,
ADD COLUMN `rna_genes_detected` INT(10) UNSIGNED DEFAULT NULL 
COMMENT 'Number of genes detected with at least 5 reads.'
AFTER `rna_rrna_rate`,
ADD COLUMN `rna_norm_3_prime_coverage` FLOAT UNSIGNED DEFAULT NULL 
COMMENT '3 prime n-based normalization: n is the transcript length at that end; norm is the ratio between the coverage at the 3 prime end and the average coverage of the full transcript, averaged over all transcripts'
AFTER `rna_genes_detected`,
ADD COLUMN `rna_norm_5_prime_coverage` FLOAT UNSIGNED DEFAULT NULL 
COMMENT '5 prime n-based normalization: n is the transcript length at that end; norm is the ratio between the coverage at the 5 prime end and the average coverage of the full transcript, averaged over all transcripts'
AFTER `rna_norm_3_prime_coverage`,
ADD COLUMN `rna_intronic_rate` FLOAT UNSIGNED DEFAULT NULL 
COMMENT 'Intronic rate is the fraction mapping within introns'
AFTER `rna_norm_5_prime_coverage`,
ADD COLUMN `rna_transcripts_detected` INT(10) UNSIGNED DEFAULT NULL 
COMMENT 'Number of transcripts detected with at least 5 reads'
AFTER `rna_intronic_rate`
ADD COLUMN `rna_globin_percent_tpm` FLOAT UNSIGNED DEFAULT NULL
COMMENT 'Percentage of globin genes TPM (transcripts per million) detected'
AFTER `rna_transcripts_detected`;
