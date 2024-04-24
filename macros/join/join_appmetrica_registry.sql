{%- macro join_appmetrica_registry(
    sourcetype_name,
    pipeline_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

{{ config(
    materialized='table',
    order_by=('__table_name'),
    on_schema_change='fail'
) }}

{%- set sourcetype_name = 'appmetrica' -%}
{%- set pipeline_name = 'registry' -%}
{%- set stream_name = 'profiles' -%}
{%- set table_pattern = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ stream_name ~ '$' -%}
{%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern) -%}   
{%- set source_table = '(' ~ dbt_utils.union_relations(relations) ~ ')' -%} 


SELECT
    appmetrica_device_id AS appmetricaDeviceId,
    profile_id AS crmUserId,
    city AS cityName,
    __emitted_at,
    toLowCardinality(__table_name) AS __table_name,
    toLowCardinality('AppProfileMatching') AS __link 
FROM {{ source_table }}

{% endmacro %}