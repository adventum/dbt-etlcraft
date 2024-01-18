{% macro get_min_max_date(stage,sourcetype_name,template_name,override_target_model_name=none) %}

{% set override_target_model_name = override_target_model_name %}

{% set table_list_query %}
    SELECT 
        table 
    {% if override_target_model_name is none %}
    FROM system.columns 
    {% else %}
     FROM ({{override_target_model_name}})
    {% endif %}
    WHERE 
        database ='{{this.schema}}' AND 
        table LIKE '{{stage}}_{{sourcetype_name}}_{{template_name}}%' AND 
        name='__datetime'
{% endset %}

{% set results = run_query(table_list_query) %}

{% if execute %}
    {% set results_list = results.columns[0] %}
{% endif %}

{% set min_max_date_query %}
SELECT max(toDate(min_date)) as date_from,
       max(toDate(max_date)) as date_to
FROM (
{% for table in results_list %}
    SELECT 
        '{{table}}' as table_name,
        max(toDate(__datetime)) as max_date, 
        min(toDate(__datetime)) as min_date,
        {{should_full_refresh()}} as should_full_refresh
    {% if override_target_model_name is none %}
    FROM {{this.schema}}.{{table}}
    {% else %}
     FROM ({{override_target_model_name}})
    {% endif %}
    
    WHERE toDate(__datetime) > '1972-01-01'
    {% if not loop.last %}
        UNION ALL
    {% endif %}
{% endfor %}
)
WHERE min_date > '1972-01-01'
{% endset %}

{% set min_max_date = dbt_utils.get_query_results_as_dict(min_max_date_query) %}

{{ return(min_max_date) }}

{% endmacro %}