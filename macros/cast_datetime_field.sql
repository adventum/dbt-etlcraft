{% macro cast_datetime_field(f) -%}
  {{ adapter.dispatch('cast_datetime_field', 'etlcraft')(f) }}
{%- endmacro %}

{% macro clickhouse__cast_datetime_field(f) -%}
  toDateTime({{ f }}, 'UTC')
{%- endmacro %}