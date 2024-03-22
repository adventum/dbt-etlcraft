
        
  
    
    
        
        insert into test.join_datestat_yd_default__dbt_tmp ("__datetime", "reportType", "accountName", "__table_name", "adSourceDirty", "productName", "adCampaignName", "adGroupName", "adId", "adPhraseId", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "utmHash", "adTitle1", "adTitle2", "adText", "adPhraseName", "adCost", "impressions", "clicks", "load_date")
  


WITH cmps AS (
SELECT * FROM test.incremental_yd_default_cmps 
WHERE toDate(__datetime) BETWEEN '2023-07-30' AND '2023-07-30')

SELECT  
    toDate(__datetime) AS __datetime,
    toLowCardinality('*') AS reportType, 
    toLowCardinality(splitByChar('_', __table_name)[6]) AS accountName,
    toLowCardinality(__table_name) AS __table_name,
    'Yandex Direct Ads' AS adSourceDirty,
    '' AS productName,
    CampaignName AS adCampaignName,
    CampaignType AS adGroupName,
    CampaignId AS adId,
    '' AS adPhraseId,
    '' AS utmSource,
    '' AS utmMedium,
    '' AS utmCampaign,
    '' AS utmTerm,
    '' AS utmContent,
    arrayElement(splitByChar('~', CampaignName), 2) AS utmHash,
    '' AS adTitle1,
    '' AS adTitle2,
    '' AS adText,
    '' AS adPhraseName,  
    (toFloat64(Cost)/1000000)*1.2 AS adCost,
    toInt32(Impressions) AS impressions,
    toInt32(Clicks) AS clicks,
    __emitted_at AS load_date
FROM cmps








  
    