{% macro datacraft_defaults() %}
{% set datacraft_defaults_dict %}
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
  appmetrica:
    streams:
      installations: 
        incremental_datetime_field: install_receive_datetime
      deeplinks: 
        incremental_datetime_field: event_receive_datetime
      events: 
        incremental_datetime_field: event_receive_datetime
      crashes: 
        incremental_datetime_field: crash_receive_datetime
      errors: 
        incremental_datetime_field: error_receive_datetime
      push_tokens: 
        incremental_datetime_field: token_receive_datetime
      session_starts: 
        incremental_datetime_field: session_start_receive_datetime
  calltouch:
    incremental_datetime_formula: replaceRegexpOne(replaceRegexpOne(date, '\\s+(\\d):', ' 0\\1:'), '(\\d{2})\\/(\\d{2})\\/(\\d{4})', '\\3-\\2-\\1') 
{% endset %}
  {{ return(fromyaml(datacraft_defaults_dict)) }}
{% endmacro %}