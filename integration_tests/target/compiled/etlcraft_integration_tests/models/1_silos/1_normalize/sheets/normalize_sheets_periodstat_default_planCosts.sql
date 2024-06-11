SELECT
        JSONExtractString(_airbyte_data, 'Campaign') AS Campaign, 
        JSONExtractString(_airbyte_data, 'Cost') AS Cost, 
        JSONExtractString(_airbyte_data, 'Period_end') AS Period_end, 
        JSONExtractString(_airbyte_data, 'Period_start') AS Period_start,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        toDateTime32(substring(toString(_airbyte_extracted_at), 1, 19)) AS __emitted_at, 
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('datacraft_clientname_raw__stream_sheets_default_accountid_planCosts') AS _dbt_source_relation,
        toString("_airbyte_raw_id") AS _airbyte_raw_id,
        toString("_airbyte_data") AS _airbyte_data,
        toString("_airbyte_extracted_at") AS _airbyte_extracted_at
FROM test.datacraft_clientname_raw__stream_sheets_default_accountid_planCosts
)

)