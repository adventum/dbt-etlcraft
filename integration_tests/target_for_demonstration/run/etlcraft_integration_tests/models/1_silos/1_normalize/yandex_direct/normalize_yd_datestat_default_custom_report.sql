

  create view test.normalize_yd_datestat_default_custom_report__dbt_tmp 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'Date') AS __date, 
        JSONExtractString(_airbyte_data, '__clientName') AS __clientName, 
        JSONExtractString(_airbyte_data, '__productName') AS __productName, 
        JSONExtractString(_airbyte_data, 'AdId') AS AdId, 
        JSONExtractString(_airbyte_data, 'CampaignId') AS CampaignId, 
        JSONExtractString(_airbyte_data, 'CampaignName') AS CampaignName, 
        JSONExtractString(_airbyte_data, 'CampaignType') AS CampaignType, 
        JSONExtractString(_airbyte_data, 'Clicks') AS Clicks, 
        JSONExtractString(_airbyte_data, 'Cost') AS Cost, 
        JSONExtractString(_airbyte_data, 'Date') AS Date, 
        JSONExtractString(_airbyte_data, 'Impressions') AS Impressions,
        toLowCardinality(_dbt_source_relation) AS __table_name,
        toDateTime32(substring(toString(_airbyte_extracted_at), 1, 19)) AS __emitted_at,
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('datacraft_clientname_raw__stream_yd_default_accountid_custom_report') AS _dbt_source_relation,
        toString("_airbyte_raw_id") AS _airbyte_raw_id,
        toString("_airbyte_data") AS _airbyte_data,
        toString("_airbyte_extracted_at") AS _airbyte_extracted_at
FROM airbyte_internal.datacraft_clientname_raw__stream_yd_default_accountid_custom_report
)

)
  )