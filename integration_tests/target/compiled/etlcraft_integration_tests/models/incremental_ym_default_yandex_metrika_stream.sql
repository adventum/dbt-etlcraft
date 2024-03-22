
SELECT * 
REPLACE(toDateTime(__datetime, 'UTC') AS __datetime)
FROM test.normalize_ym_default_yandex_metrika_stream
