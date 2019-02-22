ALTER TABLE iseq_product_metrics
MODIFY COLUMN `id_iseq_pr_metrics_tmp` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT \
  COMMENT 'Internal to this database id, value can change',
MODIFY COLUMN `id_iseq_product` CHAR(64) NOT NULL \
  COMMENT 'Product id',
DROP KEY `iseq_pr_metrics_product_index`,
ADD UNIQUE KEY `iseq_pr_metrics_product_unique` (`id_iseq_product`);

OPTIMIZE TABLE iseq_product_metrics, iseq_run_lane_metrics;

CREATE TABLE iseq_product_components (
  `id_iseq_pr_components_tmp` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT \
    COMMENT 'Internal to this database id, value can change',
  `id_iseq_pr_tmp` BIGINT UNSIGNED NOT NULL \
    COMMENT 'iseq_product_metrics table row id for the product',
  `id_iseq_pr_component_tmp` BIGINT UNSIGNED NOT NULL \
    COMMENT "iseq_product_metrics table row id for one of this product's components",
  `num_components` TINYINT(3) UNSIGNED NOT NULL \
    COMMENT 'Number of component products for this product',
  PRIMARY KEY (`id_iseq_pr_components_tmp`),
  UNIQUE KEY `iseq_pr_comp_unique` (`id_iseq_pr_tmp`, `id_iseq_pr_component_tmp`),
  CONSTRAINT `iseq_pr_comp_pr_fk` FOREIGN KEY (`id_iseq_pr_tmp`) \
    REFERENCES `iseq_product_metrics` (`id_iseq_pr_metrics_tmp`) \
    ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `iseq_pr_comp_pr_comp_fk` FOREIGN KEY (`id_iseq_pr_component_tmp`) \
    REFERENCES `iseq_product_metrics` (`id_iseq_pr_metrics_tmp`) \
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  KEY `iseq_pr_comp_ncomp` (`num_components`,`id_iseq_pr_tmp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




