
        
  
    
    
        
        insert into test.incremental_adjust_events_default_event_metrics__dbt_new_data_7e51c1da_7cf3_4f23_9fa8_84a704e56243 ("__date", "country", "date", "event_name", "event_token", "events", "network", "tracker_token", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_adjust_events_default_event_metrics

  
      