
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_installations__dbt_new_data_6b731b6a_9717_429e_b532_9ae47a2855c8 ("__date", "__clientName", "__productName", "appmetrica_device_id", "city", "click_datetime", "click_url_parameters", "google_aid", "install_receive_datetime", "ios_ifa", "is_reinstallation", "os_name", "profile_id", "publisher_name", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_appmetrica_events_default_installations


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_appmetrica_events_default_installations
  
      