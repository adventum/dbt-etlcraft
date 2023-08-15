{% set table_name = "normalize_testsourcetypename_testtemplatename_teststreamname" %}
{% set column_list1 = [api.Column.create('id', 'UInt32'), api.Column.create('name', 'String'),
    api.Column.create('created_at', 'DateTime'), 
    api.Column.create('_emitted_at', 'DateTime'), api.Column.create('_normalized_at', 'DateTime')] %}
{% set column_list2 = [api.Column.create('id', 'UInt32'), api.Column.create('name', 'String'), 
    api.Column.create('created_at', 'DateTime'), api.Column.create('updated_at', 'DateTime'),
    api.Column.create('_emitted_at', 'DateTime'), api.Column.create('_normalized_at', 'DateTime')] %}
{% set column_list3 = [api.Column.create('id', 'UInt32'), api.Column.create('name', 'String'), 
    api.Column.create('MyDatetime', 'String'),
    api.Column.create('_emitted_at', 'DateTime'), api.Column.create('_normalized_at', 'DateTime')] %}

SELECT
'Error: Incorrect datetime field identified without dict by type'
WHERE '{{ find_incremental_datetime_field(table_name~"1", override_column_list=column_list1) }}' != 'created_at'

UNION ALL SELECT
'Error: Incorrect datetime field identified without dict by name'
WHERE '{{ find_incremental_datetime_field(table_name~"2", override_column_list=column_list3) }}' != 'MyDatetime'


{% set my_dict %}
sourcetypes:
  testsourcetypename:
    incremental_datetime_field: updated_at
{% endset %}

UNION ALL SELECT
'Error: Incorrect datetime field identified with dict for source type'
WHERE '{{ find_incremental_datetime_field(table_name~"3", defaults_dict=fromyaml(my_dict), 
            override_column_list=column_list2) }}' != 'updated_at'

{% set my_dict2 %}
sourcetypes:
  testsourcetypename:
    incremental_datetime_field: updated_at
    streams:
      teststreamname4:
        incremental_datetime_field: created_at
{% endset %}

UNION ALL SELECT
'Error: Incorrect datetime field identified with dict for stream'
WHERE '{{ find_incremental_datetime_field(table_name~"4", defaults_dict=fromyaml(my_dict2),
            override_column_list=column_list2) }}' != 'created_at'

{% set my_dict3 %}
sourcetypes:
  testsourcetypename:
    incremental_datetime_field: updated_at
    streams:
      teststreamname5:
        incremental_datetime_field: False
{% endset %}

UNION ALL SELECT
'Error: Incorrect datetime field identified when there is no incremental field'
WHERE '{{ find_incremental_datetime_field(table_name~"5", defaults_dict=fromyaml(my_dict3), 
            override_column_list=column_list2) == False }}' != 'True'