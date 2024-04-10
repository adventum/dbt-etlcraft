
        
  
    
    
        
        insert into test.incremental_adjust_events_default_event_metrics__dbt_new_data_1cd4b8c7_8e41_46eb_99e7_70d0e345ce42 ("__date", "country", "date", "event_name", "event_token", "events", "network", "tracker_token", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_adjust_events_default_event_metrics

  
      