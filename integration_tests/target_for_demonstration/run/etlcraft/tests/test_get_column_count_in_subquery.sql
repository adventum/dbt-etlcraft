select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      


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
      
    ) dbt_internal_test