-- depends_on: test.normalize_adjust_events_default_cohorts

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
                            toString("period") as period ,
                            toString("tracker_token") as tracker_token ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_adjust_events_default_cohorts
        )

        )
