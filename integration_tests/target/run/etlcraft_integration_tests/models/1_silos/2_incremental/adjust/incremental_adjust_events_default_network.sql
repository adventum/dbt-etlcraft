
        
  
    
    
        
        insert into test.incremental_adjust_events_default_network__dbt_new_data_7e51c1da_7cf3_4f23_9fa8_84a704e56243 ("__date", "clicks", "country", "country_code", "date", "events", "impressions", "installs", "network", "rejected_installs", "sessions", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_adjust_events_default_network

  
      