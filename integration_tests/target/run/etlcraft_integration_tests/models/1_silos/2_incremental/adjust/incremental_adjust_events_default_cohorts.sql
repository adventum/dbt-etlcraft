
        
  
    
    
        
        insert into test.incremental_adjust_events_default_cohorts__dbt_new_data_0aa9aeaf_5cd9_435f_8908_a9af65d9d477 ("__date", "country", "date", "event_name", "event_token", "events", "network", "period", "tracker_token", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_cohorts


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_adjust_events_default_cohorts
  
      