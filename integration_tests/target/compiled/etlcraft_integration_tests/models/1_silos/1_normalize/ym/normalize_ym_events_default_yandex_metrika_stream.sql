SELECT
        JSONExtractString(_airbyte_data, 'ym:s:dateTime') AS __date, 
        JSONExtractString(_airbyte_data, '__clientName') AS __clientName, 
        JSONExtractString(_airbyte_data, '__productName') AS __productName, 
        JSONExtractString(_airbyte_data, 'ym:s:clientID') AS ymsclientID, 
        JSONExtractString(_airbyte_data, 'ym:s:dateTime') AS ymsdateTime, 
        JSONExtractString(_airbyte_data, 'ym:s:goalsID') AS ymsgoalsID, 
        JSONExtractString(_airbyte_data, 'ym:s:goalsOrder') AS ymsgoalsOrder, 
        JSONExtractString(_airbyte_data, 'ym:s:lastAdvEngine') AS ymslastAdvEngine, 
        JSONExtractString(_airbyte_data, 'ym:s:lastReferalSource') AS ymslastReferalSource, 
        JSONExtractString(_airbyte_data, 'ym:s:lastSearchEngine') AS ymslastSearchEngine, 
        JSONExtractString(_airbyte_data, 'ym:s:lastTrafficSource') AS ymslastTrafficSource, 
        JSONExtractString(_airbyte_data, 'ym:s:pageViews') AS ymspageViews, 
        JSONExtractString(_airbyte_data, 'ym:s:parsedParamsKey1') AS ymsparsedParamsKey1, 
        JSONExtractString(_airbyte_data, 'ym:s:parsedParamsKey2') AS ymsparsedParamsKey2, 
        JSONExtractString(_airbyte_data, 'ym:s:purchaseCoupon') AS ymspurchaseCoupon, 
        JSONExtractString(_airbyte_data, 'ym:s:purchaseID') AS ymspurchaseID, 
        JSONExtractString(_airbyte_data, 'ym:s:purchaseRevenue') AS ymspurchaseRevenue, 
        JSONExtractString(_airbyte_data, 'ym:s:regionCity') AS ymsregionCity, 
        JSONExtractString(_airbyte_data, 'ym:s:UTMCampaign') AS ymsUTMCampaign, 
        JSONExtractString(_airbyte_data, 'ym:s:UTMContent') AS ymsUTMContent, 
        JSONExtractString(_airbyte_data, 'ym:s:UTMMedium') AS ymsUTMMedium, 
        JSONExtractString(_airbyte_data, 'ym:s:UTMSource') AS ymsUTMSource, 
        JSONExtractString(_airbyte_data, 'ym:s:UTMTerm') AS ymsUTMTerm, 
        JSONExtractString(_airbyte_data, 'ym:s:visitID') AS ymsvisitID,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        toDateTime32(substring(_airbyte_extracted_at, 1, 19)) AS __emitted_at, 
        NOW() AS __normalized_at
FROM (

(
SELECT
        toLowCardinality('_airbyte_raw_ym_events_default_testaccount_yandex_metrika_stream') AS _dbt_source_relation,
        toString("_airbyte_raw_id") AS _airbyte_raw_id ,
        toString("_airbyte_data") AS _airbyte_data ,
        toString("_airbyte_extracted_at") AS _airbyte_extracted_at 
FROM test._airbyte_raw_ym_events_default_testaccount_yandex_metrika_stream
)

)