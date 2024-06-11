
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_screen_view__dbt_tmp ("__date", "event_receive_datetime", "mobileAdsId", "accountName", "appmetricaDeviceId", "cityName", "osName", "crmUserId", "__table_name", "__emitted_at", "session_id", "screen_view")
  -- depends_on: test.normalize_appmetrica_events_default_screen_view


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM normalize_appmetrica_events_default_screen_view


  
    