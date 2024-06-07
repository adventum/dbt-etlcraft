-- depends_on: test.normalize_ym_events_default_yandex_metrika_stream

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_ym_events_default_yandex_metrika_stream
