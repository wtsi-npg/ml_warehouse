
-- Add extra columns to iseq_product_metrics for C2A substitution metrics
ALTER TABLE iseq_product_metrics
  ADD COLUMN `sub_titv_class` float unsigned DEFAULT NULL COMMENT 'The ratio of transition substitution counts to transvertion'
    AFTER `target_autosome_percent_gt_coverage_threshold`,
  ADD COLUMN `sub_titv_mean_ca` float unsigned DEFAULT NULL COMMENT 'TiTv where count of CA+GT is taken as if it were mean across other transversions'
    AFTER `sub_titv_class`,
  ADD COLUMN `sub_frac_sub_hq` float unsigned DEFAULT NULL COMMENT 'Fraction of substitutions which are high quality (>=Q30)'
    AFTER `sub_titv_mean_ca`,
  ADD COLUMN `sub_oxog_bias` float unsigned DEFAULT NULL COMMENT 'How similar CA to GT counts are within each read (high quality >=Q30 substitutions only) in order to detect OxoG oxidative artifacts'
    AFTER `sub_frac_sub_hq`,
  ADD COLUMN `sub_sym_gt_ca` float unsigned DEFAULT NULL COMMENT 'How symmetrical CA and GT counts are within each read'
    AFTER `sub_oxog_bias`,
  ADD COLUMN `sub_sym_ct_ga` float unsigned DEFAULT NULL COMMENT 'How symmetrical CT and GA counts are within each read'
    AFTER `sub_sym_gt_ca`,
  ADD COLUMN `sub_sym_ag_tc` float unsigned DEFAULT NULL COMMENT 'How symmetrical AG and TC counts are within each read'
    AFTER `sub_sym_ct_ga`,
  ADD COLUMN `sub_cv_ti` float unsigned DEFAULT NULL COMMENT 'Coefficient of variation across all Ti substitutions = std(Ti)/mean(Ti)'
    AFTER `sub_sym_ag_tc`,
  ADD COLUMN `sub_gt_ti` float unsigned DEFAULT NULL COMMENT 'Computed as a maximum between (i) ratio of GT counts to TC and (ii) ratio CA to GA'
    AFTER `sub_cv_ti`,
  ADD COLUMN `sub_gt_mean_ti` float unsigned DEFAULT NULL COMMENT 'Computed as a maximum between (i) ratio of GT counts to mean(Ti) and (ii) ratio CA to mean(Ti)'
    AFTER  `sub_gt_ti`,
  ADD COLUMN `sub_ctoa_oxh` float unsigned DEFAULT NULL COMMENT 'This metric is used to compute the likelihood of C2A and its predicted level'
    AFTER `sub_gt_mean_ti`,
  ADD COLUMN `sub_ctoa_art_predicted_level` tinyint(1) unsigned DEFAULT NULL COMMENT 'C2A predicted level - 0 = not present, 1 = low, 2 = medium and 3 = high'
    AFTER `sub_ctoa_oxh`;


-- Add extra columns to pac_bio_run_well_metrics for SMRT Link 11 configuaration
ALTER TABLE pac_bio_run_well_metrics
  ADD COLUMN `hifi_only_reads` tinyint(1) unsigned DEFAULT NULL COMMENT 'CCS was run on the instrument and only HiFi reads were included in the export from the instrument'
  AFTER `include_kinetics`,
  ADD COLUMN `heteroduplex_analysis` tinyint(1) unsigned DEFAULT NULL COMMENT 'Analysis has been run on the instrument to detect and resolve heteroduplex reads'
  AFTER `hifi_only_reads`;
