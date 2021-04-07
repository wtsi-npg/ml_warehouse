<<<<<<< HEAD
alter table pac_bio_run_well_metrics \
  add column hifi_read_bases \
  bigint unsigned DEFAULT NULL COMMENT 'The number of HiFi bases' after short_insert_percent, \
  add column hifi_num_reads \
  int unsigned DEFAULT NULL COMMENT 'The number of HiFi reads' after hifi_read_bases, \
  add column hifi_read_length_mean \
  int unsigned DEFAULT NULL COMMENT 'The mean HiFi read length' after hifi_num_reads , \
  add column hifi_read_quality_median \
  smallint unsigned DEFAULT NULL COMMENT 'The median HiFi base quality' after hifi_read_length_mean, \
  add column hifi_number_passes_mean \
  int unsigned DEFAULT NULL COMMENT 'The mean number of passes per HiFi read' after hifi_read_quality_median, \
  add column hifi_low_quality_read_bases \
  bigint unsigned DEFAULT NULL COMMENT 'The number of HiFi bases filtered due to low quality (<Q20)' after hifi_number_passes_mean, \
  add column hifi_low_quality_num_reads \
  int unsigned DEFAULT NULL COMMENT 'The number of HiFi reads filtered due to low quality (<Q20)' after hifi_low_quality_read_bases, \
  add column hifi_low_quality_read_length_mean \
  int unsigned DEFAULT NULL COMMENT 'The mean length of HiFi reads filtered due to low quality (<Q20)' after hifi_low_quality_num_reads, \
  add column hifi_low_quality_read_quality_median \
  smallint unsigned DEFAULT NULL COMMENT 'The median base quality of HiFi bases filtered due to low quality (<Q20)' after hifi_low_quality_read_length_mean;
=======
DROP TABLE IF EXISTS `iseq_run`;
CREATE TABLE `iseq_run` (
  `id_run` int(10) unsigned NOT NULL COMMENT 'NPG run identifier',
  `id_flowcell_lims` varchar(20) DEFAULT NULL COMMENT 'LIMS specific flowcell id',
  `folder_name` varchar(64) DEFAULT NULL COMMENT 'Runfolder name',
  PRIMARY KEY (`id_run`),
  KEY `iseq_run_id_flowcell_lims` (`id_flowcell_lims`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci\
  COMMENT 'Table linking run and flowcell identities with the run folder name';
>>>>>>> upstream/devel
