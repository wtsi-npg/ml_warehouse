ALTER TABLE `eseq_run`
  ADD COLUMN `run_manifest` JSON DEFAULT NULL
  COMMENT 'The content of RunManifest.json file in the run folder';