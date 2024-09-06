
{% macro check_table_empty(database,source_table) -%}
    {% set sql_statement %}
        SELECT 1 FROM {{database}}.{{source_table}}
    {% endset %}
    {% if execute %}
        {% set results = run_query(sql_statement) %}
        {% if results|length > 0 %}
            {{ return(1) }}
        {% else %}
            {{ return(0) }}
        {% endif %}
    {% else %}
        {{ return(0) }}
    {% endif %}
{%- endmacro %}