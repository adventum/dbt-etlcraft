{% macro default__json_list_keys(field_name) -%}    
    {{ field_name }}::json->>key
{%- endmacro %}

{% macro clickhouse__json_list_keys(field_name) -%}    
    JSONExtractKeys({{ field_name }})
{%- endmacro %}

{% macro json_list_keys(field_name) -%}
    {{ adapter.dispatch('json_list_keys', 'datacraft')(field_name) }}
{%- endmacro %}