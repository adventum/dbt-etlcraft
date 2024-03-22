
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_adjust_events_default_network
