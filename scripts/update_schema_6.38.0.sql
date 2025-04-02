--
-- Change iseq_product_metrics tag_decode_count from int to bigint
-- 

ALTER TABLE `iseq_product_metrics`
  MODIFY COLUMN tag_decode_count BIGINT UNSIGNED DEFAULT NULL;
