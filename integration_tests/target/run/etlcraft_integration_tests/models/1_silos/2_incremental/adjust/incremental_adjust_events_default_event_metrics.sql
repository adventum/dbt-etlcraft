
        
  
    
    
        
        insert into test.incremental_adjust_events_default_event_metrics__dbt_new_data_dd0d5b65_f7d9_4a8d_b2dd_47c481a6cc3b ("__date", "country", "date", "event_name", "event_token", "events", "network", "tracker_token", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_event_metrics

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM (

        (
            select
                            toString("__date") as __date ,
                            toString("country") as country ,
                            toString("date") as date ,
                            toString("event_name") as event_name ,
                            toString("event_token") as event_token ,
                            toString("events") as events ,
                            toString("network") as network ,
                            toString("tracker_token") as tracker_token ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_adjust_events_default_event_metrics
        )

        )

  
      