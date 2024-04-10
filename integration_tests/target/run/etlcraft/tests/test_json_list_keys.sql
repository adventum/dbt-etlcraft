select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      SELECT 'The key set doesn''t match'
    FROM (SELECT '{"access": 0, "custom_interaction": 0, "goal_id": 0}' AS _airbyte_data) 
    WHERE JSONExtractKeys(_airbyte_data) != array('access', 'custom_interaction', 'goal_id')
      
    ) dbt_internal_test