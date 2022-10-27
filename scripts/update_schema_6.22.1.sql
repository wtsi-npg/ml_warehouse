-- Add unique key to PacBio product metrics table
ALTER TABLE pac_bio_product_metrics
  ADD UNIQUE KEY `pac_bio_metrics_product` (`id_pac_bio_tmp`, `id_pac_bio_rw_metrics_tmp`);
