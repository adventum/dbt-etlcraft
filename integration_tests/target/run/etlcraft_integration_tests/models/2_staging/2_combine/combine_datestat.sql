
        
  
    
    
        
        insert into test.combine_datestat__dbt_tmp ("__date", "reportType", "accountName", "__table_name", "adSourceDirty", "productName", "adCampaignName", "adGroupName", "adId", "adPhraseId", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "utmHash", "adTitle1", "adTitle2", "adText", "adPhraseName", "adCost", "impressions", "clicks", "__emitted_at", "__link")
  -- depends_on: test.join_mt_datestat
-- depends_on: test.join_vkads_datestat
-- depends_on: test.join_yd_datestat
SELECT * REPLACE(toLowCardinality(__table_name) AS __table_name)
FROM (

        (
            select
                            toDate("__date") as __date ,
                            toString("reportType") as reportType ,
                            toString("accountName") as accountName ,
                            toString("__table_name") as __table_name ,
                            toString("adSourceDirty") as adSourceDirty ,
                            toString("productName") as productName ,
                            toString("adCampaignName") as adCampaignName ,
                            toString("adGroupName") as adGroupName ,
                            toString("adId") as adId ,
                            toString("adPhraseId") as adPhraseId ,
                            toString("utmSource") as utmSource ,
                            toString("utmMedium") as utmMedium ,
                            toString("utmCampaign") as utmCampaign ,
                            toString("utmTerm") as utmTerm ,
                            toString("utmContent") as utmContent ,
                            toString("utmHash") as utmHash ,
                            toString("adTitle1") as adTitle1 ,
                            toString("adTitle2") as adTitle2 ,
                            toString("adText") as adText ,
                            toString("adPhraseName") as adPhraseName ,
                            toFloat64("adCost") as adCost ,
                            toInt32("impressions") as impressions ,
                            toInt32("clicks") as clicks ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__link") as __link 

            from test.join_mt_datestat
        )

        union all
        

        (
            select
                            toDate("__date") as __date ,
                            toString("reportType") as reportType ,
                            toString("accountName") as accountName ,
                            toString("__table_name") as __table_name ,
                            toString("adSourceDirty") as adSourceDirty ,
                            toString("productName") as productName ,
                            toString("adCampaignName") as adCampaignName ,
                            toString("adGroupName") as adGroupName ,
                            toString("adId") as adId ,
                            toString("adPhraseId") as adPhraseId ,
                            toString("utmSource") as utmSource ,
                            toString("utmMedium") as utmMedium ,
                            toString("utmCampaign") as utmCampaign ,
                            toString("utmTerm") as utmTerm ,
                            toString("utmContent") as utmContent ,
                            toString("utmHash") as utmHash ,
                            toString("adTitle1") as adTitle1 ,
                            toString("adTitle2") as adTitle2 ,
                            toString("adText") as adText ,
                            toString("adPhraseName") as adPhraseName ,
                            toFloat64("adCost") as adCost ,
                            toInt32("impressions") as impressions ,
                            toInt32("clicks") as clicks ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__link") as __link 

            from test.join_vkads_datestat
        )

        union all
        

        (
            select
                            toDate("__date") as __date ,
                            toString("reportType") as reportType ,
                            toString("accountName") as accountName ,
                            toString("__table_name") as __table_name ,
                            toString("adSourceDirty") as adSourceDirty ,
                            toString("productName") as productName ,
                            toString("adCampaignName") as adCampaignName ,
                            toString("adGroupName") as adGroupName ,
                            toString("adId") as adId ,
                            toString("adPhraseId") as adPhraseId ,
                            toString("utmSource") as utmSource ,
                            toString("utmMedium") as utmMedium ,
                            toString("utmCampaign") as utmCampaign ,
                            toString("utmTerm") as utmTerm ,
                            toString("utmContent") as utmContent ,
                            toString("utmHash") as utmHash ,
                            toString("adTitle1") as adTitle1 ,
                            toString("adTitle2") as adTitle2 ,
                            toString("adText") as adText ,
                            toString("adPhraseName") as adPhraseName ,
                            toFloat64("adCost") as adCost ,
                            toInt32("impressions") as impressions ,
                            toInt32("clicks") as clicks ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__link") as __link 

            from test.join_yd_datestat
        )

        ) 


  
    