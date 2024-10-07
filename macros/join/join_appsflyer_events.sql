{%- macro join_appsflyer_events(
    sourcetype_name,
    pipeline_name,
    relations_dict,
    date_from,
    date_to,
    params,
    limit0=none
    ) -%}

{{ config(
    materialized='table',
    order_by=('__table_name'),
    on_schema_change='fail'
) }}
{%- if execute -%}
{%- set sourcetype_name = 'appsflyer' -%}
{%- set pipeline_name = 'events' -%}
{%- set stream_name = 'in_app_events' -%}
{%- set table_pattern = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ stream_name ~ '$' -%}
{%- set relations = datacraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern) -%}  
{%- if not relations -%} 
    {{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern ~ '". 
    Please ensure that your source data follows the expected structure.') }}
{%- endif -%} 
{%- set source_table = '(' ~ dbt_utils.union_relations(relations) ~ ')' -%} 
{%- if not source_table -%} 
    {{ exceptions.raise_compiler_error('No source_table were found by pattern "' ~ table_pattern ~ '"') }}
{%- endif -%}

SELECT
    toLowCardinality(attributed_touch_type) AS touch_type,
    toDateTime32(attributed_touch_time) AS touch_time,
    toDateTime32(install_time) AS install_time,
    toDateTime32(event_time) AS event_time,
    toLowCardinality(event_name) AS event_name,
    toLowCardinality(event_source) AS event_source,
    toLowCardinality(af_prt) AS partner,
    toLowCardinality(media_source) AS media_source,
    toLowCardinality(campaign) AS campaign,
    af_siteid AS site_id,
    af_ad AS ad,                                            
    toLowCardinality(country_code) AS country_code,
    toLowCardinality(city) AS city,   {# здесь может быть и без toLowCardinality, если значений больше 10 тыс. #}
    appsflyer_id,
    customer_user_id AS custom_uid,
    toLowCardinality(platform) AS platform,
    toLowCardinality(is_retargeting) AS is_retargeting,                  {# bool ? #}
    toLowCardinality(is_primary_attribution) AS is_primary_attribution,  {# bool ? #}
    __emitted_at,
    toLowCardinality(__table_name) AS __table_name,
    toLowCardinality('&&&') AS __link                                    {# ? ? ? #}
FROM {{ source_table }}
{% if limit0 %}
LIMIT 0
{%- endif -%}

{%- endif -%}
{% endmacro %}