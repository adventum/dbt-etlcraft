
        
  
    
    
        
        insert into test.incremental_adjust_events_default_cohorts__dbt_new_data_a5ae1888_9257_4a70_8a77_2c262e2d98f6 ("__date", "country", "date", "event_name", "event_token", "events", "network", "period", "tracker_token", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_adjust_events_default_cohorts

  
      