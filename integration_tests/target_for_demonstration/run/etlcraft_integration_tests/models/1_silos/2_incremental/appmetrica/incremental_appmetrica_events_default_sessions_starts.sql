
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_sessions_starts__dbt_new_data_951bb9ee_eb7b_44e4_99d3_b44e3e697cd0 ("__date", "__clientName", "__productName", "appmetrica_device_id", "city", "google_aid", "installation_id", "ios_ifa", "os_name", "profile_id", "session_start_receive_datetime", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_appmetrica_events_default_sessions_starts


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_appmetrica_events_default_sessions_starts
  
      