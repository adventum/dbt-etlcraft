
        
  
    
    
        
        insert into test.incremental_adjust_events_default_cohorts__dbt_tmp ("__date", "country", "date", "event_name", "event_token", "events", "network", "period", "tracker_token", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_adjust_events_default_cohorts

  
    