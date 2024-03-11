{%- macro join_appmetrica_events_sessions_starts(
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
{%- set stream_name = 'sessions_starts' -%}
{%- set table_pattern = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ stream_name ~ '$' -%}
{%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern) -%}   
{%- set source_table = '(' ~ dbt_utils.union_relations(relations) ~ ')' -%} 

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
    {#-toLowCardinality({{ link_hash('AppSessionStat', metadata) }}) AS __link #}
FROM {{ source_table }}

{% endmacro %}