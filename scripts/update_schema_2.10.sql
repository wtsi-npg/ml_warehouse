DROP TABLE IF EXISTS `pac_bio_run_metrics`;
CREATE TABLE `pac_bio_run_metrics` (
  `id_pac_bio_run_metrics_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_pac_bio_run_lims` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Lims specific identifier for the pacbio run',
  `well_label` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The well identifier for the plate, A1-H12',
  `instrument_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The instrument type e.g. Sequel',
  `instrument_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The instrument name e.g. SQ54097',
  `run_started` datetime DEFAULT NULL COMMENT 'Timestamp of run started',
  `run_completed` datetime DEFAULT NULL COMMENT 'Timestamp of run complete',
  `estimated_yield_kb` int(10) unsigned DEFAULT NULL COMMENT 'Calculated by multiplying the number of productive (P1) ZMWs by the mean polymerase read length - in kb',
  `num_reads` bigint(20) unsigned DEFAULT NULL,
  `adapter_dimer_percent` float(5,2) unsigned DEFAULT NULL COMMENT 'The percentage of pre-filter ZMWs which have observed inserts of 0-10 bp',
  `short_insert_percent` float(5,2) unsigned DEFAULT NULL COMMENT 'The percentage of pre-filter ZMWs which have observed inserts of 11-100 bp',
  `p0_percent` float(5,2) unsigned DEFAULT NULL COMMENT 'Empty ZMW with no high quality read detected',
  `p1_percent` float(5,2) unsigned DEFAULT NULL COMMENT 'ZMW with a high quality read detected',
  `p2_percent` float(5,2) unsigned DEFAULT NULL COMMENT 'Other, signal detected but no high quality read',
  `polymerase_read_length_mean` int(10) unsigned DEFAULT NULL COMMENT 'The mean high-quality read length of all polymerase reads',
  `polymerase_read_length_n50` int(10) unsigned DEFAULT NULL COMMENT 'Fifty percent of the trimmed read length of all polymerase reads are longer than this value',
  `insert_length_mean` int(10) unsigned DEFAULT NULL COMMENT  'The average subread length, considering only the longest subread from each ZMW',
  `insert_length_n50` int(10) unsigned DEFAULT NULL COMMENT 'Fifty percent of the subreads are longer than this value when considering only the longest subread from each ZMW',
  PRIMARY KEY (`id_pac_bio_run_metrics_tmp`),
  UNIQUE KEY `pac_run_metrics_run_well_index` (`id_pac_bio_run_lims`,`well_label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
