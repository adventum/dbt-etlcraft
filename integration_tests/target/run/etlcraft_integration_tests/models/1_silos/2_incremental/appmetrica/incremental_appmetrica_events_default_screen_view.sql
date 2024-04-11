
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_screen_view__dbt_new_data_a5ae1888_9257_4a70_8a77_2c262e2d98f6 ("__date", "event_datetime", "mobileAdsId", "accountName", "appmetricaDeviceId", "cityName", "osName", "crmUserId", "__table_name", "__emitted_at", "session_id", "screen_view")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_appmetrica_events_default_screen_view

  
      