DROP TABLE IF EXISTS `iseq_run`;
CREATE TABLE `iseq_run` (
  `id_run` int(10) unsigned NOT NULL COMMENT 'NPG run identifier',
  `id_flowcell_lims` varchar(20) DEFAULT NULL COMMENT 'LIMS specific flowcell id',
  `folder_name` varchar(64) DEFAULT NULL COMMENT 'Runfolder name',
  PRIMARY KEY (`id_run`),
  KEY `iseq_run_id_flowcell_lims` (`id_flowcell_lims`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci\
  COMMENT 'Table linking run and flowcell identities with the run folder name';
