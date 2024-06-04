
        
  
    
    
        
        insert into test.incremental_adjust_events_default_network__dbt_new_data_dd0d5b65_f7d9_4a8d_b2dd_47c481a6cc3b ("__date", "clicks", "country", "country_code", "date", "events", "impressions", "installs", "network", "rejected_installs", "sessions", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_events_default_network

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM (

        (
            select
                            toString("__date") as __date ,
                            toString("clicks") as clicks ,
                            toString("country") as country ,
                            toString("country_code") as country_code ,
                            toString("date") as date ,
                            toString("events") as events ,
                            toString("impressions") as impressions ,
                            toString("installs") as installs ,
                            toString("network") as network ,
                            toString("rejected_installs") as rejected_installs ,
                            toString("sessions") as sessions ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_adjust_events_default_network
        )

        )

  
      