

  create view test.incremental_yd_datestat_default_custom_report 
  
  as (
    SELECT *
FROM test.normalize_yd_datestat_default_custom_report

  )