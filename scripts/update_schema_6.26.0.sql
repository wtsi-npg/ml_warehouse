-- Make product id columns not nullable since LangQC relies
-- on these ids being available.
-- Set collation for product ids so that it is possible to
-- easily join PacBio tables to the seq_product_irods_locations
-- table.

ALTER TABLE `pac_bio_run_well_metrics` \
  MODIFY COLUMN `id_pac_bio_product` char(64) \
  COLLATE utf8_unicode_ci NOT NULL COMMENT 'Product id';

ALTER TABLE `pac_bio_product_metrics` \
  MODIFY COLUMN `id_pac_bio_product` char(64) \
  COLLATE utf8_unicode_ci NOT NULL COMMENT 'Product id';  
