--
-- Add new column to RNA-SeQC check table
--
ALTER TABLE `iseq_product_metrics`
ADD COLUMN `rna_mitochondrial_percent_tpm` FLOAT UNSIGNED DEFAULT NULL
COMMENT 'Percentage of mitochondrial genes TPM (transcripts per million) detected'
AFTER `rna_globin_percent_tpm`;