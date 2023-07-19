{% macro array(arr) -%}
  {{ adapter.dispatch('array')(arr) }}
{%- endmacro %}

{% macro default__array(arr) -%}
  ARRAY[{{ arr|join(", ") }}]
{%- endmacro %}

{% macro clickhouse__array(arr) -%}
  array({{ arr|join(", ") }})
{%- endmacro %}