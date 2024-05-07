

  create view test.normalize_appmetrica_events_default_sessions_starts__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'session_start_datetime') AS __date, 
        JSONExtractString(_airbyte_data, '__clientName') AS __clientName, 
        JSONExtractString(_airbyte_data, '__productName') AS __productName, 
        JSONExtractString(_airbyte_data, 'appmetrica_device_id') AS appmetrica_device_id, 
        JSONExtractString(_airbyte_data, 'city') AS city, 
        JSONExtractString(_airbyte_data, 'google_aid') AS google_aid, 
        JSONExtractString(_airbyte_data, 'installation_id') AS installation_id, 
        JSONExtractString(_airbyte_data, 'ios_ifa') AS ios_ifa, 
        JSONExtractString(_airbyte_data, 'os_name') AS os_name, 
        JSONExtractString(_airbyte_data, 'profile_id') AS profile_id, 
        JSONExtractString(_airbyte_data, 'session_start_datetime') AS session_start_datetime,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        toDateTime32(substring(_airbyte_emitted_at, 1, 19)) AS __emitted_at, 
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('_airbyte_raw_appmetrica_events_default_testaccount_sessions_starts') AS _dbt_source_relation,
        toString("_airbyte_ab_id") AS _airbyte_ab_id ,
        toString("_airbyte_data") AS _airbyte_data ,
        toString("_airbyte_emitted_at") AS _airbyte_emitted_at 
FROM test._airbyte_raw_appmetrica_events_default_testaccount_sessions_starts
)

)
  )