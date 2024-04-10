

  create view test.incremental_mt_datestat_default_banners__dbt_tmp 
  
  as (
    SELECT *
FROM test.normalize_mt_datestat_default_banners

  )