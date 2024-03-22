SELECT
    toDateTime(date_add(minute, 1, toDateTime(__date))) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(session_start_datetime) AS event_datetime, 
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    --session_id AS appSessionId, --таких данных сейчас нет
    CONCAT(installation_id, appmetrica_device_id) AS installationDeviceId,
    appmetrica_device_id AS appmetricaDeviceId,
    COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id) AS mobileAdsId,
    profile_id AS crmUserId,
    os_name AS osName,
    city AS cityName,
    1 AS sessions,
    __emitted_at
    
FROM test.incremental_appmetrica_events_default_sessions_starts




