
        
  
    
    
        
        insert into test.incremental_appmetrica_events_default_deeplinks__dbt_new_data_8321cbef_6326_48d2_a58a_4e787ccb0180 ("__date", "__clientName", "__productName", "appmetrica_device_id", "city", "deeplink_url_parameters", "event_receive_datetime", "google_aid", "ios_ifa", "os_name", "profile_id", "publisher_name", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_appmetrica_events_default_deeplinks

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_appmetrica_events_default_deeplinks

  
      