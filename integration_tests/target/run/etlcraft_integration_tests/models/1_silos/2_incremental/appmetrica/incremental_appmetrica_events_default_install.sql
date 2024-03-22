
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_install__dbt_new_data_7e51c1da_7cf3_4f23_9fa8_84a704e56243 ("__date", "__clientName", "__productName", "appmetrica_device_id", "city", "click_datetime", "click_url_parameters", "google_aid", "install_datetime", "ios_ifa", "is_reinstallation", "os_name", "profile_id", "publisher_name", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_appmetrica_events_default_install

  
      