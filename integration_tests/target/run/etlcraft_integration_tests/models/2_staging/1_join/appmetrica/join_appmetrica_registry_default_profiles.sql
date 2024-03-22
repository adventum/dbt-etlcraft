

  create view test.join_appmetrica_registry_default_profiles__dbt_tmp 
  
  as (
    SELECT
    appmetrica_device_id AS appmetricaDeviceId,
    profile_id AS crmUserId,
    mp_card_number AS mpCardNumber,
    city_code AS cityCode,
    __emitted_at
    
FROM test.incremental_appmetrica_registry_default_profiles





  )