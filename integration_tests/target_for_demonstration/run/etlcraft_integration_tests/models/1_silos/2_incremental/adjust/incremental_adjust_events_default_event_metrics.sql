
        
  
    
    
        
        insert into test.incremental_adjust_events_default_event_metrics__dbt_new_data_951bb9ee_eb7b_44e4_99d3_b44e3e697cd0 ("__date", "country", "date", "event_name", "event_token", "events", "network", "tracker_token", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_event_metrics


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_adjust_events_default_event_metrics
  
      