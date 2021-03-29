DROP TABLE IF EXISTS `iseq_run`;
CREATE TABLE `iseq_run` (
  `id_run` int(10) unsigned NOT NULL COMMENT 'NPG run identifier',
  `id_flowcell_lims` varchar(20) DEFAULT NULL COMMENT 'LIMS specific flowcell id',
  `folder_name` varchar(64) DEFAULT NULL COMMENT 'Runfolder name'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 \
  COMMENT 'Table linking iseq_flowcell table to iseq_run_status table';
