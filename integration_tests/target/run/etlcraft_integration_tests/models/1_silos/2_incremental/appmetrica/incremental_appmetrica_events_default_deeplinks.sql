
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_deeplinks__dbt_new_data_a5ae1888_9257_4a70_8a77_2c262e2d98f6 ("__date", "__clientName", "__productName", "appmetrica_device_id", "city", "deeplink_url_parameters", "event_datetime", "google_aid", "ios_ifa", "os_name", "profile_id", "publisher_name", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_appmetrica_events_default_deeplinks

  
      