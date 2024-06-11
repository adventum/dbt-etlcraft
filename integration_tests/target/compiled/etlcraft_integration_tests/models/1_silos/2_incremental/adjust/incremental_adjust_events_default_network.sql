-- depends_on: test.normalize_adjust_events_default_network


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM normalize_adjust_events_default_network

