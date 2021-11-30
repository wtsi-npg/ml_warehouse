-- Add columns for file deletion status in iseq_external_product_metrics
ALTER TABLE `iseq_external_product_metrics` 
  ADD COLUMN `input_files_status` CHAR(10) DEFAULT NULL 
    COMMENT "Status of the input files, either 'USEABLE' or 'DELETED'",
  ADD COLUMN `intermediate_files_status` CHAR(10) DEFAULT NULL 
    COMMENT "Status of the intermediate files, either 'USEABLE' or 'DELETED'",
  ADD COLUMN `output_files_status` CHAR(10) DEFAULT NULL 
    COMMENT "Status of the output files, either 'ARCHIVED', 'USEABLE' or 'DELETED'",
  ADD COLUMN `input_status_override_ref` VARCHAR(255) DEFAULT NULL
    COMMENT "Status override reference for the input files",
  ADD COLUMN `intermediate_status_override_ref` VARCHAR(255) DEFAULT NULL
    COMMENT "Status override reference for the intermediate files",
  ADD COLUMN `output_status_override_ref` VARCHAR(255) DEFAULT NULL
    COMMENT "Status override reference for the output files";
