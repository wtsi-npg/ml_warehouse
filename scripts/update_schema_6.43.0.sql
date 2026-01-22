ALTER TABLE `seq_product_irods_locations`
  MODIFY `seq_platform_name` enum('Illumina','PacBio','ONT','Elembio','Ultimagen') NOT NULL
    COMMENT 'Name of the sequencing platform used to produce raw data';

ALTER TABLE `useq_product_metrics` \
  ADD COLUMN `ultimagen_application_type` varchar(255) DEFAULT NULL \
  COMMENT 'Pipeline/tool which was used for on-board data processing' \
  AFTER `ultimagen_Library_Name`; 
