ALTER TABLE `iseq_product_metrics` 
ADD COLUMN `gbs_call_rate` FLOAT UNSIGNED DEFAULT NULL 
COMMENT 'The GbS call rate is the fraction of loci called on the relevant primer panel'
AFTER `rna_globin_percent_tpm`,
ADD COLUMN `gbs_pass_rate` FLOAT UNSIGNED DEFAULT NULL 
COMMENT 'The GbS pass rate is the fraction of loci called and passing filters on the relevant primer panel'
AFTER `gbs_call_rate`;
