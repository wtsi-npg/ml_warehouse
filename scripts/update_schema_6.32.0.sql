-- Alter table pac_bio_product_metrics to remove hifi_read_quality_mean and add barcode4deplexing

ALTER TABLE `pac_bio_product_metrics` \
  DROP COLUMN hifi_read_quality_mean, \
  ADD COLUMN  `barcode4deplexing` varchar(62)  DEFAULT NULL \
    COMMENT 'The barcode recorded in producing deplexed metrics for this product' \
    AFTER `hifi_read_length_mean`;
