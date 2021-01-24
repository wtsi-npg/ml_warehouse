DROP TABLE IF EXISTS `pac_bio_run_well_metrics`;
CREATE TABLE `pac_bio_run_well_metrics` (
  `id_pac_bio_rw_metrics_tmp` int(11) NOT NULL AUTO_INCREMENT,
  `pac_bio_run_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Lims specific identifier for the pacbio run',
  `well_label` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The well identifier for the plate, A1-H12',
  `instrument_type` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The instrument type e.g. Sequel',
  `instrument_name` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The instrument name e.g. SQ54097',
  `chip_type` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The chip type e.g. 8mChip',
  `ts_run_name` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The PacBio run name',
  `movie_name` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The PacBio movie name',
  `ccs_execution_mode` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The PacBio ccs exection mode e.g. OnInstument, OffInstument or None',
  `run_start` datetime DEFAULT NULL COMMENT 'Timestamp of run started',
  `run_complete` datetime DEFAULT NULL COMMENT 'Timestamp of run complete',
  `run_status` varchar(32) DEFAULT NULL COMMENT 'Last recorded status, primarily to explain runs not completed.',
  `well_start` datetime DEFAULT NULL COMMENT 'Timestamp of well started',
  `well_complete` datetime DEFAULT NULL COMMENT 'Timestamp of well complete',
  `well_status` varchar(32) DEFAULT NULL COMMENT 'Last recorded status, primarily to explain wells not completed.',
  `chemistry_sw_version` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The PacBio chemistry software version',
  `instrument_sw_version` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The PacBio instrument software version',
  `primary_analysis_sw_version` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The PacBio primary analysis software version',
  `polymerase_read_bases` bigint(20) unsigned DEFAULT NULL COMMENT 'Calculated by multiplying the number of productive (P1) ZMWs by the mean polymerase read length',
  `polymerase_num_reads`  int(10) unsigned DEFAULT NULL COMMENT 'The number of polymerase reads',
  `polymerase_read_length_mean` int(10) unsigned DEFAULT NULL COMMENT 'The mean high-quality read length of all polymerase reads',
  `polymerase_read_length_n50` int(10) unsigned DEFAULT NULL COMMENT 'Fifty percent of the trimmed read length of all polymerase reads are longer than this value',
  `insert_length_mean` int(10) unsigned DEFAULT NULL COMMENT  'The average subread length, considering only the longest subread from each ZMW',
  `insert_length_n50` int(10) unsigned DEFAULT NULL COMMENT 'Fifty percent of the subreads are longer than this value when considering only the longest subread from each ZMW',
  `unique_molecular_bases` bigint(20) unsigned DEFAULT NULL COMMENT 'The unique molecular yield in bp',
  `productive_ZMWs_num` int(10) unsigned DEFAULT NULL COMMENT 'Number of productive ZMWs', 
  `p0_num` int(10) unsigned DEFAULT NULL COMMENT 'Number of empty ZMWs with no high quality read detected',
  `p1_num` int(10) unsigned DEFAULT NULL COMMENT 'Number of ZMWs with a high quality read detected',
  `p2_num` int(10) unsigned DEFAULT NULL COMMENT 'Number of other ZMWs, signal detected but no high quality read',
  `adapter_dimer_percent` float(5,2) unsigned DEFAULT NULL COMMENT 'The percentage of pre-filter ZMWs which have observed inserts of 0-10 bp',
  `short_insert_percent` float(5,2) unsigned DEFAULT NULL COMMENT 'The percentage of pre-filter ZMWs which have observed inserts of 11-100 bp',
  PRIMARY KEY (`id_pac_bio_rw_metrics_tmp`),
  UNIQUE KEY `pac_bio_metrics_run_well` (`pac_bio_run_name`,`well_label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `pac_bio_product_metrics`;
CREATE TABLE `pac_bio_product_metrics` (
  `id_pac_bio_pr_metrics_tmp` int(11) NOT NULL AUTO_INCREMENT,
  `id_pac_bio_rw_metrics_tmp` int(11) NOT NULL COMMENT 'PacBio run well metrics id, see "pac_bio_run_well_metrics.id_pac_bio_rw_metrics_tmp"',
  `id_pac_bio_tmp` int(11) DEFAULT NULL COMMENT 'PacBio run id, see "pac_bio_run.id_pac_bio_tmp"',
  PRIMARY KEY (`id_pac_bio_pr_metrics_tmp`),
  KEY `pac_bio_pr_metrics_to_rwm_fk` (`id_pac_bio_rw_metrics_tmp`),
  KEY `pac_bio_pr_metrics_to_run_fk` (`id_pac_bio_tmp`),
  CONSTRAINT `pac_bio_product_metrics_to_rwm_fk` FOREIGN KEY (`id_pac_bio_rw_metrics_tmp`) REFERENCES `pac_bio_run_well_metrics` (`id_pac_bio_rw_metrics_tmp`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `pac_bio_product_metrics_to_run_fk` FOREIGN KEY (`id_pac_bio_tmp`) REFERENCES `pac_bio_run` (`id_pac_bio_tmp`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

