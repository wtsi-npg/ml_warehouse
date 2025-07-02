-- NPG tables in support of sequencing on Element Biosciences instruments.

-- Elembio run and lane representation
CREATE TABLE `eseq_run_lane_metrics` (
  `last_changed` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP \
    COMMENT 'Date this record was created or changed', 
  `id_run` int unsigned NOT NULL COMMENT 'NPG run identifier',
  `lane` smallint unsigned NOT NULL COMMENT 'Flowcell lane number',
  `run_folder_name` varchar(255) NOT NULL COMMENT 'Instrument run folder name',
  `flowcell_barcode` varchar(255) DEFAULT NULL \
    COMMENT 'Manufacturer flowcell barcode',
  `instrument_name` char(32) NOT NULL COMMENT 'Instrument name in NPG tracking system',
  `instrument_external_name` varchar(255) NOT NULL \
    COMMENT 'Name assigned to the instrument by the manufacturer',
  `instrument_model` varchar(255) NOT NULL Comment 'Instrument model',
  `instrument_side` char(1) DEFAULT NULL COMMENT 'Instrument side (A or B)',
  `paired_read` tinyint unsigned DEFAULT NULL DEFAULT 0,
  `run_priority` tinyint unsigned DEFAULT NULL,
  `cancelled` tinyint unsigned NOT NULL DEFAULT 0 \
    COMMENT 'Boolean flag to indicate whether the run was failed in some way or its data has been discarded',
  `run_started` datetime DEFAULT NULL COMMENT 'Timestamp of run started status',
  `run_complete` datetime DEFAULT NULL COMMENT 'Timestamp of run complete status',
  `lane_released` datetime DEFAULT NULL COMMENT 'Timestamp of lane released status' \
    COMMENT 'The date the lane was released, ie QC-ed if applicable and fully archived',
  `run_archived` datetime DEFAULT NULL COMMENT 'Timestamp of run archived status' \
    COMMENT 'The date the run was released, ie QC-ed if applicable and fully archived',
  `qc_seq` tinyint(1) DEFAULT NULL \
    COMMENT 'Sequencing lane level QC outcome, a result of either manual or automatic assessment by core',
  `cycles` int unsigned NOT NULL \
    COMMENT 'Actual number of cycles excluding index reads',
  `num_polonies` bigint unsigned DEFAULT NULL \
    COMMENT 'Number of polonies (reads) for this lane',  
  `tags_decode_percent` float unsigned DEFAULT NULL \
    COMMENT 'An overall percent of polonies (reads) assigned to expected barcodes',
  PRIMARY KEY (`id_run`,`lane`),
  KEY `eseq_rlm_run_archived_index` (`run_archived`),
  KEY `eseq_rf_name_index` (`run_folder_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


-- A product row represents either an individual barcoded library and possibly
-- the end product or in future a merged end product.
CREATE TABLE `eseq_product_metrics` (
  `id_eseq_pr_metrics_tmp` bigint unsigned NOT NULL AUTO_INCREMENT \
    COMMENT 'Internal to this database id, value can change',
  `last_changed` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP \
    COMMENT 'Date this record was created or changed',
  `id_eseq_product` char(64) NOT NULL COMMENT 'Product id',
  `id_eseq_flowcell_tmp` int unsigned DEFAULT NULL \
    COMMENT 'Foreign key, see "eseq_flowcell.id_eseq_flowcell_tmp"',
  `id_run` int unsigned NOT NULL COMMENT 'NPG run identifier',
  `lane` smallint unsigned DEFAULT NULL COMMENT 'Flowcell lane number',
  `tag_index` smallint unsigned DEFAULT NULL \
    COMMENT 'Lane-specific sequential unique index for a set of barcodes used to tag libraries derived from the same sample',
  `eseq_composition_tmp` varchar(600) DEFAULT NULL \
    COMMENT 'JSON representation of the composition object, the column might be deleted in future',
  `elembio_SampleName` varchar(255) DEFAULT NULL \
    COMMENT 'Name the sample is deplexed under by Element Biosciences software, corresponds to elembio:SampleName iRODS metadata', 
  `elembio_Project` varchar(10) DEFAULT NULL \
    COMMENT 'Project record for this library in Elembio output files. Ideally should correspond to study.id_study_lims',
  `is_sequencing_control` tinyint(1) DEFAULT 0 \
    COMMENT 'A boolean flag. If true, this is PhiX control library',
  `tag_sequence` varchar(30) DEFAULT NULL \
    COMMENT 'Tag sequence used for deplexing the lane data, I1 read',
  `tag2_sequence` varchar(30) DEFAULT NULL \
    COMMENT 'Tag sequence used for deplexing the lane data, I2 read',
  `qc_seq` tinyint(1) DEFAULT NULL \
    COMMENT 'Sequencing lane level QC outcome, a result of either manual or automatic assessment by core',
  `qc_lib` tinyint(1) DEFAULT NULL \
    COMMENT 'Library QC outcome, a result of either manual or automatic assessment by core',
  `qc` tinyint(1) DEFAULT NULL \
    COMMENT 'Overall QC assessment outcome, a logical product (conjunction) of qc_seq and qc_lib values, defaults to the qc_seq value when qc_lib is not defined',
  `tag_decode_count` bigint unsigned DEFAULT NULL \
    COMMENT 'Number of polonies (reads) assigned to this library after deplexing',
  `tag_decode_percent` float unsigned DEFAULT NULL \
    COMMENT 'Percent of polonies (reads) in a lane, which is assigned to this library after deplexing',  
  PRIMARY KEY (`id_eseq_pr_metrics_tmp`),
  UNIQUE KEY `eseq_pr_metrics_product_tagseq_unique` (`id_eseq_product`, `tag_sequence`, `tag2_sequence`),
  KEY `eseq_pm_run_lane_tag_index` (`id_run`,`lane`,`tag_index`),
  KEY `eseq_pm_seqcontrol_tag_index` (`is_sequencing_control`, `tag_index`),
  KEY `eseq_pm_tagseq_index` (`tag_sequence`, `tag2_sequence`),
  KEY `eseq_sample_name` (`elembio_SampleName`),
  CONSTRAINT `eseq_pr_metrics_flc_fk` FOREIGN KEY (`id_eseq_flowcell_tmp`) \
    REFERENCES `eseq_flowcell` (`id_eseq_flowcell_tmp`) ON DELETE SET NULL,
  CONSTRAINT `eseq_pr_metrics_lm_fk` FOREIGN KEY (`id_run`, `lane`) \
    REFERENCES `eseq_run_lane_metrics` (`id_run`, `lane`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

