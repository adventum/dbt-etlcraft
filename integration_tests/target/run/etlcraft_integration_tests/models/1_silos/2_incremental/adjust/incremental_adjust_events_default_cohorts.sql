
        
  
    
    
        
        insert into test.incremental_adjust_events_default_cohorts__dbt_new_data_169e4b03_dba9_4a78_9da5_782d0a7c8ec1 ("__date", "country", "date", "event_name", "event_token", "events", "network", "period", "tracker_token", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_cohorts

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_adjust_events_default_cohorts

  
      