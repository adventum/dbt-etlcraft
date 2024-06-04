
        
  
    
    
        
        insert into test.full_periodstat__dbt_new_data_dd0d5b65_f7d9_4a8d_b2dd_47c481a6cc3b ("period_date", "__date", "campaign", "periodStart", "periodEnd", "__emitted_at", "__table_name", "__link", "ManualAdCostStatHash", "__id", "__datetime", "cost_per_day")
  -- depends_on: test.link_registry_appprofilematching
-- depends_on: test.link_registry_utmhashregistry
-- depends_on: test.link_periodstat


WITH unnest_dates AS ( 
SELECT *, 
    dateAdd(periodStart, arrayJoin(range( 0, 1 + toUInt16(date_diff('day', periodStart, periodEnd))))) AS period_date
	, COUNT(*) OVER(PARTITION BY 
__date
,
campaign
,
periodStart
,
periodEnd
,
__emitted_at
,
__table_name
,
__link
,
ManualAdCostStatHash
,
__id
,
__datetime

 
    ) AS divide_by_days 
FROM test.link_periodstat
)
, t0 AS (
SELECT period_date, 
__date, 
campaign, 
periodStart, 
periodEnd, 
__emitted_at, 
__table_name, 
__link, 
ManualAdCostStatHash, 
__id, 
__datetime, 
   
cost/divide_by_days AS cost_per_day 
   
 
FROM unnest_dates
)
, t1 AS ( 
SELECT * 
FROM t0
)
, t2 AS ( 
SELECT * 
FROM t1
) 
SELECT COLUMNS('^[^.]+$') FROM t2
  
      