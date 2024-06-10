
        
  
    
    
        
        insert into test.incremental_adjust_events_default_event_metrics__dbt_new_data_e73065dd_cb2b_48cf_898d_f49bff11cfc3 ("__date", "country", "date", "event_name", "event_token", "events", "network", "tracker_token", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_event_metrics

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_adjust_events_default_event_metrics

  
      