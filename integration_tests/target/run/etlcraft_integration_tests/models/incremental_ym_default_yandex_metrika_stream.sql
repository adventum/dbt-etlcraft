
        
  
    
    
        
        insert into test.incremental_ym_default_yandex_metrika_stream__dbt_tmp ("__datetime", "__clientName", "__productName", "ymsclientID", "ymsgoalsID", "ymsgoalsOrder", "ymslastAdvEngine", "ymslastReferalSource", "ymslastSearchEngine", "ymslastTrafficSource", "ymspageViews", "ymsparsedParamsKey1", "ymsparsedParamsKey2", "ymspurchaseCoupon", "ymspurchaseID", "ymspurchaseRevenue", "ymsregionCity", "ymsUTMCampaign", "ymsUTMContent", "ymsUTMMedium", "ymsUTMSource", "ymsUTMTerm", "ymsvisitID", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDateTime(__datetime, 'UTC') AS __datetime)
FROM test.normalize_ym_default_yandex_metrika_stream

  
    