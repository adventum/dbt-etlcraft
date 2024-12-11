{% macro check_table_exists(source_table = 'master',database = 'marts') -%}
  {{ adapter.dispatch('check_table_exists', 'datacraft')(source_table,database) }}
{%- endmacro %}

{% macro clickhouse__check_table_exists(source_table,database) -%}
    {% set sql_statement %}
        SELECT 1 FROM system.tables WHERE database = '{{database}}' AND name = '{{source_table}}'
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
