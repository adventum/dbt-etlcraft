
        
  
    
    
        
        insert into test.incremental_adjust_events_default_cohorts__dbt_new_data_d00f206f_3a10_4cf3_beb1_b14662f886e4 ("__date", "country", "date", "event_name", "event_token", "events", "network", "period", "tracker_token", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_cohorts


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_adjust_events_default_cohorts
  
      