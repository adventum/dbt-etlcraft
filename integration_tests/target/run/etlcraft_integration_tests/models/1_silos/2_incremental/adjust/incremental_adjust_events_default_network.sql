
        
  
    
    
        
        insert into test.incremental_adjust_events_default_network__dbt_new_data_a5ae1888_9257_4a70_8a77_2c262e2d98f6 ("__date", "clicks", "country", "country_code", "date", "events", "impressions", "installs", "network", "rejected_installs", "sessions", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_adjust_events_default_network

  
      