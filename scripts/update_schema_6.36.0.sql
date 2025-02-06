CREATE TABLE `eseq_run` (
  `id_eseq_run_tmp` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT \
    COMMENT 'Internal to this database id, value can change',
  folder_name varchar(256) NOT NULL \
    COMMENT 'Run folder name created by the Element Biosciences instrument',
  run_parameters JSON DEFAULT NULL \
    COMMENT 'The content of RunParameters.json file in the run folder',
  run_stats JSON DEFAULT NULL \
    COMMENT 'The content of AvitiRunStats.json file in the run folder',
  PRIMARY KEY (`id_eseq_run_tmp`),
  UNIQUE KEY `eseq_run_fname_unique` (`folder_name`)
) DEFAULT CHARSET=utf8 \
  COMMENT 'Information about a run performed on an Element Biosciences instrument';  
