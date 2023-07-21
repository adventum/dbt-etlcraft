 SELECT 'The key set doesn''t match'
    FROM {{ ref('_airbyte_raw_alytics_11222_testtemplate_project_goals') }} 
    WHERE {{ json_list_keys("_airbyte_data") }} != {{ array(["'access'", "'custom_interaction'", 
         "'goal_id'", "'in_service_id'", "'in_service_id_for_stat'", "'interaction_type'", 
         "'interaction_type_id'", "'is_active'", "'is_economic'", "'resource_uri'", 
         "'service_title'", "'terms'", "'title'", "'__clientName'", "'__productName'"]) }}