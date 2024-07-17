

  create view test.normalize_appmetrica_events_default_sessions_starts__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'session_start_receive_datetime') AS __date, 
        JSONExtractString(_airbyte_data, '__clientName') AS __clientName, 
        JSONExtractString(_airbyte_data, '__productName') AS __productName, 
        JSONExtractString(_airbyte_data, 'appmetrica_device_id') AS appmetrica_device_id, 
        JSONExtractString(_airbyte_data, 'city') AS city, 
        JSONExtractString(_airbyte_data, 'google_aid') AS google_aid, 
        JSONExtractString(_airbyte_data, 'installation_id') AS installation_id, 
        JSONExtractString(_airbyte_data, 'ios_ifa') AS ios_ifa, 
        JSONExtractString(_airbyte_data, 'os_name') AS os_name, 
        JSONExtractString(_airbyte_data, 'profile_id') AS profile_id, 
        JSONExtractString(_airbyte_data, 'session_start_receive_datetime') AS session_start_receive_datetime,
        toLowCardinality(_dbt_source_relation) AS __table_name,
        toDateTime32(substring(toString(_airbyte_extracted_at), 1, 19)) AS __emitted_at,
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('datacraft_clientname_raw__stream_appmetrica_default_accountid_sessions_starts') AS _dbt_source_relation,
        toString("_airbyte_raw_id") AS _airbyte_raw_id,
        toString("_airbyte_data") AS _airbyte_data,
        toString("_airbyte_extracted_at") AS _airbyte_extracted_at
FROM test.datacraft_clientname_raw__stream_appmetrica_default_accountid_sessions_starts
)

)
  )