SELECT
        JSONExtractString(_airbyte_data, 'app_token') AS app_token, 
        JSONExtractString(_airbyte_data, 'description') AS description, 
        JSONExtractString(_airbyte_data, 'formatting') AS formatting, 
        JSONExtractString(_airbyte_data, 'id') AS id, 
        JSONExtractString(_airbyte_data, 'is_skad_event') AS is_skad_event, 
        JSONExtractString(_airbyte_data, 'name') AS name, 
        JSONExtractString(_airbyte_data, 'section') AS section, 
        JSONExtractString(_airbyte_data, 'short_name') AS short_name, 
        JSONExtractString(_airbyte_data, 'tokens') AS tokens,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        toDateTime32(substring(_airbyte_emitted_at, 1, 19)) AS __emitted_at, 
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('_airbyte_raw_adjust_registry_default_testaccount_events') AS _dbt_source_relation,
        toString("_airbyte_ab_id") AS _airbyte_ab_id ,
        toString("_airbyte_data") AS _airbyte_data ,
        toString("_airbyte_emitted_at") AS _airbyte_emitted_at 
FROM test._airbyte_raw_adjust_registry_default_testaccount_events
)

)