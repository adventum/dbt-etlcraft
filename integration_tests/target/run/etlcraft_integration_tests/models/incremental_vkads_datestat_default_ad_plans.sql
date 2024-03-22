

  create view test.incremental_vkads_datestat_default_ad_plans 
  
  as (
    SELECT *
FROM test.normalize_vkads_datestat_default_ad_plans

  )