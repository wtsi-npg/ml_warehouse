alter table iseq_run_lane_metrics \
  add column unexpected_tags_percent float (5,2) unsigned default null 
  comment 'tag0_perfect_match_reads as a percentage of total_tag0_perfect_matches_reads';

alter table iseq_product_metrics \
  add column chimeric_reads_percent float(5,2) unsigned default null
  comment 'mate_mapped_defferent_chr_5 as percentage of all' after `percent_duplicate`;

