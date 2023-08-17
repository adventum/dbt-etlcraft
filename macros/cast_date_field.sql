{% macro cast_date_field(f) -%}
  {{ adapter.dispatch('cast_date_field', 'etlcraft')(f) }}
{%- endmacro %}

{% macro clickhouse__cast_date_field(f) -%}
  toDate({{ f }}, 'UTC')
{%- endmacro %}