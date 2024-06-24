
        
  
    
    
        
        insert into test.incremental_ym_events_default_yandex_metrika_stream__dbt_new_data_6b731b6a_9717_429e_b532_9ae47a2855c8 ("__date", "__clientName", "__productName", "ymsclientID", "ymsdateTime", "ymsgoalsID", "ymsgoalsOrder", "ymslastAdvEngine", "ymslastReferalSource", "ymslastSearchEngine", "ymslastTrafficSource", "ymspageViews", "ymsparsedParamsKey1", "ymsparsedParamsKey2", "ymspurchaseCoupon", "ymspurchaseID", "ymspurchaseRevenue", "ymsregionCity", "ymsUTMCampaign", "ymsUTMContent", "ymsUTMMedium", "ymsUTMSource", "ymsUTMTerm", "ymsvisitID", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_ym_events_default_yandex_metrika_stream


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_ym_events_default_yandex_metrika_stream
  
      