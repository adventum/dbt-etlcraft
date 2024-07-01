
        
  
    
    
        
        insert into test.incremental_adjust_events_default_network__dbt_new_data_0aa9aeaf_5cd9_435f_8908_a9af65d9d477 ("__date", "clicks", "country", "country_code", "date", "events", "impressions", "installs", "network", "rejected_installs", "sessions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_network


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_adjust_events_default_network
  
      