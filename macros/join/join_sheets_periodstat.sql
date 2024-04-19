{%- macro join_sheets_periodstat(
    sourcetype_name,
    pipeline_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

{{ config(
    materialized='incremental',
    order_by=('__date', '__table_name'),
    incremental_strategy='delete+insert',
    unique_key=['__date', '__table_name'],
    on_schema_change='fail'
) }}

{%- set sourcetype_name = 'sheets' -%}
{%- set pipeline_name = 'periodstat' -%}
{%- set stream_name = 'planCosts' -%}
{%- set table_pattern = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ stream_name ~ '$' -%}
{%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern) -%}   
{%- set source_table = '(' ~ dbt_utils.union_relations(relations) ~ ')' -%} 


SELECT
    __date,
    Campaign AS campaign,
    Cost AS cost,
    toDate(Period_start) AS periodStart,
    toDate(Period_end) AS periodEnd,
    __emitted_at,
    toLowCardinality(__table_name) AS __table_name,
    toLowCardinality('AppProfileMatching') AS __link 
FROM {{ source_table }}

{% endmacro %}