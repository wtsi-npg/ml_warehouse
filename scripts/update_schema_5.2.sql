CREATE TABLE `iseq_external_product_metrics` (

  `id_iseq_ext_pr_metrics_tmp` bigint(20) unsigned NOT NULL AUTO_INCREMENT \
    COMMENT 'Internal to this database id, value can change',
  `created` datetime DEFAULT CURRENT_TIMESTAMP \
    COMMENT 'Datetime this record was created',
  `last_changed` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP \
    COMMENT 'Datetime this record was created or changed',

  `supplier_sample_name_wsi` varchar(255) NOT NULL,
  `file_name_wsi` varchar(300) NOT NULL \
    COMMENT 'Comma-delimitered alphabetically sorted list of file names, which inambigiously define DNAP sources of data',
  `file_path_wsi` varchar(2000) NOT NULL \
    COMMENT 'Comma-delimitered alphabetically sorted list of full file paths for the files in file_names column',
  `md5_wsi` char(24) NOT NULL \
    COMMENT 'WSI validation hex MD5, not set for multiple source files',

  `id_iseq_product` char(64) DEFAULT NULL COMMENT 'product id',
  `iseq_composition_tmp` varchar(600) DEFAULT NULL \
    COMMENT 'JSON representation of the composition object, the column might be deleted in future',
  `id_iseq_pr_component_tmp` bigint(20) unsigned DEFAULT NULL \
    COMMENT 'An optional foreign key for a record in iseq_product_metrics if this row and the row in the product table is for the same product',

  `id_archive_product` char(64) DEFAULT NULL COMMENT 'archive ID for data product if any',

  `processing_status` char(15) DEFAULT NULL \
    COMMENT 'one of "PASS", "HOLD", "INSUFFICIENT", "FAIL"',
  `qc` char(4) DEFAULT NULL COMMENT 'final data product criteria evaluation outcome as "PASS" or "FAIL"',

  `sequencing_start_date` date DEFAULT NULL \
    COMMENT 'sequencing start date obtained from the CRAM file header, not set for multiple source files or if not yet analysed',
  `upload_date` date DEFAULT NULL \
    COMMENT 'upload date, not set for multiple source files',
  `md5_validation_date` date DEFAULT NULL \
    COMMENT 'date of MD5 validation, not set for multiple source files',
  `processing_start_date` date DEFAULT NULL \
    COMMENT 'processing start date also known as QC date',
  `analysis_start_date` date DEFAULT NULL,
  `analysis_end_date` date DEFAULT NULL,
  `archival_date` date DEFAULT NULL \
    COMMENT 'date made available or pushed to archive service',
  `archive_conformation_date` date DEFAULT NULL \
    COMMENT 'date of confirmation of integrity of data products by archive service',

  `md5` char(24) DEFAULT NULL \
    COMMENT 'external validation hex MD5, not set for multiple source files',
  `md5_validation` char(4) DEFAULT NULL \
    COMMENT 'outcome of MD5 validation as "PASS" or "FAIL", not set for multiple source files',
  `format_validation` char(4) DEFAULT NULL \
    COMMENT 'outcome of format validation as "PASS" or "FAIL", not set for multiple source files or if not yet validated',
  `upload_status` char(4) DEFAULT NULL \
    COMMENT 'upload status as "PASS" or "FAIL", "PASS" if both MD5 and format validation are "PASS", not set for multiple source files or if not yet validated',

  `instrument_id` varchar(30) DEFAULT NULL \
    COMMENT 'comma separated sorted list of instrument IDs obtained from the CRAM file header(s), not set if not yet analysed',
  `flowcell_id` varchar(30) DEFAULT NULL \
    COMMENT 'comma separated sorted list of flowcell IDs obtained from the CRAM file header(s), not set if not yet analysed',
  `annotation` varchar(256) DEFAULT NULL \
    COMMENT 'annotation regarding data provenance, i.e. is sequence data from first pass, re-run, top-up etc.',

  `min_read_length` tinyint(3) unsigned  DEFAULT NULL \
    COMMENT 'minimum read length observed in the data file',
  `target_autosome_coverage_threshold` int(3) unsigned DEFAULT 15 \
    COMMENT 'target autosome coverage threshold, defaults to 15',
  `target_autosome_percent_gt_coverage_threshold` float DEFAULT NULL \
    COMMENT 'coverage percent at >= 15X as a fraction',
  `target_autosome_percent_gt_coverage_threshold_assessment` char(4) DEFAULT NULL \
    COMMENT '"PASS" if target_autosome_percent_gt_coverage_threshold > 95%, "FAIL" otherwise',
  `verify_bam_id_score` float unsigned DEFAULT NULL \
    COMMENT 'FREEMIX value of sample contamination levels as a fraction',
  `verify_bam_id_score_assessment` char(4) DEFAULT NULL \
    COMMENT '"PASS" if verify_bam_id_score > 0.01, "FAIL" otherwise',
  `double_error_fraction` float unsigned DEFAULT NULL \
    COMMENT 'fraction of marker pairs with two read pairs evidencing parity and non-parity, may only be calculated if 1% <= verify_bam_id_score < 5%',
  `contamination_assessment` char(4) DEFAULT NULL \
    COMMENT '"PASS" or "FAIL" based on verify_bam_id_score_assessment and double_error_fraction < 0.2%',
  `yield` tinyint(4) unsigned DEFAULT NULL COMMENT 'sequence data quantity (Gb)',
  `yield_q20` int(10) unsigned DEFAULT NULL,
  `yield_q30` int(10) unsigned DEFAULT NULL,
  `num_reads` bigint(20) unsigned DEFAULT NULL COMMENT 'number of reads',
  `gc_fraction_forward_read` float unsigned DEFAULT NULL,
  `gc_fraction_reverse_read` float unsigned DEFAULT NULL,
  `adapter_contamination` float unsigned DEFAULT NULL \
    COMMENT 'the maximum over adapters and cycles in reads/fragments as a fraction',
  `adapter_contamination_assessment` char(10) DEFAULT NULL \
    COMMENT '"PASS", "WARN", "FAIL" per read pair, e.g. “PASS/PASS” if both read pairs do not have any adapter sequence present in more than 10% reads',
  `pre_adapter_min_total_qscore` tinyint(3) unsigned DEFAULT NULL \
    COMMENT 'Minimum of TOTAL_QSCORE values in PreAdapter report from CollectSequencingArtifactMetrics',
  `ref_bias_min_total_qscore` tinyint(3) unsigned DEFAULT NULL \
    COMMENT 'Minimum of TOTAL_QSCORE values in BaitBias report from CollectSequencingArtifactMetrics',
  `target_proper_pair_mapped_reads_fraction` float unsigned DEFAULT NULL,
  `target_proper_pair_mapped_reads_assessment` char(4) DEFAULT NULL \
    COMMENT '"PASS" if target_proper_pair_mapped_reads_fraction > 0.95, "FAIL" otherwise',
  `insert_size_mean` tinyint unsigned DEFAULT NULL,
  `insert_size_std` tinyint unsigned DEFAULT NULL,
  `sequence_error_rate` float unsigned DEFAULT NULL \
    COMMENT 'reported by samtools, as a fraction',
  `basic_statistics_assessement` char(4) DEFAULT NULL \
    COMMENT 'FastQC "PASS", "WARN", "FAIL" per read pair separated by "/"',
  `overrepresented_sequences_assessement` char(4) DEFAULT NULL \
    COMMENT 'FastQC "PASS", "WARN", "FAIL" per read pair separated by "/"',
  `n_content_per_base_assessement` char(4) DEFAULT NULL \
    COMMENT 'FastQC "PASS", "WARN", "FAIL" per read pair separated by "/"',
  `sequence_content_per_base_assessement` char(4) DEFAULT NULL \
    COMMENT 'FastQC "PASS", "WARN", "FAIL" per read pair separated by "/"',
  `sequence_quality_per_base_assessement` char(4) DEFAULT NULL \
    COMMENT 'FastQC "PASS", "WARN", "FAIL" per read pair separated by "/"',
  `gc_content_per_sequence_assessement` char(4) DEFAULT NULL \
    COMMENT 'FastQC "PASS", "WARN", "FAIL" per read pair separated by "/"',
  `quality_scores_per_sequence_assessement` char(4) DEFAULT NULL \
    COMMENT 'FastQC "PASS", "WARN", "FAIL" per read pair separated by "/"',
  `sequence_duplication_levels_assessement` char(4) DEFAULT NULL \
    COMMENT 'FastQC "PASS", "WARN", "FAIL" per read pair separated by "/"',
  `sequence_length_distribution_assessement` char(4) DEFAULT NULL \
    COMMENT 'FastQC "PASS", "WARN", "FAIL" per read pair separated by "/"',
  `FastQC_overall_assessment` char(4) DEFAULT NULL COMMENT '"PASS" or "FAIL"',
  `nrd`  float unsigned DEFAULT NULL \
    COMMENT 'sample discordance levels at non-reference genotypes as a fraction',
  `nrd_assessment` char(4) DEFAULT NULL \
    COMMENT '"PASS" based on nrd_persent < 2% or "FAIL"',
  `sex_supplier` char (6) DEFAULT NULL\
    COMMENT 'sex as reported by sample supplier',
  `sex_computed` char (6) DEFAULT NULL \
    COMMENT 'genetic sex as identified by sequence data',

  PRIMARY KEY (`id_iseq_ext_pr_metrics_tmp`),
  UNIQUE KEY `iseq_ext_pr_metrics_pr_file_names` (`file_name_wsi`),
  KEY `iseq_ext_pr_sample_name` (`supplier_sample_name_wsi`),
  KEY `iseq_ext_pr_prstatus` (`processing_status`),
  KEY `iseq_ext_pr_qc` (`qc`),
  KEY `iseq_ext_pr_instrument` (`instrument_id`),
  KEY `iseq_ext_pr_flowcell` (`flowcell_id`)
);

/*  The table above should also have constrant like this:
    
    CONSTRAINT `iseq_ext_pr_metrics_samefile_fk` FOREIGN KEY (`id_iseq_pr_component_tmp`) \
    REFERENCES `iseq_product_metrics` (`id_iseq_pr_component_tmp`) \
    ON DELETE SET NULL ON UPDATE NO ACTION
*/

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