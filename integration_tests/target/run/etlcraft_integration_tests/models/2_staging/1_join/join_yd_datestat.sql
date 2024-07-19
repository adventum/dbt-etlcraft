
        
  
    
    
        
        insert into test.join_yd_datestat__dbt_new_data_d00f206f_3a10_4cf3_beb1_b14662f886e4 ("__date", "reportType", "accountName", "__table_name", "adSourceDirty", "adCampaignName", "adGroupName", "adId", "adPhraseId", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "utmHash", "adCost", "impressions", "clicks", "__emitted_at", "__link")
  -- depends_on: test.incremental_yd_datestat_default_custom_report
                                                             
  
  
  
  
  

WITH cmps AS (
SELECT * FROM (
    

        (
            select
                cast('test.incremental_yd_datestat_default_custom_report' as String) as _dbt_source_relation,

                
                    cast("__date" as Date) as "__date" ,
                    cast("__clientName" as String) as "__clientName" ,
                    cast("__productName" as String) as "__productName" ,
                    cast("AdId" as String) as "AdId" ,
                    cast("CampaignId" as String) as "CampaignId" ,
                    cast("CampaignName" as String) as "CampaignName" ,
                    cast("CampaignType" as String) as "CampaignType" ,
                    cast("Clicks" as String) as "Clicks" ,
                    cast("Cost" as String) as "Cost" ,
                    cast("Date" as String) as "Date" ,
                    cast("Impressions" as String) as "Impressions" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_yd_datestat_default_custom_report

            
        )

        ) 
WHERE toDate(__date) BETWEEN '2024-02-15' AND '2024-02-28')

SELECT  
    toDate(__date) AS __date,
    toLowCardinality('*') AS reportType, 
    toLowCardinality(splitByChar('_', __table_name)[8]) AS accountName,
    toLowCardinality(__table_name) AS __table_name,
    'Yandex Direct Ads' AS adSourceDirty,
    --'' AS productName,
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
    --'' AS adTitle1,
    --'' AS adTitle2,
    --'' AS adText,
    --'' AS adPhraseName,  
    (toFloat64(Cost)/1000000)*1.2 AS adCost,
    toInt32(Impressions) AS impressions,
    toInt32(Clicks) AS clicks,
    __emitted_at,
    toLowCardinality('AdCostStat') AS __link 
FROM cmps



  
      