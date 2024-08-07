SELECT
        JSONExtractString(_airbyte_data, 'date') AS __date, 
        JSONExtractString(_airbyte_data, 'ad_offers') AS ad_offers, 
        JSONExtractString(_airbyte_data, 'ad_plan_id') AS ad_plan_id, 
        JSONExtractString(_airbyte_data, 'base') AS base, 
        JSONExtractString(_airbyte_data, 'carousel') AS carousel, 
        JSONExtractString(_airbyte_data, 'date') AS date, 
        JSONExtractString(_airbyte_data, 'events') AS events, 
        JSONExtractString(_airbyte_data, 'moat') AS moat, 
        JSONExtractString(_airbyte_data, 'playable') AS playable, 
        JSONExtractString(_airbyte_data, 'romi') AS romi, 
        JSONExtractString(_airbyte_data, 'social_network') AS social_network, 
        JSONExtractString(_airbyte_data, 'tps') AS tps, 
        JSONExtractString(_airbyte_data, 'uniques') AS uniques, 
        JSONExtractString(_airbyte_data, 'uniques_video') AS uniques_video, 
        JSONExtractString(_airbyte_data, 'video') AS video,
        toLowCardinality(_dbt_source_relation) AS __table_name,
        toDateTime32(substring(toString(_airbyte_extracted_at), 1, 19)) AS __emitted_at,
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('datacraft_clientname_raw__stream_vkads_default_accountid_ad_plans_statistics') AS _dbt_source_relation,
        toString("_airbyte_raw_id") AS _airbyte_raw_id,
        toString("_airbyte_data") AS _airbyte_data,
        toString("_airbyte_extracted_at") AS _airbyte_extracted_at
FROM airbyte_internal.datacraft_clientname_raw__stream_vkads_default_accountid_ad_plans_statistics
)

)