-- depends_on: test.normalize_appmetrica_events_default_screen_view

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_appmetrica_events_default_screen_view
