

  create view test.normalize_ym_events_default_yandex_metrika_stream 
  
  as (
    SELECT
        JSONExtractString(_airbyte_data, 'ym:s:dateTime') AS __datetime, 
JSONExtractString(_airbyte_data, '__clientName') AS __clientName, 
JSONExtractString(_airbyte_data, '__productName') AS __productName, 
JSONExtractString(_airbyte_data, 'ym:s:clientID') AS ymsclientID, 
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
        toLowCardinality(_dbt_source_relation) AS __table_name,toDateTimeOrDefault(_airbyte_emitted_at) AS __emitted_at, 
        NOW() as __normalized_at
    FROM (
    

        (
            select
                cast('test._airbyte_raw_ym_events_default_26746851_yandex_metrika_stream' as String) as _dbt_source_relation,

                
                    cast("_airbyte_ab_id" as String) as "_airbyte_ab_id" ,
                    cast("_airbyte_data" as String) as "_airbyte_data" ,
                    cast("_airbyte_emitted_at" as String) as "_airbyte_emitted_at" 

            from test._airbyte_raw_ym_events_default_26746851_yandex_metrika_stream

            
        )

        )
  )