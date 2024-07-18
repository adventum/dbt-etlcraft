
  
    
    
        
        insert into test.hash_periodstat__dbt_tmp ("campaign", "cost", "periodStart", "periodEnd", "__emitted_at", "__table_name", "__link", "ManualAdCostStatHash", "__id", "__datetime")
  -- depends_on: test.combine_periodstat
SELECT *,
  assumeNotNull(CASE  
    WHEN __link = 'ManualAdCostStat' 
    THEN ManualAdCostStatHash 

    END) as __id
  , assumeNotNull(CASE
    WHEN __link = 'ManualAdCostStat' 
    
    THEN toDateTime(
    0) 
    END) AS __datetime
FROM (

SELECT *, 
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(periodStart))), ''), '') || ifnull(nullif(upper(trim(toString(periodEnd))), ''), '') || ifnull(nullif(upper(trim(toString(periodStart))), ''), '') = '', null, hex(MD5('ManualAdCostStat' || ';' || ifnull(nullif(upper(trim(toString(periodStart))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(periodEnd))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(periodStart))), ''), '')))))) as ManualAdCostStatHash


FROM test.combine_periodstat 
WHERE 

    True
)
-- SETTINGS short_circuit_function_evaluation=force_enable


  