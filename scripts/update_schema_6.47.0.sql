ALTER TABLE `useq_product_metrics`
  ADD COLUMN `genotype_sample_name_match` VARCHAR(8) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  ADD COLUMN `genotype_sample_name_relaxed_match` VARCHAR(8) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  ADD COLUMN  `genotype_mean_depth` FLOAT DEFAULT NULL;
