

  create view test.incremental_yd_default_custom_report__dbt_tmp 
  
  as (
    SELECT *
FROM test.normalize_yd_default_custom_report

  )