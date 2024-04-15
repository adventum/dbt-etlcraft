{% macro etlcraft_defaults() %}
{% set etlcraft_defaults_dict %}
sourcetypes:
  example:
    included_fields:
    - test_field
  appsflyer:
    incremental_datetime_field: event_time
    streams:
      installs:
        incremental_datetime_field: install_time
      post_attribution_installs:
        incremental_datetime_field: install_time 
{% endset %}
  {{ return(fromyaml(etlcraft_defaults_dict)) }}
{% endmacro %}