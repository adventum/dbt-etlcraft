
        
  
    
    
        
        insert into test.incremental_adjust_events_default_network__dbt_new_data_f6e8ee16_f9a8_4fbb_be99_0c523e494e40 ("__date", "clicks", "country", "country_code", "date", "events", "impressions", "installs", "network", "rejected_installs", "sessions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_network

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_adjust_events_default_network

  
      