CREATE TABLE `iseq_external_product_metrics` (
  `id_iseq_ext_pr_metrics_tmp` bigint(20) unsigned NOT NULL AUTO_INCREMENT \
    COMMENT 'Internal to this database id, value can change',
  `id_iseq_product` char(64) NOT NULL COMMENT 'Product id',
  `last_changed` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP \
    COMMENT 'Date this record was created or changed',
  `iseq_composition_tmp` varchar(600) DEFAULT NULL \
    COMMENT 'JSON representation of the composition object, the column might be deleted in future',
  `id_iseq_pr_component_tmp` bigint(20) unsigned DEFAULT NULL \
    COMMENT 'An optional foreign key for a record in iseq_product_metrics if this row and the row in the linked table is for the same file',
  `component_identifies` varchar(600) NOT NULL \
    COMMENT 'Comma-delimitered alphabetically sorted list of file names or read groups, which inambigiously define DNAP sources of data',
  `supplier_sample_name`  varchar(255) NOT NULL,
  `iseq_external_qc_outcome` char(20) NOT NULL \
    COMMENT 'External QC assessment outcome',
  `num_reads` bigint(20) unsigned DEFAULT NULL,
  `percent_mapped` float(5,2) DEFAULT NULL,
  `percent_duplicate` float(5,2) DEFAULT NULL,
  `chimeric_reads_percent` float(5,2) unsigned DEFAULT NULL \
    COMMENT 'mate_mapped_defferent_chr_5 as percentage of all',
  `verify_bam_id_average_depth` float(11,2) unsigned DEFAULT NULL,
  `verify_bam_id_score` float(6,5) unsigned DEFAULT NULL,
  `verify_bam_id_snp_count` int(10) unsigned DEFAULT NULL,
  `nrd_percent` float(5,2) DEFAULT NULL \
    COMMENT 'Percent of non-reference discordance',
  `target_filter` varchar(30) DEFAULT NULL \
    COMMENT 'Filter used to produce the target stats file',
  `target_length` bigint(12) unsigned DEFAULT NULL \
    COMMENT 'The total length of the target regions',
  `target_mapped_reads` bigint(20) unsigned DEFAULT NULL \
    COMMENT 'The number of mapped reads passing the target filter',
  `target_proper_pair_mapped_reads` bigint(20) unsigned DEFAULT NULL \
    COMMENT 'The number of proper pair mapped reads passing the target filter',
  `target_mapped_bases` bigint(20) unsigned DEFAULT NULL \
    COMMENT 'The number of mapped bases passing the target filter',
  `target_coverage_threshold` int(4) DEFAULT NULL \
    COMMENT 'The coverage threshold used in the target perc target greater than depth calculation',
  `target_percent_gt_coverage_threshold` float(5,2) DEFAULT NULL \
    COMMENT 'The percentage of the target covered at greater than the depth specified',
  `target_autosome_coverage_threshold` int(4) DEFAULT NULL \
    COMMENT 'The coverage threshold used in the perc target autosome greater than depth calculation',
  `target_autosome_percent_gt_coverage_threshold` float(5,2) DEFAULT NULL \
    COMMENT 'The percentage of the target autosome covered at greater than the depth specified',
  PRIMARY KEY (`id_iseq_ext_pr_metrics_tmp`),
  UNIQUE KEY `iseq_ext_pr_metrics_product_unique` (`id_iseq_product`),
  CONSTRAINT `iseq_ext_pr_metrics_qc_fk` FOREIGN KEY (`iseq_external_qc_outcome`) \
    REFERENCES `iseq_external_qc_outcome_dict` (`iseq_external_qc_outcome`) \
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `iseq_ext_pr_metrics_samefile_fk` FOREIGN KEY (`id_iseq_pr_component_tmp`) \
    REFERENCES `iseq_product_metrics` (`id_iseq_pr_component_tmp`) \
    ON DELETE SET NULL ON UPDATE NO ACTION
);

CREATE TABLE `iseq_external_qc_outcome_dict` (
  `iseq_external_qc_outcome` char(20) NOT NULL COMMENT 'External QC assessment outcome',
  `long_description` varchar(256) NOT NULL COMMENT 'Long description of the QC outcome',
  `iscurrent` tinyint(1) unsigned DEFAULT 1 COMMENT 'Current boolean flag, defaults to 1',
  PRIMARY KEY (`iseq_external_qc_outcome`)
);

CREATE TABLE `iseq_external_product_components` (
  `id_iseq_ext_pr_components_tmp` bigint(20) unsigned NOT NULL AUTO_INCREMENT \
    COMMENT 'Internal to this database id, value can change',
  `id_iseq_pr_tmp` bigint(20) unsigned NOT NULL \
    COMMENT 'iseq_external_product_metrics table row id for the product',
  `id_iseq_pr_component_tmp` bigint(20) unsigned DEFAULT NULL \
    COMMENT 'iseq_product_metrics table row id for one of this product''s components',
  `num_components` tinyint(3) unsigned NOT NULL \
    COMMENT 'Number of component products for this product',
  `component_index` tinyint(3) unsigned NOT NULL \
    COMMENT 'Unique component index within all components of this product, a value from 1 to the value of num_components column for this product',
  PRIMARY KEY (`id_iseq_ext_pr_components_tmp`),
  UNIQUE KEY `iseq_ext_pr_comp_unique` (`id_iseq_pr_tmp`,`id_iseq_pr_component_tmp`),
  KEY `iseq_ext_pr_comp_pr_comp_fk` (`id_iseq_pr_component_tmp`),
  KEY `iseq_ext_pr_comp_ncomp` (`num_components`,`id_iseq_pr_tmp`),
  KEY `iseq_ext_pr_comp_compi` (`component_index`,`num_components`),
  CONSTRAINT `iseq_ext_pr_comp_pr_comp_fk` FOREIGN KEY (`id_iseq_pr_component_tmp`) \
    REFERENCES `iseq_product_metrics` (`id_iseq_pr_metrics_tmp`) \
    ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `iseq_ext_pr_comp_pr_fk` FOREIGN KEY (`id_iseq_pr_tmp`) \
    REFERENCES `iseq_external_product_metrics` (`id_iseq_ext_pr_metrics_tmp`) \
    ON DELETE CASCADE ON UPDATE NO ACTION
);