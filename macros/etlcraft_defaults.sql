{% macro etlcraft_defaults() %}
{% set etlcraft_defaults_dict %}
sourcetypes:
  example:
    included_fields:
    - test_field
{% endset %}
  {{ return(fromyaml(etlcraft_defaults_dict)) }}
{% endmacro %}