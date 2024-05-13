WITH events_are_screen_view AS (SELECT *, 1 AS screen_view FROM (
{{ etlcraft.normalize(override_target_model_name='normalize_appmetrica_events_default_events', fields=['__clientName','__productName','app_version_name','appmetrica_device_id','city','event_receive_datetime','event_json','event_name','google_aid','installation_id','ios_ifa','os_name','profile_id','session_id']) }}
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