ALTER TABLE `eseq_run`
  MODIFY COLUMN `run_stats` JSON DEFAULT NULL
  COMMENT 'The content of RunStats.json file produced by bases2fastq',
  ADD COLUMN `run_type` VARCHAR(100) DEFAULT NULL
  COMMENT 'Run type as recorded in RunParameters.json file' AFTER `flowcell_id`,
  ADD COLUMN `run_manifest` JSON DEFAULT NULL
  COMMENT 'The content of RunManifest.json file in the run folder' AFTER `run_parameters`;
