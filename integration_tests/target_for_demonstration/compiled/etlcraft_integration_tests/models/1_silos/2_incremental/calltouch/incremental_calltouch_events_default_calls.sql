-- depends_on: test.normalize_calltouch_events_default_calls


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_calltouch_events_default_calls