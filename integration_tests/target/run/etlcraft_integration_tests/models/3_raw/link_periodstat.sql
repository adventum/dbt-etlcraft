
  
    
    
        
        insert into test.link_periodstat__dbt_backup ("campaign", "cost", "periodStart", "periodEnd", "__emitted_at", "__table_name", "__link", "ManualAdCostStatHash", "__id", "__datetime")
  -- depends_on: test.hash_periodstat
SELECT campaign,SUM(cost) AS cost,periodStart,periodEnd,__emitted_at,__table_name,__link,ManualAdCostStatHash,__id,__datetime 
FROM test.hash_periodstat
GROUP BY campaign, periodStart, periodEnd, __emitted_at, __table_name, __link, ManualAdCostStatHash, __id, __datetime


  