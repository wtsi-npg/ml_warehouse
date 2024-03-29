-- Create a new table to store iRODS locations
DROP TABLE IF EXISTS `seq_product_irods_locations`;
CREATE TABLE `seq_product_irods_locations` (
  `id_seq_product_irods_locations_tmp` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT \
  COMMENT 'Internal to this database id, value can change',
  `created` DATETIME DEFAULT CURRENT_TIMESTAMP \
  COMMENT 'Datetime this record was created',
  `last_changed` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP \
  COMMENT 'Datetime this record was created or changed',
  `id_product` VARCHAR(64) NOT NULL \
  COMMENT 'A sequencing platform specific product id. For Illumina, data corresponds to the id_iseq_product column in the iseq_product_metrics table',
  `seq_platform_name` ENUM('Illumina', 'PacBio', 'ONT') NOT NULL \
  COMMENT 'Name of the sequencing platform used to produce raw data',
  `pipeline_name` VARCHAR(32) NOT NULL \
  COMMENT 'The name of the pipeline used to produce the data, values are: npg-prod, npg-prod-alt-process, cellranger, spaceranger, ncov2019-artic-nf',
  `irods_root_collection` VARCHAR(255) NOT NULL \
  COMMENT 'Path to the product root collection in iRODS',
  `irods_data_relative_path` VARCHAR(255) \
  COMMENT 'The path, relative to the root collection, to the most used data location',
  `irods_secondary_data_relative_path` VARCHAR(255) \
  COMMENT 'The path, relative to the root collection, to a useful data location',
  PRIMARY KEY(`id_seq_product_irods_locations_tmp`),
  KEY `pi_id_product` (`id_product`),
  KEY `pi_seq_platform_name` (`seq_platform_name`),
  KEY `pi_pipeline_name` (`pipeline_name`),
  UNIQUE KEY `pi_root_product` (`irods_root_collection`, `id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table relating products to their irods locations';


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
