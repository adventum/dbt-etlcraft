 SELECT 'The key set doesn''t match'
    FROM (SELECT '{"access": 0, "custom_interaction": 0, "goal_id": 0}' AS _airbyte_data) 
    WHERE {{ json_list_keys("_airbyte_data") }} != {{ array(["'access'", "'custom_interaction'", 
         "'goal_id'"]) }}