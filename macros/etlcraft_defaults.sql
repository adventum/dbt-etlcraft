{% macro etlcraft_defaults() %}
{% set etlcraft_defaults_dict %}
sourcetypes:
  example:
    included_fields:
    - test_field
  appsflyer:
    streams:
      in_app_events:
        incremental_datetime_field: event_time
{% endset %}
  {{ return(fromyaml(etlcraft_defaults_dict)) }}
{% endmacro %}