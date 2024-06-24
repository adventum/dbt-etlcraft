
        
  
    
    
        
        insert into test.incremental_adjust_events_default_event_metrics__dbt_new_data_6b731b6a_9717_429e_b532_9ae47a2855c8 ("__date", "country", "date", "event_name", "event_token", "events", "network", "tracker_token", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_event_metrics


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_adjust_events_default_event_metrics
  
      