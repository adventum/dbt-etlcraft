{% set column_list_created_at = ['id', 'name', 'created_at', 'updated_at'] %}
{% set column_list_mydatetime = ['id', 'name', 'created_at', 'mydatetime'] %}
{% set table_name = "normalize_testsourcetypename_testtemplatename_teststreamname" %}

SELECT
'Error: Incorrect datetime field identified without dict by name'
WHERE '{{ find_incremental_datetime_field(column_list_mydatetime, table_name) }}' != 'mydatetime'

{% set my_dict %}
sourcetypes:
  testsourcetypename:
    incremental_datetime_field: updated_at
{% endset %}

UNION ALL SELECT
'Error: Incorrect datetime field identified with dict for source type'
WHERE '{{ find_incremental_datetime_field(column_list_created_at, table_name, 
  defaults_dict=fromyaml(my_dict)) }}' != 'updated_at'

{% set my_dict2 %}
sourcetypes:
  testsourcetypename:
    incremental_datetime_field: updated_at
    streams:
      teststreamname:
        incremental_datetime_field: created_at
{% endset %}

UNION ALL SELECT
'Error: Incorrect datetime field identified with dict for stream'
WHERE '{{ find_incremental_datetime_field(column_list_created_at, table_name, 
    defaults_dict=fromyaml(my_dict2)) }}' != 'created_at'

{% set my_dict3 %}
sourcetypes:
  testsourcetypename:
    incremental_datetime_field: updated_at
    streams:
      teststreamname:
        incremental_datetime_field: False
{% endset %}

UNION ALL SELECT
'Error: Incorrect datetime field identified when there is no incremental field'
WHERE '{{ find_incremental_datetime_field(column_list_created_at, table_name, 
    defaults_dict=fromyaml(my_dict3)) == False }}' != 'True'