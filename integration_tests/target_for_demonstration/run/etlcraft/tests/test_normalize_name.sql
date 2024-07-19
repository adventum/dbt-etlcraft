select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      


SELECT

    'Test failed for input "Space Name". Expected output: "Space_Name", actual output: "Space_Name"' 
    WHERE 'Space_Name' != 'Space_Name'
UNION ALL SELECT 
    'Test failed for input "Прривет, Мир!". Expected output: "Prrivet_Mir", actual output: "Prrivet_Mir"' 
    WHERE 'Prrivet_Mir' != 'Prrivet_Mir'
UNION ALL SELECT 
    'Test failed for input "Start 12". Expected output: "Start_12", actual output: "Start_12"' 
    WHERE 'Start_12' != 'Start_12'

      
    ) dbt_internal_test