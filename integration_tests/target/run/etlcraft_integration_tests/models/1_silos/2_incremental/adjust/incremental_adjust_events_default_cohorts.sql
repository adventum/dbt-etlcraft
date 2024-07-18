
        
  
    
    
        
        insert into test.incremental_adjust_events_default_cohorts__dbt_new_data_2bf53b95_0650_46c0_bde3_29ac391b31f4 ("__date", "country", "date", "event_name", "event_token", "events", "network", "period", "tracker_token", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_cohorts


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_adjust_events_default_cohorts
  
      