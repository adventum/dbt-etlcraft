

  create view test.normalize_appmetrica_events_default_screen_view__dbt_tmp 
  
  as (
    WITH events_are_screen_view AS (SELECT *, 1 AS screen_view FROM (
SELECT
        JSONExtractString(_airbyte_data, 'event_receive_datetime') AS __date, 
        JSONExtractString(_airbyte_data, '__clientName') AS __clientName, 
        JSONExtractString(_airbyte_data, '__productName') AS __productName, 
        JSONExtractString(_airbyte_data, 'app_version_name') AS app_version_name, 
        JSONExtractString(_airbyte_data, 'appmetrica_device_id') AS appmetrica_device_id, 
        JSONExtractString(_airbyte_data, 'city') AS city, 
        JSONExtractString(_airbyte_data, 'event_json') AS event_json, 
        JSONExtractString(_airbyte_data, 'event_name') AS event_name, 
        JSONExtractString(_airbyte_data, 'event_receive_datetime') AS event_receive_datetime, 
        JSONExtractString(_airbyte_data, 'google_aid') AS google_aid, 
        JSONExtractString(_airbyte_data, 'installation_id') AS installation_id, 
        JSONExtractString(_airbyte_data, 'ios_ifa') AS ios_ifa, 
        JSONExtractString(_airbyte_data, 'os_name') AS os_name, 
        JSONExtractString(_airbyte_data, 'profile_id') AS profile_id, 
        JSONExtractString(_airbyte_data, 'session_id') AS session_id,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        toDateTime32(substring(toString(_airbyte_extracted_at), 1, 19)) AS __emitted_at, 
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('datacraft_clientname_raw__stream_appmetrica_default_events') AS _dbt_source_relation,
        toString("_airbyte_raw_id") AS _airbyte_raw_id,
        toString("_airbyte_data") AS _airbyte_data,
        toString("_airbyte_extracted_at") AS _airbyte_extracted_at
FROM airbyte_internal.datacraft_clientname_raw__stream_appmetrica_default_events
)

)
)
WHERE event_name = 'screen_view')


SELECT
    toDate(__date) AS __date,
    toDateTime(event_receive_datetime) AS event_receive_datetime,
    COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id) AS mobileAdsId,
    '3101143' AS accountName,
    appmetrica_device_id AS appmetricaDeviceId,
    city AS cityName,
    os_name AS osName,
    profile_id AS crmUserId,
    __table_name,
    __emitted_at,
    session_id,
    sum(screen_view) AS screen_view
FROM events_are_screen_view
GROUP BY 
    __date,
    event_receive_datetime,
    mobileAdsId,
    accountName,
    appmetricaDeviceId,
    cityName,
    osName,
    crmUserId,
    __table_name,
    __emitted_at,
    session_id
  )