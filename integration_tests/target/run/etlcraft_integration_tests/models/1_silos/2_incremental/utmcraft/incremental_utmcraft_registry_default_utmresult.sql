

  create view test.incremental_utmcraft_registry_default_utmresult__dbt_tmp 
  
  as (
    SELECT *
FROM test.normalize_utmcraft_registry_default_utmresult

  )