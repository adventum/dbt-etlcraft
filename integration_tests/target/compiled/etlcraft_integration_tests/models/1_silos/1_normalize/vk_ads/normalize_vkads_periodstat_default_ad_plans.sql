SELECT
        JSONExtractString(_airbyte_data, 'ad_groups') AS ad_groups, 
        JSONExtractString(_airbyte_data, 'autobidding_mode') AS autobidding_mode, 
        JSONExtractString(_airbyte_data, 'budget_limit') AS budget_limit, 
        JSONExtractString(_airbyte_data, 'budget_limit_day') AS budget_limit_day, 
        JSONExtractString(_airbyte_data, 'created') AS created, 
        JSONExtractString(_airbyte_data, 'date_end') AS date_end, 
        JSONExtractString(_airbyte_data, 'date_start') AS date_start, 
        JSONExtractString(_airbyte_data, 'id') AS id, 
        JSONExtractString(_airbyte_data, 'max_price') AS max_price, 
        JSONExtractString(_airbyte_data, 'name') AS name, 
        JSONExtractString(_airbyte_data, 'objective') AS objective, 
        JSONExtractString(_airbyte_data, 'priced_goal') AS priced_goal, 
        JSONExtractString(_airbyte_data, 'pricelist_id') AS pricelist_id, 
        JSONExtractString(_airbyte_data, 'status') AS status, 
        JSONExtractString(_airbyte_data, 'updated') AS updated, 
        JSONExtractString(_airbyte_data, 'vkads_status') AS vkads_status,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        toDateTime32(substring(_airbyte_extracted_at, 1, 19)) AS __emitted_at, 
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('datacraft_clientname_raw__stream_vkads_default_ad_plans') AS _dbt_source_relation,
        toString("_airbyte_raw_id") AS _airbyte_raw_id,
        toString("_airbyte_data") AS _airbyte_data,
        toString("_airbyte_extracted_at") AS _airbyte_extracted_at
FROM airbyte_internal.datacraft_clientname_raw__stream_vkads_default_ad_plans
)

)