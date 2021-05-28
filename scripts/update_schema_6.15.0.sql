DROP TABLE IF EXISTS `product_irods`;
CREATE TABLE `product_irods` (
  `id_product_irods` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT \
  COMMENT 'ID internal to this database',
  `id_product` CHAR(64) NOT NULL \
  COMMENT 'Product id',
  `platform_name` varchar(16) NOT NULL \
  COMMENT 'Name of the platform used',
  `analysis_type` varchar(16) NOT NULL \
  COMMENT 'Name of the type of analysis used',
  `irods_path` varchar(255) NOT NULL UNIQUE \
  COMMENT 'Path to the data in iRODS',
  PRIMARY KEY(`id_product_irods`),
  KEY `pi_id_product` (`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
