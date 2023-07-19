{% macro etlcraft_defaults() %}
{% set etlcraft_defaults_dict %}
sourcetypes:
  alytics:
    fields_included:
    - test_field
{% endset %}
  {{ return(fromyaml(etlcraft_defaults_dict)) }}
{% endmacro %}