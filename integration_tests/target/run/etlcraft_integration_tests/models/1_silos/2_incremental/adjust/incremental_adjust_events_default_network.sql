
        
  
    
    
        
        insert into test.incremental_adjust_events_default_network__dbt_new_data_f50e9b17_4bb0_4344_8a76_0ec649a9f6b0 ("__date", "clicks", "country", "country_code", "date", "events", "impressions", "installs", "network", "rejected_installs", "sessions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_network


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_adjust_events_default_network
  
      