

  create view test.incremental_vkads_datestat_default_ad_plans__dbt_tmp 
  
  as (
    SELECT *
FROM test.normalize_vkads_datestat_default_ad_plans

  )