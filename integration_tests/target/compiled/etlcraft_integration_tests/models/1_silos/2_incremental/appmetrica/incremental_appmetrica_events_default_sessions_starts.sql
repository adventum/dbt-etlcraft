-- depends_on: test.normalize_appmetrica_events_default_sessions_starts


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_appmetrica_events_default_sessions_starts