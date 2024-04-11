
        
  
    
    
        
        insert into test.incremental_ym_events_default_yandex_metrika_stream__dbt_new_data_a5ae1888_9257_4a70_8a77_2c262e2d98f6 ("__date", "__clientName", "__productName", "ymsclientID", "ymsdateTime", "ymsgoalsID", "ymsgoalsOrder", "ymslastAdvEngine", "ymslastReferalSource", "ymslastSearchEngine", "ymslastTrafficSource", "ymspageViews", "ymsparsedParamsKey1", "ymsparsedParamsKey2", "ymspurchaseCoupon", "ymspurchaseID", "ymspurchaseRevenue", "ymsregionCity", "ymsUTMCampaign", "ymsUTMContent", "ymsUTMMedium", "ymsUTMSource", "ymsUTMTerm", "ymsvisitID", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_ym_events_default_yandex_metrika_stream

  
      