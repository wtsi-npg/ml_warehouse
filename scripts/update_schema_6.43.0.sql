ALTER TABLE `seq_product_irods_locations`
  MODIFY `seq_platform_name` enum('Illumina','PacBio','ONT','Elembio','Ultimagen') NOT NULL
    COMMENT 'Name of the sequencing platform used to produce raw data';
