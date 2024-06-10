
        
  
    
    
        
        insert into test.incremental_adjust_events_default_network__dbt_new_data_169e4b03_dba9_4a78_9da5_782d0a7c8ec1 ("__date", "clicks", "country", "country_code", "date", "events", "impressions", "installs", "network", "rejected_installs", "sessions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_network

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_adjust_events_default_network

  
      