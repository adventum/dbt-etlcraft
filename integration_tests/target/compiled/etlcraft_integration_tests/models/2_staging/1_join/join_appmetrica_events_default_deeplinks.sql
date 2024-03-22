SELECT
    toDateTime(__date) AS __date, -- было deeplinkDateTime
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    toLowCardinality(__table_name) AS __table_name,
    appmetrica_device_id AS appmetricaDeviceId,
    assumeNotNull(COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id, '')) AS mobileAdsId,
    profile_id AS crmUserId,
    os_name AS osName,
    city AS cityName,
    assumeNotNull(coalesce(lower(if(length(utmSource) > 0, concat(utmSource, ' / ', utmMedium), null)), publisher_name, '')) AS adSourceDirty,
    extract(deeplink_url_parameters, 'utm_source=([^&]*)') AS utmSource,
    extract(deeplink_url_parameters, 'utm_medium=([^&]*)') AS utmMedium,
    extract(deeplink_url_parameters, 'utm_campaign=([^&]*)') AS utmCampaign,
    extract(deeplink_url_parameters, 'utm_term=([^&]*)') AS utmTerm,
    extract(deeplink_url_parameters, 'utm_content=([^&]*)') AS utmContent,
    greatest(coalesce(extract(utmCampaign, '__([a-zA-Z0-9]{8})'), ''), coalesce(extract(utmContent, '__([a-zA-Z0-9]{8})'), '')) AS utmHash,
    __emitted_at
FROM test.incremental_appmetrica_events_default_deeplinks




