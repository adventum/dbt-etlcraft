-- depends_on: test.normalize_appsflyer_events_default_in_app_events


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_appsflyer_events_default_in_app_events