

  create view test.incremental_appmetrica_events_default_profiles__dbt_tmp 
  
  as (
    SELECT *
FROM test.normalize_appmetrica_events_default_profiles

  )