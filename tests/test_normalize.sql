{% set source_query %}
(SELECT '{"x": 1, "y": "2", "mydatetime": "3"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation
UNION ALL SELECT '{"x": 1, "y": "2", "mydate": "4"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation)
{% endset %}
{% set my_dict %}
sourcetypes:
  testsource:
    fields:
    - test_field1
    - test_field2
    - test_field3
    - test_field4
    streams:
      project_goals:
        fields:
        - test field 5
        - test field 6
{% endset %}
{% set normalized_query = normalize(source_table=source_query, 
override_target_model_name='normalize_testsource_testtemplate_project_goals') %}

SELECT 'Invalid row count' 
WHERE (SELECT COUNT(*) FROM ({{ normalized_query }})) != 2

UNION ALL SELECT 'Invalid column count'
WHERE {{ get_column_count_in_subquery(normalized_query) }} != 3 + 3

UNION ALL SELECT 'Invalid column count - defaults dict'
WHERE {{ get_column_count_in_subquery(normalize(source_table=source_query,
    override_target_model_name='normalize_testsource_testtemplate_project_goals', 
    defaults_dict=fromyaml(my_dict))) }} != 3 + 3 + 6 - 1   

UNION ALL SELECT DISTINCT 'mydate field was not renamed to __datetime '
FROM ({{ normalize(source_table=source_query,
    override_target_model_name='normalize_testsource_testtemplate_project_goals', debug_column_names=True) }})
WHERE toString(tuple(*)) LIKE '%mydatetime%' OR NOT toString(tuple(*)) LIKE '%\_\_datetime%'

UNION ALL SELECT DISTINCT 'x field was not renamed to __datetime'
FROM ({{ normalize(source_table=source_query, incremental_datetime_field='x',
    override_target_model_name='normalize_testsource_testtemplate_project_goals', debug_column_names=True) }})
WHERE toString(tuple(*)) NOT LIKE '%mydatetime%' 
OR toString(tuple(*)) LIKE '%x%' OR NOT toString(tuple(*)) LIKE '%\_\_datetime%'

UNION ALL SELECT DISTINCT 'Error when no datetime field'
FROM ({{ normalize(source_table=source_query, incremental_datetime_field=False,
    override_target_model_name='normalize_testsource_testtemplate_project_goals', debug_column_names=True) }})
WHERE toString(tuple(*)) NOT LIKE '%mydatetime%' 
OR toString(tuple(*)) NOT LIKE '%x%' OR toString(tuple(*)) LIKE '%\_\_datetime%'
