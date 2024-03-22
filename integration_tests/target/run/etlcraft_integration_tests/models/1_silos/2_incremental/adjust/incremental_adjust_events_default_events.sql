

  create view test.incremental_adjust_events_default_events__dbt_tmp 
  
  as (
    SELECT *
FROM test.normalize_adjust_events_default_events

  )