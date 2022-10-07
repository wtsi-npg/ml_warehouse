-- Add product id to PacBio product metrics table
ALTER TABLE pac_bio_product_metrics
  ADD `id_pac_bio_product` CHAR(64) DEFAULT NULL COMMENT 'Product id'
  AFTER `id_pac_bio_tmp`,
  ADD UNIQUE KEY `pac_bio_pr_metrics_id_product` (`id_pac_bio_product`);

-- Add product id to PacBio run well metrics table
ALTER TABLE pac_bio_run_well_metrics
  ADD `id_pac_bio_product` CHAR(64) DEFAULT NULL COMMENT 'Product id'
  AFTER `id_pac_bio_rw_metrics_tmp`,
  ADD UNIQUE KEY `pac_bio_rw_metrics_id_product` (`id_pac_bio_product`);