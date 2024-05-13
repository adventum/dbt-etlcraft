
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_screen_view__dbt_tmp ("__date", "event_receive_datetime", "mobileAdsId", "accountName", "appmetricaDeviceId", "cityName", "osName", "crmUserId", "__table_name", "__emitted_at", "session_id", "screen_view")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM (

        (
            select
                            toDate("__date") as __date ,
                            toDateTime("event_receive_datetime") as event_receive_datetime ,
                            toString("mobileAdsId") as mobileAdsId ,
                            toString("accountName") as accountName ,
                            toString("appmetricaDeviceId") as appmetricaDeviceId ,
                            toString("cityName") as cityName ,
                            toString("osName") as osName ,
                            toString("crmUserId") as crmUserId ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("session_id") as session_id ,
                            toUInt64("screen_view") as screen_view 

            from test.normalize_appmetrica_events_default_screen_view
        )

        )

  
    