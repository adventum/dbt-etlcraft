
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_events__dbt_new_data_1cd4b8c7_8e41_46eb_99e7_70d0e345ce42 ("__date", "__clientName", "__productName", "app_version_name", "appmetrica_device_id", "city", "event_datetime", "event_json", "event_name", "google_aid", "installation_id", "ios_ifa", "os_name", "profile_id", "session_id", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_appmetrica_events_default_events

  
      