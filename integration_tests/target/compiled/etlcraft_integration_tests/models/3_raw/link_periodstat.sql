-- depends_on: test.hash_periodstat
SELECT __date,campaign,SUM(cost) AS cost,periodStart,periodEnd,__emitted_at,__table_name,__link,ManualAdCostStatHash,__id,__datetime 
FROM test.hash_periodstat
GROUP BY __date, campaign, periodStart, periodEnd, __emitted_at, __table_name, __link, ManualAdCostStatHash, __id, __datetime

