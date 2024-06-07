SELECT
        JSONExtractString(_airbyte_data, 'date') AS __date, 
        JSONExtractString(_airbyte_data, 'clicks') AS clicks, 
        JSONExtractString(_airbyte_data, 'country') AS country, 
        JSONExtractString(_airbyte_data, 'country_code') AS country_code, 
        JSONExtractString(_airbyte_data, 'date') AS date, 
        JSONExtractString(_airbyte_data, 'events') AS events, 
        JSONExtractString(_airbyte_data, 'impressions') AS impressions, 
        JSONExtractString(_airbyte_data, 'installs') AS installs, 
        JSONExtractString(_airbyte_data, 'network') AS network, 
        JSONExtractString(_airbyte_data, 'rejected_installs') AS rejected_installs, 
        JSONExtractString(_airbyte_data, 'sessions') AS sessions,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        toDateTime32(substring(toString(_airbyte_extracted_at), 1, 19)) AS __emitted_at, 
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('datacraft_clientname_raw__stream_adjust_default_accountid_network') AS _dbt_source_relation,
        toString("_airbyte_raw_id") AS _airbyte_raw_id,
        toString("_airbyte_data") AS _airbyte_data,
        toString("_airbyte_extracted_at") AS _airbyte_extracted_at
FROM test.datacraft_clientname_raw__stream_adjust_default_accountid_network
)

)