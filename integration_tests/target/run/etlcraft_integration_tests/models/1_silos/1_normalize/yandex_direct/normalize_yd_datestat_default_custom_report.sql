

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
        toLowCardinality(_dbt_source_relation) AS __table_name,toDateTime32(substring(_airbyte_emitted_at, 1, 19)) AS __emitted_at, 
        NOW() as __normalized_at
    FROM (
    

        (
            select
                cast('test._airbyte_raw_yd_datestat_default_testaccount_custom_report' as String) as _dbt_source_relation,

                
                    cast("_airbyte_ab_id" as String) as "_airbyte_ab_id" ,
                    cast("_airbyte_data" as String) as "_airbyte_data" ,
                    cast("_airbyte_emitted_at" as String) as "_airbyte_emitted_at" 

            from test._airbyte_raw_yd_datestat_default_testaccount_custom_report

            
        )

        )
  )