{% set normalized_query = normalize(override_target_model_name='normalize_alytics_11222_testtemplate_project_goals__auto') %}

SELECT 'Invalid row count' 
WHERE (SELECT COUNT(*) FROM ({{ normalized_query }})) != 2

UNION ALL SELECT 'Invalid column count'
WHERE {{ get_column_count_in_subquery(normalized_query) }} != 18

UNION ALL SELECT 'Invalid column count - excluded fields'
WHERE {{ get_column_count_in_subquery(normalize(
    override_target_model_name='normalize_alytics_11222_testtemplate_project_goals__auto', 
    excluded_fields=['__clientName', 'XXX'])) }} != 17

UNION ALL SELECT 'Invalid column count - included fields'
WHERE {{ get_column_count_in_subquery(normalize(
    override_target_model_name='normalize_alytics_11222_testtemplate_project_goals__auto', 
    included_fields=['__clientName', 'XXX'])) }} != 19
