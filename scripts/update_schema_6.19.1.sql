--- Table update for seq_product_irods_location to change collation of id_product

ALTER TABLE `seq_product_irods_locations`
    MODIFY `id_product` VARCHAR(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL \
    COMMENT 'A sequencing platform specific product id. For Illumina, data corresponds to the id_iseq_product column in the iseq_product_metrics table';
