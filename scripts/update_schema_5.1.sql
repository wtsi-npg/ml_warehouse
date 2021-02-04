--
-- Allow to store longer composition JSON strings in iseq_product_metrics
--

ALTER TABLE `iseq_product_metrics` \
MODIFY COLUMN  `iseq_composition_tmp` varchar(600) DEFAULT NULL \
COMMENT 'JSON representation of the composition object, the column might be deleted in future';
