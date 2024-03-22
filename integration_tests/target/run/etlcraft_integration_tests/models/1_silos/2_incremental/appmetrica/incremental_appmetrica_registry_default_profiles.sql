

  create view test.incremental_appmetrica_registry_default_profiles__dbt_tmp 
  
  as (
    SELECT *
FROM test.normalize_appmetrica_registry_default_profiles

  )