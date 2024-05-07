SELECT
        JSONExtractString(_airbyte_data, 'created_at') AS created_at, 
        JSONExtractString(_airbyte_data, 'created_by_id') AS created_by_id, 
        JSONExtractString(_airbyte_data, 'data') AS data, 
        JSONExtractString(_airbyte_data, 'form_id') AS form_id, 
        JSONExtractString(_airbyte_data, 'id') AS id, 
        JSONExtractString(_airbyte_data, 'updated_at') AS updated_at, 
        JSONExtractString(_airbyte_data, 'updated_by_id') AS updated_by_id, 
        JSONExtractString(_airbyte_data, 'utm_hashcode') AS utm_hashcode,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        toDateTime32(substring(_airbyte_emitted_at, 1, 19)) AS __emitted_at, 
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('_airbyte_raw_utmcraft_registry_default_testaccount_utmresult') AS _dbt_source_relation,
        toString("_airbyte_ab_id") AS _airbyte_ab_id ,
        toString("_airbyte_data") AS _airbyte_data ,
        toString("_airbyte_emitted_at") AS _airbyte_emitted_at 
FROM test._airbyte_raw_utmcraft_registry_default_testaccount_utmresult
)

)