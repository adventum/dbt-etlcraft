WITH events_are_screen_view AS (SELECT *, 1 AS screen_view FROM (
{{ etlcraft.normalize(override_target_model_name='normalize_appmetrica_events_default_events') }}
)
WHERE event_name = 'screen_view')


SELECT
    toDate(__date) AS __date,
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
    mobileAdsId,
    accountName,
    appmetricaDeviceId,
    cityName,
    osName,
    crmUserId,
    __table_name,
    __emitted_at,
    session_id