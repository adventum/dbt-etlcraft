{% set source_query %}
(SELECT '{"x": 1, "y": "2"}' AS _airbyte_data, NOW() AS _airbyte_emited_at, 'source' AS _dbt_source_relation
UNION ALL SELECT '{"x": 1, "y": "2"}' AS _airbyte_data, NOW() AS _airbyte_emited_at, 'source' AS _dbt_source_relation)
{% endset %}
{% set normalized_query = normalize(source_table=source_query, 
override_target_model_name='normalize_alytics_11222_testtemplate_project_goals__auto') %}

SELECT 'Invalid row count' 
WHERE (SELECT COUNT(*) FROM ({{ normalized_query }})) != 2

UNION ALL SELECT 'Invalid column count'
WHERE {{ get_column_count_in_subquery(normalized_query) }} != 2 + 3

UNION ALL SELECT 'Invalid column count - excluded fields'
WHERE {{ get_column_count_in_subquery(normalize(source_table=source_query,
    override_target_model_name='normalize_alytics_11222_testtemplate_project_goals__auto', 
    excluded_fields=['x', 'z'])) }} != 2 + 3 - 1

UNION ALL SELECT 'Invalid column count - included fields'
WHERE {{ get_column_count_in_subquery(normalize(source_table=source_query,
    override_target_model_name='normalize_alytics_11222_testtemplate_project_goals__auto', 
    included_fields=['x', 'z'])) }} != 2 + 3 +1
