{%- macro join_appmetrica_events_default_install(
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
    toDateTime(__date) AS __date, -- было installDateTime
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    toLowCardinality(__table_name) AS __table_name,
    appmetrica_device_id AS appmetricaDeviceId,
    assumeNotNull(COALESCE(nullIf(google_aid, ''), nullIf(ios_ifa, ''), appmetrica_device_id, '')) AS mobileAdsId,
    profile_id AS crmUserId,
    os_name AS osName,
    city AS cityName,
    -- click_url_parameters,
    if(match(click_url_parameters, 'organic'), 'Органическая установка', assumeNotNull(coalesce({{ etlcraft.get_adsourcedirty() }}, publisher_name, ''))) AS adSourceDirty,
    -- if(match(click_url_parameters, 'organic'), 'Органическая установка', assumeNotNull(coalesce({{ etlcraft.get_adsourcedirty() }}, publisher_name, '')))  as adSourceDirty2,
    extract(click_url_parameters, 'utm_source=([^&]*)') AS utmSource,
    extract(click_url_parameters, 'utm_medium=([^&]*)') AS utmMedium,
    extract(click_url_parameters, 'utm_campaign=([^&]*)') AS utmCampaign,
    extract(click_url_parameters, 'utm_term=([^&]*)') AS utmTerm,
    extract(click_url_parameters, 'utm_content=([^&]*)') AS utmContent,
    {{ etlcraft.get_utmhash('__', ['utmContent', 'utmCampaign']) }} AS utmHash,
    is_reinstallation = 'false' AS installApp,
    1 AS installs,
    __emitted_at

FROM {{ ref('incremental_appmetrica_events_default_install') }}

{% endmacro %}