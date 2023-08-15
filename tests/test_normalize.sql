{% set source_query %}
(SELECT '{"x": 1, "y": "2"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation
UNION ALL SELECT '{"x": 1, "y": "2"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation)
{% endset %}
{% set my_dict %}
sourcetypes:
  alytics:
    included_fields:
    - test_field1
    - test_field2
    - test_field3
    - test_field4
    excluded_fields:
    - x
    streams:
      project_goals:
        included_fields:
        - test field 5
        - test field 6
{% endset %}
{% set normalized_query = normalize(source_table=source_query, 
override_target_model_name='normalize_alytics_testtemplate_project_goals') %}

SELECT 'Invalid row count' 
WHERE (SELECT COUNT(*) FROM ({{ normalized_query }})) != 2

UNION ALL SELECT 'Invalid column count'
WHERE {{ get_column_count_in_subquery(normalized_query) }} != 2 + 3

UNION ALL SELECT 'Invalid column count - excluded fields'
WHERE {{ get_column_count_in_subquery(normalize(source_table=source_query,
    override_target_model_name='normalize_alytics_testtemplate_project_goals', 
    excluded_fields=['x', 'z'])) }} != 2 + 3 - 1

UNION ALL SELECT 'Invalid column count - included fields'
WHERE {{ get_column_count_in_subquery(normalize(source_table=source_query,
    override_target_model_name='normalize_alytics_testtemplate_project_goals', 
    included_fields=['x', 'z'])) }} != 2 + 3 + 1

UNION ALL SELECT 'Invalid column count - defaults dict'
WHERE {{ get_column_count_in_subquery(normalize(source_table=source_query,
    override_target_model_name='normalize_alytics_testtemplate_project_goals', 
    defaults_dict=fromyaml(my_dict))) }} != 2 + 3 + 6 - 1   
