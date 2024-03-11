{%- macro join_appmetrica_events_install(
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
{%- set stream_name = 'install' -%}
{%- set table_pattern = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ stream_name ~ '$' -%}
{%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern) -%}   
{%- set source_table = '(' ~ dbt_utils.union_relations(relations) ~ ')' -%} 

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
    {#-toLowCardinality({{ link_hash('AppInstallStat', metadata) }}) AS __link #}
FROM {{ source_table }}

{% endmacro %}