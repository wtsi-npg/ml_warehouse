-- NPG tables in support of sequencing on Ultima Genomics instruments.

-- Ultima run is per a silicone wafer. 
CREATE TABLE `useq_wafer_metrics` (
  `last_changed` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP \
    COMMENT 'Date this record was created or changed', 
  `id_run` int unsigned NOT NULL COMMENT 'NPG run identifier',
  `run_folder_name` varchar(255) NOT NULL COMMENT 'Instrument run folder name',
  `ultima_RunId` varchar(255) DEFAULT NULL \
    COMMENT 'Manufacturer Run ID',
  `instrument_name` char(32) NOT NULL COMMENT 'Instrument name in NPG tracking system',
  `instrument_external_name` varchar(255) NOT NULL \
    COMMENT 'Name assigned to the instrument by the manufacturer',
  `instrument_model` varchar(255) NOT NULL Comment 'Instrument model',
  `run_priority` tinyint unsigned DEFAULT NULL,
  `cancelled` tinyint unsigned NOT NULL DEFAULT 0 \
    COMMENT 'Boolean flag to indicate whether the run was failed in some way or its data has been discarded',
  `run_started` datetime DEFAULT NULL COMMENT 'Timestamp of run started status',
  `run_archived` datetime DEFAULT NULL COMMENT 'Timestamp of run archived status' \
    COMMENT 'The date the run was released, ie QC-ed if applicable and fully archived',
  `qc_seq` tinyint(1) DEFAULT NULL \
    COMMENT 'Sequencing lane level QC outcome, a result of either manual or automatic assessment by core',
  `num_reads` bigint unsigned DEFAULT NULL \
    COMMENT 'Number of reads for this wafer',
  `input_num_reads` bigint unsigned DEFAULT NULL \
    COMMENT 'Number of input reads (before pf) for this wafer',  
  `tags_decode_percent` float unsigned DEFAULT NULL \
    COMMENT 'An overall percent of pf reads assigned to expected barcodes and the control',
  PRIMARY KEY (`id_run`),
  KEY `eseq_rlm_run_archived_index` (`run_archived`),
  KEY `eseq_rf_name_index` (`run_folder_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


-- A product row represents an individual barcoded library.
CREATE TABLE `useq_product_metrics` (
  `id_useq_pr_metrics_tmp` bigint unsigned NOT NULL AUTO_INCREMENT \
    COMMENT 'Internal to this database id, value can change',
  `last_changed` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP \
    COMMENT 'Date this record was created or changed',
  `id_useq_product` char(64) NOT NULL COMMENT 'Product id',
  `id_useq_wafer_tmp` int unsigned DEFAULT NULL \
    COMMENT 'Foreign key, see "useq_wafer.id_useq_wafer_tmp"',
  `id_run` int unsigned NOT NULL COMMENT 'NPG run identifier',
  `tag_index` smallint unsigned DEFAULT NULL \
    COMMENT 'Sequential unique index for an Ultima tag',
  `useq_composition_tmp` varchar(600) DEFAULT NULL \
    COMMENT 'JSON representation of the composition object, the column might be deleted in future',
  `ultima_Sample_ID` varchar(255) DEFAULT NULL \
    COMMENT 'Name the sample is deplexed under by Ultima Genomica, see also ultima:Sample_ID iRODS metadata', 
  `ultima_Library_name` varchar(255) DEFAULT NULL \
    COMMENT 'Library name as used by Ultima Genomica software',
  `ultima_Index_Barcode_Num` varchar(255) DEFAULT NULL \
    COMMENT 'Ultima barcode identifier',
  `is_sequencing_control` tinyint(1) DEFAULT 0 \
    COMMENT 'A boolean flag. If true, this is an internal control',
  `tag_sequence` varchar(30) DEFAULT NULL \
    COMMENT 'Tag sequence used for deplexing the data',
  `qc_seq` tinyint(1) DEFAULT NULL \
    COMMENT 'Sequencing lane level QC outcome, a result of either manual or automatic assessment by core',
  `qc_lib` tinyint(1) DEFAULT NULL \
    COMMENT 'Library QC outcome, a result of either manual or automatic assessment by core',
  `qc` tinyint(1) DEFAULT NULL \
    COMMENT 'Overall QC assessment outcome, a logical product (conjunction) of qc_seq and qc_lib values, defaults to the qc_seq value when qc_lib is not defined',
  `tag_decode_count` bigint unsigned DEFAULT NULL \
    COMMENT 'Number of reads on a wafer assigned to this library after deplexing',
  `tag_decode_percent` float unsigned DEFAULT NULL \
    COMMENT 'Percent of reads on a wafer, which is assigned to this library after deplexing',  
  `q20_yield_kb` int unsigned DEFAULT NULL,
  `q30_yield_kb` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id_useq_pr_metrics_tmp`),
  UNIQUE KEY `useq_pr_metrics_product_unique` (`id_useq_product`),
  KEY `useq_pm_run_tag_index` (`id_run`, `tag_index`),
  KEY `useq_pm_seqcontrol_tag_index` (`is_sequencing_control`, `tag_index`),
  KEY `useq_pm_tagseq_index` (`tag_sequence`),
  KEY `useq_sample_name` (`ultima_Sample_ID`),
  CONSTRAINT `useq_pr_metrics_flc_fk` FOREIGN KEY (`id_useq_wafer_tmp`) \
    REFERENCES `useq_wafer` (`id_useq_wafer_tmp`) ON DELETE SET NULL,
  CONSTRAINT `useq_pr_metrics_lm_fk` FOREIGN KEY (`id_run`) \
    REFERENCES `useq_wafer_metrics` (`id_run`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

