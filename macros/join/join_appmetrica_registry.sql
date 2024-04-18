{%- macro join_appmetrica_registry(
    sourcetype_name,
    pipeline_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

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
    '' AS utmHash,
    __emitted_at,
    toLowCardinality('AppProfileMatching') AS __link 
FROM {{ source_table }}

{% endmacro %}