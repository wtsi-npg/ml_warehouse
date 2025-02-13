CREATE TABLE `eseq_run` (
  `id_eseq_run_tmp` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT \
    COMMENT 'Internal to this database id, value can change',
  folder_name varchar(200) NOT NULL \
    COMMENT 'Run folder name created by the Element Biosciences instrument',
  run_name varchar(100) NOT NULL \
    COMMENT 'Run name as recorded in RunParameters.json file',
  flowcell_id varchar(100) NOT NULL \
    COMMENT 'Flowcell ID as recorded in RunParameters.json file',
  date_started datetime DEFAULT NULL \
    COMMENT 'Run date as recorded in RunParameters.json file',
  date_completed datetime DEFAULT NULL \
    COMMENT 'Run completion date from a timestamp of RunUploaded.json file',
  run_parameters JSON NOT NULL \
    COMMENT 'The content of RunParameters.json file in the run folder',
  run_stats JSON DEFAULT NULL \
    COMMENT 'The content of AvitiRunStats.json file in the run folder',
  outcome varchar(256) DEFAULT NULL \
    COMMENT 'Run outcome as recorded in RunUploaded.json file',
  PRIMARY KEY (`id_eseq_run_tmp`),
  UNIQUE KEY `eseq_run_fname_unique` (`folder_name`)
) DEFAULT CHARSET=utf8 COMMENT \
  'Information about a run performed on an Element Biosciences instrument derived from instrument output';  
