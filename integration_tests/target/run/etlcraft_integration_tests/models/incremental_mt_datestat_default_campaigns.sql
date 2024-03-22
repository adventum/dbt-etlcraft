

  create view test.incremental_mt_datestat_default_campaigns 
  
  as (
    SELECT *
FROM test.normalize_mt_datestat_default_campaigns

  )