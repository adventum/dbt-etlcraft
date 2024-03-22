
        
  
    
    
        
        insert into test.join_adcost_yd_default__dbt_new_data_08efea22_0745_4151_ab07_bd3f47ec00e9 ("__table_name", "__datetime", "adCostDate", "reportType", "adSourceDirty", "adCampaignName", "adCampaignId", "adCampaignType", "adCost", "impressions", "clicks", "utmHash")
  


WITH test AS (
SELECT * FROM test.incremental_yd_default_cmps 
WHERE toDate(__datetime) BETWEEN '2023-07-30' AND '2023-07-30'),

cmps AS (
SELECT  
    toLowCardinality(__table_name) as __table_name,
    __datetime,
    toDate(__datetime) as adCostDate, 
    toLowCardinality('*') AS reportType, 
    'Yandex Direct Ads' AS adSourceDirty,
    CampaignName as adCampaignName, 
    CampaignId as adCampaignId,
    CampaignType as adCampaignType,
    (toFloat64(Cost)/1000000)*1.2 as adCost, 
    toInt32(Impressions) as impressions,
    toInt32(Clicks) as clicks,
    arrayElement(splitByChar('~', CampaignName), 2) AS utmHash
FROM test
)

SELECT * FROM cmps







  
      