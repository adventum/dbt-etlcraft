SELECT
    toDateTime(__date) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(install_datetime) AS event_datetime, 
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    appmetrica_device_id AS appmetricaDeviceId,
    assumeNotNull(COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id, '')) AS mobileAdsId,
    profile_id AS crmUserId,
    os_name AS osName,
    city AS cityName,
    -- click_url_parameters,
    if(match(click_url_parameters, 'organic'), 'Органическая установка', assumeNotNull(coalesce(lower(if(length(utmSource) > 0, concat(utmSource, ' / ', utmMedium), null)), publisher_name, ''))) AS adSourceDirty,
    -- if(match(click_url_parameters, 'organic'), 'Органическая установка', assumeNotNull(coalesce(lower(if(length(utmSource) > 0, concat(utmSource, ' / ', utmMedium), null)), publisher_name, '')))  as adSourceDirty2,
    extract(click_url_parameters, 'utm_source=([^&]*)') AS utmSource,
    extract(click_url_parameters, 'utm_medium=([^&]*)') AS utmMedium,
    extract(click_url_parameters, 'utm_campaign=([^&]*)') AS utmCampaign,
    extract(click_url_parameters, 'utm_term=([^&]*)') AS utmTerm,
    extract(click_url_parameters, 'utm_content=([^&]*)') AS utmContent,
    greatest(coalesce(extract(utmContent, '__([a-zA-Z0-9]{8})'), ''), coalesce(extract(utmCampaign, '__([a-zA-Z0-9]{8})'), '')) AS utmHash,
    is_reinstallation = 'false' AS installApp,
    1 AS installs,
    __emitted_at

FROM test.incremental_appmetrica_events_default_install




