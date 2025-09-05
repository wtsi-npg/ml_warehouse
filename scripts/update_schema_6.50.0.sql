--
-- Add NPG tables in support of sequencing on Ultima Genomics instruments.
--

-- Ultima run is per a silicon wafer. 

CREATE TABLE `useq_run_metrics` (
  `last_changed` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP \
    COMMENT 'Date this record was created or changed', 
  `id_run` INT UNSIGNED  NOT NULL COMMENT 'NPG run identifier',
  `ultimagen_Run_Id` VARCHAR(255) DEFAULT NULL COMMENT 'Ultimagen  RunID',
  `ultimagen_Library_Pool` VARCHAR(255) DEFAULT NULL COMMENT 'Ultimagen  Library_Pool',
  `instrument_name` CHAR(32) NOT NULL COMMENT 'Instrument name in NPG tracking system',
  `instrument_external_name` VARCHAR(255) NOT NULL \
    COMMENT 'Name assigned to the instrument by the manufacturer',
  `instrument_model` VARCHAR(255) NOT NULL Comment 'Instrument model',
  `run_folder_name` VARCHAR(255) NOT NULL COMMENT 'Instrument run folder name',
  `run_priority` tinyint unsigned DEFAULT NULL,
  `cancelled` tinyint unsigned NOT NULL DEFAULT 0 \
    COMMENT 'Boolean flag to indicate whether the run was failed in some way or its data has been discarded',
  `run_in_progress` DATETIME DEFAULT NULL COMMENT 'Timestamp of run in progress status',
  `run_archived` DATETIME DEFAULT NULL COMMENT 'Timestamp of run archived status' \
    COMMENT 'The date the run was released, ie QC-ed if applicable and fully archived',
  `qc_seq` TINYINT(1) DEFAULT NULL \
    COMMENT 'Sequencing lane level QC outcome, a result of either manual or automatic assessment by core',
  `num_reads` BIGINT UNSIGNED DEFAULT NULL \
    COMMENT 'Number of reads for this wafer',
  `input_num_reads` BIGINT UNSIGNED DEFAULT NULL \
    COMMENT 'Number of input reads (before PF) for this wafer',  
  `tags_decode_percent` FLOAT UNSIGNED DEFAULT NULL \
    COMMENT 'An overall percent of pf reads assigned to expected barcodes and the control',
  PRIMARY KEY (`id_run`),
  KEY `useq_run_archived_index` (`run_archived`),
  KEY `useq_rf_name_index` (`run_folder_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


-- A product row represents an individual barcoded library.

CREATE TABLE `useq_product_metrics` (
  `id_useq_pr_metrics_tmp` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT \
    COMMENT 'Internal to this database id, value can change',
  `last_changed` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP \
    COMMENT 'Date this record was created or changed',
  `id_useq_wafer_tmp` BIGINT DEFAULT NULL \
    COMMENT 'Foreign key, see "useq_wafer.id_useq_wafer_tmp"',
  `id_run` INT UNSIGNED NOT NULL COMMENT 'NPG run identifier',
  `tag_index` SMALLINT UNSIGNED DEFAULT NULL COMMENT 'NPG tag index',
  `id_useq_product` CHAR(64) NOT NULL COMMENT 'Product id',
  `is_sequencing_control` TINYINT(1) DEFAULT 0 \
    COMMENT 'A boolean flag. If true, this is an internal control',
  `ultimagen_Index_Label` VARCHAR(255) DEFAULT NULL \
    COMMENT 'Ultimagen barcode label',
  `ultimagen_Index_Sequence` VARCHAR(255) DEFAULT NULL \
    COMMENT 'Ultimagen barcode sequence',
  `ultimagen_Sample_Id` VARCHAR(255) DEFAULT NULL \
    COMMENT 'Name the sample is deplexed under by Ultimagen Genomics, see also ultima:Sample_ID iRODS metadata',
  `qc_seq` TINYINT(1) DEFAULT NULL \
    COMMENT 'Sequencing lane level QC outcome, a result of either manual or automatic assessment by core',
  `qc_lib` TINYINT(1) DEFAULT NULL \
    COMMENT 'Library QC outcome, a result of either manual or automatic assessment by core',
  `qc` TINYINT(1) DEFAULT NULL \
    COMMENT 'Overall QC assessment outcome, a logical product (conjunction) of qc_seq and qc_lib values, defaults to the qc_seq value when qc_lib is not defined',
  `tag_decode_count` BIGINT UNSIGNED DEFAULT NULL \
    COMMENT 'Number of reads on a wafer assigned to this library after deplexing',
  `tag_decode_percent` FLOAT UNSIGNED DEFAULT NULL \
    COMMENT 'Percent of reads on a wafer, which is assigned to this library after deplexing',  
  `q20_yield_kb` INT UNSIGNED DEFAULT NULL COMMENT 'Yield in KBs at and above Q20',
  `q30_yield_kb` INT UNSIGNED DEFAULT NULL COMMENT 'Yield in KBs at and above Q30',
  `total_yield_kb` INT UNSIGNED DEFAULT NULL COMMENT 'Overall sample yield in KBs',
  PRIMARY KEY (`id_useq_pr_metrics_tmp`),
  UNIQUE KEY `useq_prm_product_unique` (`id_useq_product`),
  KEY `useq_pm_run_tag_index` (`id_run`, `tag_index`),
  KEY `useq_pm_seqcontrol_tag_index` (`is_sequencing_control`, `tag_index`),
  KEY `useq_pm_tagseq_index` (`ultimagen_Index_Sequence`),
  KEY `useq_sample_name` (`ultimagen_Sample_ID`),
  CONSTRAINT `useq_pr_metrics_wafer_fk` FOREIGN KEY (`id_useq_wafer_tmp`) \
    REFERENCES `useq_wafer` (`id_useq_wafer_tmp`) ON DELETE SET NULL,
  CONSTRAINT `useq_pr_metrics_run_fk` FOREIGN KEY (`id_run`) \
    REFERENCES `useq_run_metrics` (`id_run`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

