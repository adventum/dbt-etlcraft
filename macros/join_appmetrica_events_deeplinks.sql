{%- macro join_appmetrica_events_deeplinks(
    sourcetype_name,
    pipeline_name,
    stream_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}


{%- set sourcetype_name = 'appmetrica' -%}
{%- set pipeline_name = 'events' -%}
{%- set stream_name = 'deeplinks' -%}
{%- set table_pattern = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ stream_name ~ '$' -%}
{%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern) -%}   
{%- set source_table = '(' ~ dbt_utils.union_relations(relations) ~ ')' -%}    

SELECT
    toDateTime(__date) AS __date, 
    toLowCardinality(__table_name) AS __table_name,
    toDateTime(event_datetime) AS event_datetime,
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
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
    __emitted_at,
    toLowCardinality('AppDeeplinkStat') AS __link
FROM {{ source_table }}

{% endmacro %}