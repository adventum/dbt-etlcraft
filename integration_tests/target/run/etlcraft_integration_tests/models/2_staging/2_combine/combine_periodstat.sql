
        
  
    
    
        
        insert into test.combine_periodstat__dbt_new_data_e511c210_fafe_4da5_81d4_73537699fec3 ("__date", "campaign", "cost", "periodStart", "periodEnd", "__emitted_at", "__table_name", "__link")
  -- depends_on: test.join_sheets_periodstat
SELECT * REPLACE(toLowCardinality(__table_name) AS __table_name)
FROM (

(
SELECT
        toDate("__date") as __date ,
        toString("campaign") as campaign ,
        toFloat64("cost") as cost ,
        toDate("periodStart") as periodStart ,
        toDate("periodEnd") as periodEnd ,
        toDateTime("__emitted_at") as __emitted_at ,
        toString("__table_name") as __table_name ,
        toString("__link") as __link 
FROM test.join_sheets_periodstat
)

) 


  
      