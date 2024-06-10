
        
  
    
    
        
        insert into test.incremental_ym_events_default_yandex_metrika_stream__dbt_new_data_169e4b03_dba9_4a78_9da5_782d0a7c8ec1 ("__date", "__clientName", "__productName", "ymsclientID", "ymsdateTime", "ymsgoalsID", "ymsgoalsOrder", "ymslastAdvEngine", "ymslastReferalSource", "ymslastSearchEngine", "ymslastTrafficSource", "ymspageViews", "ymsparsedParamsKey1", "ymsparsedParamsKey2", "ymspurchaseCoupon", "ymspurchaseID", "ymspurchaseRevenue", "ymsregionCity", "ymsUTMCampaign", "ymsUTMContent", "ymsUTMMedium", "ymsUTMSource", "ymsUTMTerm", "ymsvisitID", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_ym_events_default_yandex_metrika_stream

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_ym_events_default_yandex_metrika_stream

  
      