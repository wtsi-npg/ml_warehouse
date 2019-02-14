ALTER TABLE iseq_product_metrics
MODIFY COLUMN `id_iseq_product` CHAR(64) NOT NULL \
  COMMENT 'Product id',
DROP KEY `iseq_pr_metrics_product_index`,
ADD UNIQUE KEY `iseq_pr_metrics_product_unique` (`id_iseq_product`);

OPTIMIZE TABLE iseq_product_metrics, iseq_run_lane_metrics;

