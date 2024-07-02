
        
  
    
    
        
        insert into test.incremental_adjust_events_default_network__dbt_new_data_ad331357_6a84_4c95_8464_974832726b93 ("__date", "clicks", "country", "country_code", "date", "events", "impressions", "installs", "network", "rejected_installs", "sessions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_network


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_adjust_events_default_network
  
      