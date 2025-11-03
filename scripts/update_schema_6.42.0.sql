ALTER TABLE eseq_run COLLATE utf8mb3_unicode_ci;

ALTER TABLE `eseq_run`
  MODIFY `folder_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
    COMMENT 'Run folder name created by the Element Biosciences instrument',
  MODIFY `run_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
    COMMENT 'Run name as recorded in RunParameters.json file',
  MODIFY `flowcell_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
    COMMENT 'Flowcell ID as recorded in RunParameters.json file',
  MODIFY `run_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
    COMMENT 'Run type as recorded in RunParameters.json file',
  MODIFY `outcome` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
    COMMENT 'Run outcome as recorded in RunUploaded.json file';
