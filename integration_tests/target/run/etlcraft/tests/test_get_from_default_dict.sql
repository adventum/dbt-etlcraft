select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      









SELECT 'Test1 failed - expected red' WHERE 'red' != 'red'
UNION ALL SELECT 'Test2 failed - expected Labrador' WHERE 'Labrador' != 'Labrador'
UNION ALL SELECT 'Test3 failed - expected Washington' WHERE 'Washington' != 'Washington'
UNION ALL SELECT 'Test4 failed - expected dog' WHERE 'dog' != 'dog'
UNION ALL SELECT 'Test5 failed - expected {}' WHERE '{}' != '{}'
UNION ALL SELECT 'Test6 failed - expected Unknown' WHERE 'Unknown' != 'Unknown'
UNION ALL SELECT 'Test7 failed - expected N/A' WHERE 'N/A' != 'N/A'
      
    ) dbt_internal_test