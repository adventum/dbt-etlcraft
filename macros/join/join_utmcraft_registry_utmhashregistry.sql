{%- macro join_utmcraft_registry_utmhashregistry(
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
{%- set sourcetype_name = 'utmcraft' -%}
{%- set pipeline_name = 'registry' -%}
{%- set stream_name = 'utmresult' -%}
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
    utm_hashcode AS utmHash,
    JSONExtractString(data, '4') AS utm_base_url,
    JSONExtractString(data, '5') AS utm_utmSource,
    if(JSONExtractString(data, '6') = 'указать вручную', JSONExtractString(data, '95'), JSONExtractString(data, '6')) AS utm_utmMedium,
    JSONExtractString(data, '9') AS utm_utmCampaign,
    JSONExtractString(data, '97') AS utm_project,
    if(JSONExtractString(data, '7') = 'custom-value-input-field',JSONExtractString(data, 'custom-7'),JSONExtractString(data, '7')) AS utm_utmContent,
    JSONExtractString(data, '66') AS utm_strategy,
    concat(if(JSONExtractString(data, '69') = 'custom-value-input-field',JSONExtractString(data, 'custom-69'),JSONExtractString(data, '69')),
            if(JSONExtractString(data, '69') != '' or JSONExtractString(data, 'custom-69') != '', ';', ''),
           if(JSONExtractString(data, '88') = 'custom-value-input-field',JSONExtractString(data, 'custom-88'),JSONExtractString(data, '88')),
           if(JSONExtractString(data, '88') != '' or JSONExtractString(data, 'custom-88') != '', ';', ''),
           if(JSONExtractString(data, '87') = 'custom-value-input-field',JSONExtractString(data, 'custom-87'),JSONExtractString(data, '87')),
           if(JSONExtractString(data, '87') != '' or JSONExtractString(data, 'custom-87') != '', ';', ''),
           if(JSONExtractString(data, '89') = 'custom-value-input-field',JSONExtractString(data, 'custom-89'),JSONExtractString(data, '89')),
           if(JSONExtractString(data, '89') != '' or JSONExtractString(data, 'custom-89') != '', ';', ''),
           if(JSONExtractString(data, '90') = 'custom-value-input-field',JSONExtractString(data, 'custom-90'),JSONExtractString(data, '90')),
           if(JSONExtractString(data, '90') != '' or JSONExtractString(data, 'custom-90') != '', ';', ''),
           if(JSONExtractString(data, '91') = 'custom-value-input-field',JSONExtractString(data, 'custom-91'),JSONExtractString(data, '91')),
           if(JSONExtractString(data, '91') != '' or JSONExtractString(data, 'custom-91') != '', ';', ''),
           if(JSONExtractString(data, '93') = 'custom-value-input-field',JSONExtractString(data, 'custom-93'),JSONExtractString(data, '93')),
           if(JSONExtractString(data, '93') != '' or JSONExtractString(data, 'custom-93') != '', ';', ''),
           if(JSONExtractString(data, '85') = 'custom-value-input-field',JSONExtractString(data, 'custom-85'),JSONExtractString(data, '85')),
           if(JSONExtractString(data, '85') != '' or JSONExtractString(data, 'custom-85') != '', ';', ''),
           if(JSONExtractString(data, '92') = 'custom-value-input-field',JSONExtractString(data, 'custom-92'),JSONExtractString(data, '92')),
           if(JSONExtractString(data, '92') != '' or JSONExtractString(data, 'custom-92') != '', ';', ''),
           if(JSONExtractString(data, '86') = 'custom-value-input-field',JSONExtractString(data, 'custom-86'),JSONExtractString(data, '86'))) AS utm_audience,
    __emitted_at,
    toLowCardinality(__table_name) AS __table_name,
    'UtmHashRegistry' AS __link         
FROM {{ source_table }}
{% if limit0 %}
LIMIT 0
{%- endif -%}

{%-endif -%}
{% endmacro %}