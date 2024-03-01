{%- macro join_appmetrica_events_default_deeplinks(
    sourcetype_name,
    pipeline_name,
    template_name,
    stream_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

SELECT
    toDateTime(__date) AS __date, 
    toDateTime(event_datetime) AS event_datetime,
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    toLowCardinality(__table_name) AS __table_name,
    appmetrica_device_id AS appmetricaDeviceId,
    assumeNotNull(COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id, '')) AS mobileAdsId,
    profile_id AS crmUserId,
    os_name AS osName,
    city AS cityName,
    assumeNotNull(coalesce({{ etlcraft.get_adsourcedirty() }}, publisher_name, '')) AS adSourceDirty,
    extract(deeplink_url_parameters, 'utm_source=([^&]*)') AS utmSource,
    extract(deeplink_url_parameters, 'utm_medium=([^&]*)') AS utmMedium,
    extract(deeplink_url_parameters, 'utm_campaign=([^&]*)') AS utmCampaign,
    extract(deeplink_url_parameters, 'utm_term=([^&]*)') AS utmTerm,
    extract(deeplink_url_parameters, 'utm_content=([^&]*)') AS utmContent,
    {{ etlcraft.get_utmhash('__', ['utmCampaign', 'utmContent']) }} AS utmHash,
    __emitted_at
FROM {{ ref('incremental_appmetrica_events_default_deeplinks') }}

{% endmacro %}