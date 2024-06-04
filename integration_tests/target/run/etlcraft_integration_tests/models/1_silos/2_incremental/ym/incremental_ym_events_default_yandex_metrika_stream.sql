
        
  
    
    
        
        insert into test.incremental_ym_events_default_yandex_metrika_stream__dbt_new_data_dd0d5b65_f7d9_4a8d_b2dd_47c481a6cc3b ("__date", "__clientName", "__productName", "ymsclientID", "ymsdateTime", "ymsgoalsID", "ymsgoalsOrder", "ymslastAdvEngine", "ymslastReferalSource", "ymslastSearchEngine", "ymslastTrafficSource", "ymspageViews", "ymsparsedParamsKey1", "ymsparsedParamsKey2", "ymspurchaseCoupon", "ymspurchaseID", "ymspurchaseRevenue", "ymsregionCity", "ymsUTMCampaign", "ymsUTMContent", "ymsUTMMedium", "ymsUTMSource", "ymsUTMTerm", "ymsvisitID", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_ym_events_default_yandex_metrika_stream

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM (

        (
            select
                            toString("__date") as __date ,
                            toString("__clientName") as __clientName ,
                            toString("__productName") as __productName ,
                            toString("ymsclientID") as ymsclientID ,
                            toString("ymsdateTime") as ymsdateTime ,
                            toString("ymsgoalsID") as ymsgoalsID ,
                            toString("ymsgoalsOrder") as ymsgoalsOrder ,
                            toString("ymslastAdvEngine") as ymslastAdvEngine ,
                            toString("ymslastReferalSource") as ymslastReferalSource ,
                            toString("ymslastSearchEngine") as ymslastSearchEngine ,
                            toString("ymslastTrafficSource") as ymslastTrafficSource ,
                            toString("ymspageViews") as ymspageViews ,
                            toString("ymsparsedParamsKey1") as ymsparsedParamsKey1 ,
                            toString("ymsparsedParamsKey2") as ymsparsedParamsKey2 ,
                            toString("ymspurchaseCoupon") as ymspurchaseCoupon ,
                            toString("ymspurchaseID") as ymspurchaseID ,
                            toString("ymspurchaseRevenue") as ymspurchaseRevenue ,
                            toString("ymsregionCity") as ymsregionCity ,
                            toString("ymsUTMCampaign") as ymsUTMCampaign ,
                            toString("ymsUTMContent") as ymsUTMContent ,
                            toString("ymsUTMMedium") as ymsUTMMedium ,
                            toString("ymsUTMSource") as ymsUTMSource ,
                            toString("ymsUTMTerm") as ymsUTMTerm ,
                            toString("ymsvisitID") as ymsvisitID ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_ym_events_default_yandex_metrika_stream
        )

        )

  
      