alter table iseq_run_lane_metrics \
  modify column unexpected_tags_percent float (5,2) unsigned default null 
  comment 'tag0_perfect_match_reads as a percentage of total_lane_reads';

