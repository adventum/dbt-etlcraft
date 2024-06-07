
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_events__dbt_new_data_f6e8ee16_f9a8_4fbb_be99_0c523e494e40 ("__date", "__clientName", "__productName", "app_version_name", "appmetrica_device_id", "city", "event_json", "event_name", "event_receive_datetime", "google_aid", "installation_id", "ios_ifa", "os_name", "profile_id", "session_id", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_appmetrica_events_default_events

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_appmetrica_events_default_events

  
      