{%- macro json_extract_string(field_name, key) -%}
    {{ return(adapter.dispatch('json_extract_string', 'etlcraft')(field_name, key)) }}
{%- endmacro %}

{% macro clickhouse__json_extract_string(field_name, key) -%}
    JSONExtractString({{ field_name }}, '{{ key }}')
{%- endmacro %}