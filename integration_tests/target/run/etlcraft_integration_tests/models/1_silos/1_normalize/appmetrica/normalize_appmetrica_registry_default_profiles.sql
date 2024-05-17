

  create view test.normalize_appmetrica_registry_default_profiles__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, '__clientName') AS __clientName, 
        JSONExtractString(_airbyte_data, '__productName') AS __productName, 
        JSONExtractString(_airbyte_data, 'appmetrica_device_id') AS appmetrica_device_id, 
        JSONExtractString(_airbyte_data, 'city') AS city, 
        JSONExtractString(_airbyte_data, 'profile_id') AS profile_id,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        toDateTime32(substring(_airbyte_extracted_at, 1, 19)) AS __emitted_at, 
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('_airbyte_raw_appmetrica_registry_default_testaccount_profiles') AS _dbt_source_relation,
        toString("_airbyte_raw_id") AS _airbyte_raw_id ,
        toString("_airbyte_data") AS _airbyte_data ,
        toString("_airbyte_extracted_at") AS _airbyte_extracted_at 
FROM test._airbyte_raw_appmetrica_registry_default_testaccount_profiles
)

)
  )