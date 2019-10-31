-- Convert columns that can potentially be used in linking this table to other
-- tables to character set and collation used in other tables
ALTER TABLE `iseq_external_product_metrics` \
  MODIFY `supplier_sample_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL \
  COMMENT 'Sample name given by the supplier, as recorded by WSI',
  MODIFY `plate_barcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL \
  COMMENT 'Stock plate barcode, as recorded by WSI',
  MODIFY `id_iseq_product` char(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL \
  COMMENT 'product id',
  MODIFY `yield` float unsigned DEFAULT NULL \
  COMMENT 'sequence data quantity (Gb), autosome';

-- Drop empty table, we need a different schema
DROP TABLE `iseq_external_product_components`;

-- Recreate table, use product ids for linking - this ensures that
-- we do not need to reload the links when rows are deleted and
-- recteated in iseq_product_metrics.
--
-- Not setting a foreign key on the id_iseq_product since this will
-- make impossible un-coordinated deletions from iseq_product_metrics
-- table.
CREATE TABLE `iseq_external_product_components` (
  `id_iseq_ext_pr_components_tmp` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change', 
  `id_iseq_product_ext` char(64) NOT NULL COMMENT 'id (digest) for the external product composition',
  `id_iseq_product` char(64) NOT NULL COMMENT 'id (digest) for one of the products components',
  `num_components` tinyint(3) unsigned NOT NULL COMMENT 'Number of component products for this product',
  `component_index` tinyint(3) unsigned NOT NULL COMMENT 'Unique component index within all components of this product, a value from 1 to the value of num_components column for this product',
  PRIMARY KEY (`id_iseq_ext_pr_components_tmp`),
  UNIQUE KEY `iseq_ext_pr_comp_unique` (`id_iseq_product`,`id_iseq_product_ext`),
  KEY `iseq_ext_pr_comp_pr_comp_fk` (`id_iseq_product_ext`),
CONSTRAINT `id_iseq_product_ext_digest_fk` FOREIGN KEY (`id_iseq_product_ext`) REFERENCES `iseq_external_product_metrics` (`id_iseq_product`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  KEY `iseq_ext_pr_comp_ncomp` (`num_components`,`id_iseq_product`),
  KEY `iseq_ext_pr_comp_compi` (`component_index`,`num_components`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT \
  'Table linking iseq_external_product_metrics table products to components in the iseq_product_metrics table';


