DROP TABLE IF EXISTS `product_irods`;
CREATE TABLE `product_irods` (
  `id_product_irods_tmp` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT \
  COMMENT 'ID internal to this database',
  `id_product` VARCHAR(64) NOT NULL \
  COMMENT 'Product id',
  `platform_name` ENUM('illumina', 'pacbio', 'ont') NOT NULL \
  COMMENT 'Name of the platform used to produce raw data',
  `analysis_type` ENUM('original', 'alt_process', '10x', 'artic') NOT NULL \
  COMMENT 'The type of analysis used',
  `irods_root` VARCHAR(255) NOT NULL \
  COMMENT 'Path to the product root in iRODS',
  `irods_data` VARCHAR(255) \
  COMMENT 'The most accessed data path as provided by the customer',
  `irods_secondary_data` VARCHAR(255) \
  COMMENT 'A secondary data path as provided by the customer',
  PRIMARY KEY(`id_product_irods_tmp`),
  KEY `pi_id_product` (`id_product`),
  UNIQUE KEY `pi_irods_root` (`irods_root`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
