ALTER TABLE `iseq_external_product_metrics`
  DROP KEY `iseq_ext_pr_sample_name`,
  DROP KEY `iseq_ext_pr_metrics_pr_file_name`,
  DROP KEY `iseq_ext_pr_metrics_pr_file_path`,
  DROP KEY `iseq_ext_pr_plate_id`,
  CHANGE COLUMN `file_name_wsi` `file_name` \
    varchar(300) NOT NULL \
   COMMENT 'Comma-delimitered alphabetically sorted list of file names, which unambigiously define WSI sources of data',
  CHANGE COLUMN `file_path_wsi` `file_path` \
   varchar(760) NOT NULL \
   COMMENT 'Comma-delimitered alphabetically sorted list of full external file paths for the files in file_names column as uploaded by WSI',
  MODIFY COLUMN `manifest_upload_status` char(15) DEFAULT NULL \
    COMMENT 'WSI manifest upload status, one of "IN PROGRESS", "DONE", "FAIL", not set for multiple source files',
  CHANGE COLUMN `manifest_upload_date` `manifest_upload_status_change_date` \
    datetime DEFAULT NULL \
    COMMENT 'Date the status of manifest upload is changed by WSI',
  CHANGE COLUMN `supplier_sample_name_wsi` `supplier_sample_name` \
    varchar(255) DEFAULT NULL \
    COMMENT 'Sample name given by the supplier, as recorded by WSI',
  CHANGE COLUMN `plate_id_wsi` `plate_barcode` \
    varchar(255) DEFAULT NULL \
    COMMENT 'Stock plate barcode, as recorded by WSI',
  CHANGE COLUMN `md5_wsi` `md5_staging` \
    char(32) DEFAULT NULL \
    COMMENT 'WSI validation hex MD5, not set for multiple source files',
  ADD COLUMN `library_id` int(11) DEFAULT NULL \
    COMMENT 'WSI library identifier' \
    AFTER `plate_barcode`,
  MODIFY COLUMN `md5` char(32) DEFAULT NULL \
    COMMENT 'External validation hex MD5, not set for multiple source files',
  ADD UNIQUE KEY `iseq_ext_pr_file_path` (`file_path`),
  ADD KEY `iseq_ext_pr_fname` (`file_name`),
  ADD KEY `iseq_ext_pr_lib_id` (`library_id`),
  ADD KEY `iseq_ext_pr_sample_name` (`supplier_sample_name`),
  ADD KEY `iseq_ext_pr_plate_bc` (`plate_barcode`);
