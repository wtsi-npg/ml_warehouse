DROP TABLE IF EXISTS `seq_product_irods_locations`;
CREATE TABLE `seq_product_irods_locations` (
  `id_seq_product_irods_locations_tmp` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT \
  COMMENT 'Internal to this database id, value can change',
  `created` DATETIME DEFAULT CURRENT_TIMESTAMP \
  COMMENT 'Datetime this record was created',
  `last_changed` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP \
  COMMENT 'Datetime this record was created or changed',
  `id_product` VARCHAR(64) NOT NULL \
  COMMENT 'Product id, maps to value in product metrics table, such as id_iseq_product in iseq_product_metrics',
  `seq_platform_name` ENUM('Illumina', 'PacBio', 'ONT') NOT NULL \
  COMMENT 'Name of the sequencing platform used to produce raw data',
  `pipeline_name` VARCHAR(16) NOT NULL \
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
