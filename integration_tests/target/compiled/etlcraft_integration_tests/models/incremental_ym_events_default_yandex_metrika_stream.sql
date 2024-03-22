
SELECT * 
REPLACE(toDate(__datetime, 'UTC') AS __date)
FROM test.normalize_ym_events_default_yandex_metrika_stream
