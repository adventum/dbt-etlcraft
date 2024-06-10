


SELECT 1 AS x
where 
    (select JSONLength(
        replaceRegexpAll(
            replaceRegexpOne(
                replaceRegexpOne(
                    replaceRegexpAll(
                        toString(tuple(*)), 
                        '"', ''), 
                    '^\(', '['), 
                '\)$', ']'),
            '''', 
        '"'))
     from (SELECT 1, 'string', '', 'string with " and with ''') limit 1)
=3