select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      



SELECT 'Invalid row count' 
WHERE (SELECT COUNT(*) FROM (SELECT
        JSONExtractString(_airbyte_data, 'mydatetime') AS __datetime, 
JSONExtractString(_airbyte_data, 'x') AS x, 
JSONExtractString(_airbyte_data, 'y') AS y,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        parseDateTimeBestEffort(toString(_airbyte_emitted_at)) AS __emitted_at, 
        --toDateTime32(_airbyte_emitted_at) AS __emitted_at,
        NOW() as __normalized_at
    FROM 
(SELECT '{"x": 1, "y": "2", "mydatetime": "3"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation
UNION ALL SELECT '{"x": 1, "y": "2", "mydate": "4"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation)
)) != 2

UNION ALL SELECT 'Invalid column count'
WHERE 
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
     from (SELECT
        JSONExtractString(_airbyte_data, 'mydatetime') AS __datetime, 
JSONExtractString(_airbyte_data, 'x') AS x, 
JSONExtractString(_airbyte_data, 'y') AS y,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        parseDateTimeBestEffort(toString(_airbyte_emitted_at)) AS __emitted_at, 
        --toDateTime32(_airbyte_emitted_at) AS __emitted_at,
        NOW() as __normalized_at
    FROM 
(SELECT '{"x": 1, "y": "2", "mydatetime": "3"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation
UNION ALL SELECT '{"x": 1, "y": "2", "mydate": "4"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation)
) limit 1)
 != 3 + 3

UNION ALL SELECT 'Invalid column count - excluded fields'
WHERE 
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
     from (SELECT
        JSONExtractString(_airbyte_data, 'mydatetime') AS __datetime, 
JSONExtractString(_airbyte_data, 'y') AS y,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        parseDateTimeBestEffort(toString(_airbyte_emitted_at)) AS __emitted_at, 
        --toDateTime32(_airbyte_emitted_at) AS __emitted_at,
        NOW() as __normalized_at
    FROM 
(SELECT '{"x": 1, "y": "2", "mydatetime": "3"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation
UNION ALL SELECT '{"x": 1, "y": "2", "mydate": "4"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation)
) limit 1)
 != 3 + 3 - 1

UNION ALL SELECT 'Invalid column count - included fields'
WHERE 
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
     from (SELECT
        JSONExtractString(_airbyte_data, 'mydatetime') AS __datetime, 
JSONExtractString(_airbyte_data, 'x') AS x, 
JSONExtractString(_airbyte_data, 'y') AS y, 
JSONExtractString(_airbyte_data, 'z') AS z,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        parseDateTimeBestEffort(toString(_airbyte_emitted_at)) AS __emitted_at, 
        --toDateTime32(_airbyte_emitted_at) AS __emitted_at,
        NOW() as __normalized_at
    FROM 
(SELECT '{"x": 1, "y": "2", "mydatetime": "3"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation
UNION ALL SELECT '{"x": 1, "y": "2", "mydate": "4"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation)
) limit 1)
 != 3 + 3 + 1

UNION ALL SELECT 'Invalid column count - defaults dict'
WHERE 
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
     from (SELECT
        JSONExtractString(_airbyte_data, 'mydatetime') AS __datetime, 
JSONExtractString(_airbyte_data, 'test field 5') AS test_field_5, 
JSONExtractString(_airbyte_data, 'test field 6') AS test_field_6, 
JSONExtractString(_airbyte_data, 'test_field1') AS test_field1, 
JSONExtractString(_airbyte_data, 'test_field2') AS test_field2, 
JSONExtractString(_airbyte_data, 'test_field3') AS test_field3, 
JSONExtractString(_airbyte_data, 'test_field4') AS test_field4, 
JSONExtractString(_airbyte_data, 'y') AS y,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        parseDateTimeBestEffort(toString(_airbyte_emitted_at)) AS __emitted_at, 
        --toDateTime32(_airbyte_emitted_at) AS __emitted_at,
        NOW() as __normalized_at
    FROM 
(SELECT '{"x": 1, "y": "2", "mydatetime": "3"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation
UNION ALL SELECT '{"x": 1, "y": "2", "mydate": "4"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation)
) limit 1)
 != 3 + 3 + 6 - 1   

UNION ALL SELECT DISTINCT 'mydate field was not renamed to __datetime '
FROM (SELECT
        '__datetime' AS __datetime, 
'x' AS x, 
'y' AS y,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        parseDateTimeBestEffort(toString(_airbyte_emitted_at)) AS __emitted_at, 
        --toDateTime32(_airbyte_emitted_at) AS __emitted_at,
        NOW() as __normalized_at
    FROM 
(SELECT '{"x": 1, "y": "2", "mydatetime": "3"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation
UNION ALL SELECT '{"x": 1, "y": "2", "mydate": "4"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation)
)
WHERE toString(tuple(*)) LIKE '%mydatetime%' OR NOT toString(tuple(*)) LIKE '%\_\_datetime%'

UNION ALL SELECT DISTINCT 'x field was not renamed to __datetime'
FROM (SELECT
        '__datetime' AS __datetime, 
'mydatetime' AS mydatetime, 
'y' AS y,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        parseDateTimeBestEffort(toString(_airbyte_emitted_at)) AS __emitted_at, 
        --toDateTime32(_airbyte_emitted_at) AS __emitted_at,
        NOW() as __normalized_at
    FROM 
(SELECT '{"x": 1, "y": "2", "mydatetime": "3"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation
UNION ALL SELECT '{"x": 1, "y": "2", "mydate": "4"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation)
)
WHERE toString(tuple(*)) NOT LIKE '%mydatetime%' 
OR toString(tuple(*)) LIKE '%x%' OR NOT toString(tuple(*)) LIKE '%\_\_datetime%'

UNION ALL SELECT DISTINCT 'Error when no datetime field'
FROM (SELECT
        'mydatetime' AS mydatetime, 
'x' AS x, 
'y' AS y,
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        parseDateTimeBestEffort(toString(_airbyte_emitted_at)) AS __emitted_at, 
        --toDateTime32(_airbyte_emitted_at) AS __emitted_at,
        NOW() as __normalized_at
    FROM 
(SELECT '{"x": 1, "y": "2", "mydatetime": "3"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation
UNION ALL SELECT '{"x": 1, "y": "2", "mydate": "4"}' AS _airbyte_data, NOW() AS _airbyte_emitted_at, 'source' AS _dbt_source_relation)
)
WHERE toString(tuple(*)) NOT LIKE '%mydatetime%' 
OR toString(tuple(*)) NOT LIKE '%x%' OR toString(tuple(*)) LIKE '%\_\_datetime%'
      
    ) dbt_internal_test