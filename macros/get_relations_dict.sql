{% macro get_relations_dict(stage,sourcetype_name,template_name,override_target_model_name=none) %}

{% set get_relations_query %}
    SELECT 
        table, 
        groupArray(name) AS fields
    {% if override_target_model_name is none %}
    FROM system.columns
    {% else %}
    FROM ({{override_target_model_name}})
    {% endif %}
    WHERE database = '{{this.shema}}' AND table LIKE '{{stage}}_{{sourcetype_name}}_{{template_name}}%'
    GROUP BY table

{% endset %}


{% set relations_dict = dbt_utils.get_query_results_as_dict(get_relations_query) %}
  
{% set result = {} %}
{% for i in range(relations_dict.table|length) %}
    {% set table = relations_dict.table[i] %}
    {% set field = relations_dict.fields[i] %}
    {% set result = result.update({table: field}) %}
{% endfor %}

{{ return(result) }}

{% endmacro %}