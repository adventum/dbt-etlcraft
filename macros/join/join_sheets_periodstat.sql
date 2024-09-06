{%- macro join_sheets_periodstat(
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
{%- set sourcetype_name = 'sheets' -%}
{%- set pipeline_name = 'periodstat' -%}
{%- set stream_name = 'planCosts' -%}
{%- set table_pattern = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ stream_name ~ '$' -%}
{%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern) -%}   
{%- if not relations -%} 
    {{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern ~ '". 
    Please ensure that your source data follows the expected structure.') }}
{%- endif -%}
{%- set source_table = '(' ~ dbt_utils.union_relations(relations) ~ ')' -%} 
{%- if not source_table -%} 
    {{ exceptions.raise_compiler_error('No source_table were found by pattern "' ~ table_pattern ~ '"') }}
{%- endif -%}
{%- set link_value = params -%}

SELECT
    Campaign AS campaign,
    toFloat64(Cost) AS cost,
    toDate(Period_start) AS periodStart,
    toDate(Period_end) AS periodEnd,
    __emitted_at,
    toLowCardinality(__table_name) AS __table_name, 
    toLowCardinality('ManualAdCostStat') AS __link 
    {#- toLowCardinality({{ link_value }}) AS __link #}

FROM {{ source_table }}
{% if limit0 %}
LIMIT 0
{%- endif -%}

{%-endif -%}
{% endmacro %}