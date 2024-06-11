-- depends_on: test.normalize_calltouch_events_default_calls


    
SELECT * REPLACE(toDate(replaceRegexpOne(replaceRegexpOne(date, '\\s+(\\d):', ' 0\\1:'), '(\\d{2})\\/(\\d{2})\\/(\\d{4})', '\\3-\\2-\\1'), 'UTC') AS __date) 

FROM normalize_calltouch_events_default_calls

