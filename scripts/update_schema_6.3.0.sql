-- Table update for iseq_external_product_metrics:
-- drops id_iseq_pr_metrics_tmp and a foreign key based on it
--   since maintenence will be difficult,
-- adds index on id_iseq_product to enable using this column
--   in joining to iseq_product_metrics table on a similar
--   column,
-- adds an indexed id_run column in case stats by run is needed

ALTER TABLE `iseq_external_product_metrics`
DROP FOREIGN KEY `iseq_ext_pr_metrics_same_product`, \
DROP KEY `iseq_ext_pr_metrics_same_product`, \
DROP COLUMN `id_iseq_pr_metrics_tmp`, \
ADD COLUMN `id_run` int(10) unsigned DEFAULT NULL \
  COMMENT 'NPG run identifier, defined where the product corresponds to a single line' 
  AFTER `manifest_upload_status_change_date`, \
ADD KEY `iseq_ext_pr_id_product` (`id_iseq_product`), \
ADD KEY `iseq_ext_pr_id_run` (`id_run`);
