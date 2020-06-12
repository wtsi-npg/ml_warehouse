CREATE TABLE `iseq_heron_product_metrics` (
  `id_iseq_hrpr_metrics_tmp` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `created` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Datetime this record was created',
  `last_changed` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Datetime this record was created or changed',
  `id_iseq_product` CHAR(64) NOT NULL COMMENT 'Product id, a foreign key into iseq_product_metrics table',
  `supplier_sample_name` VARCHAR(255) DEFAULT NULL COMMENT 'Sample name given by the supplier, as recorded by WSI',
  `artic_qc_outcome` CHAR(15) DEFAULT NULL COMMENT 'Artic pipeline QC outcome, "TRUE", "FALSE" or a NULL value',
  `climb_upload` DATETIME DEFAULT NULL COMMENT 'Datetime files for this sample were uploaded to CLIMB',
  `cog_sample_meta` TINYINT(1) UNSIGNED DEFAULT NULL COMMENT 'A Boolean flag to mark sample metadata upload to COG',
  `path_root` VARCHAR(255) DEFAULT NULL COMMENT 'The uploaded files path root for the entity',
  `pct_N_bases` FLOAT DEFAULT NULL COMMENT 'Percent of N bases',
  `pct_covered_bases` FLOAT DEFAULT NULL COMMENT 'Percent of covered bases',
  `longest_no_N_run` SMALLINT UNSIGNED DEFAULT NULL COMMENT 'Longest consensus data stretch without N',
  `num_aligned_reads` BIGINT UNSIGNED DEFAULT NULL COMMENT 'Number of aligned filtered reads',
  PRIMARY KEY (`id_iseq_hrpr_metrics_tmp`),
  UNIQUE KEY `iseq_hrm_digest_unq`(`id_iseq_product`),
  KEY `iseq_hrm_ssn` (`supplier_sample_name`),
  CONSTRAINT `iseq_hrm_prm_fk` FOREIGN KEY (`id_iseq_product`) REFERENCES `iseq_product_metrics` (`id_iseq_product`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Heron project additional metrics';

