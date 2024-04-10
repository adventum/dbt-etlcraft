
        
  
    
    
        
        insert into test.incremental_adjust_events_default_network__dbt_new_data_1cd4b8c7_8e41_46eb_99e7_70d0e345ce42 ("__date", "clicks", "country", "country_code", "date", "events", "impressions", "installs", "network", "rejected_installs", "sessions", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_adjust_events_default_network

  
      