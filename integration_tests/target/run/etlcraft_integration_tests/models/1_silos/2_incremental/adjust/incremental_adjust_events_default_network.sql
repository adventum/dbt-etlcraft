
        
  
    
    
        
        insert into test.incremental_adjust_events_default_network__dbt_new_data_bb55514f_537c_4384_a7d2_a467a955ab1f ("__date", "clicks", "country", "country_code", "date", "events", "impressions", "installs", "network", "rejected_installs", "sessions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_network


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_adjust_events_default_network
  
      