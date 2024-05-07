

  create view test.normalize_mt_datestat_default_banners_statistics__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'date') AS __date, 
        JSONExtractString(_airbyte_data, '__clientName') AS __clientName, 
        JSONExtractString(_airbyte_data, '__productName') AS __productName, 
        JSONExtractString(_airbyte_data, 'banner_id') AS banner_id, 
        JSONExtractString(_airbyte_data, 'base') AS base, 
        JSONExtractString(_airbyte_data, 'date') AS date,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        toDateTime32(substring(_airbyte_emitted_at, 1, 19)) AS __emitted_at, 
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('_airbyte_raw_mt_datestat_default_testaccount_banners_statistics') AS _dbt_source_relation,
        toString("_airbyte_ab_id") AS _airbyte_ab_id ,
        toString("_airbyte_data") AS _airbyte_data ,
        toString("_airbyte_emitted_at") AS _airbyte_emitted_at 
FROM test._airbyte_raw_mt_datestat_default_testaccount_banners_statistics
)

)
  )