CREATE TABLE `iseq_run_info` (
  `id_run` INT(10) UNSIGNED NOT NULL COMMENT 'NPG run identifier',
  `run_parameters_xml` TEXT DEFAULT NULL \
    COMMENT "The contents of Illumina's {R,r}unParameters.xml file",
  PRIMARY KEY (`id_run`),
  FOREIGN KEY (`id_run`) REFERENCES iseq_run(`id_run`) \
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci\
  COMMENT 'Table storing selected text files from the run folder';
 
ALTER TABLE `iseq_run` \
  ADD COLUMN `rp__read1_number_of_cycles` \
    SMALLINT UNSIGNED DEFAULT NULL COMMENT 'Read 1 number of cycles',
  ADD COLUMN `rp__read2_number_of_cycles` \
    SMALLINT UNSIGNED DEFAULT NULL COMMENT 'Read 2 number of cycles',
  ADD COLUMN `rp__flow_cell_mode` \
    VARCHAR(4) DEFAULT NULL COMMENT 'Flowcell mode',
  ADD COLUMN `rp__workflow_type` \
    VARCHAR(16) DEFAULT NULL COMMENT 'Workflow type',
  ADD COLUMN `rp__flow_cell_consumable_version` \
    VARCHAR(4) DEFAULT NULL COMMENT 'Flowcell consumable version', 
  ADD COLUMN `rp__sbs_consumable_version` \
    VARCHAR(4) DEFAULT NULL COMMENT 'Sbs consumable version';
