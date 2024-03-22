

  create view test.combine_datestat_default__dbt_tmp 
  
  as (
    SELECT *
    FROM (
    

        (
            select

                
                    cast("__datetime" as Date) as "__datetime" ,
                    cast("reportType" as String) as "reportType" ,
                    cast("accountName" as String) as "accountName" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("adSourceDirty" as String) as "adSourceDirty" ,
                    cast("productName" as String) as "productName" ,
                    cast("adCampaignName" as String) as "adCampaignName" ,
                    cast("adGroupName" as String) as "adGroupName" ,
                    cast("adId" as String) as "adId" ,
                    cast("adPhraseId" as String) as "adPhraseId" ,
                    cast("utmSource" as String) as "utmSource" ,
                    cast("utmMedium" as String) as "utmMedium" ,
                    cast("utmCampaign" as String) as "utmCampaign" ,
                    cast("utmTerm" as String) as "utmTerm" ,
                    cast("utmContent" as String) as "utmContent" ,
                    cast("utmHash" as String) as "utmHash" ,
                    cast("adTitle1" as String) as "adTitle1" ,
                    cast("adTitle2" as String) as "adTitle2" ,
                    cast("adText" as String) as "adText" ,
                    cast("adPhraseName" as String) as "adPhraseName" ,
                    cast("adCost" as Float64) as "adCost" ,
                    cast("impressions" as Int32) as "impressions" ,
                    cast("clicks" as Int32) as "clicks" ,
                    cast("load_date" as DateTime) as "load_date" 

            from test.join_datestat_mt_default

            
        )

        union all
        

        (
            select

                
                    cast("__datetime" as Date) as "__datetime" ,
                    cast("reportType" as String) as "reportType" ,
                    cast("accountName" as String) as "accountName" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("adSourceDirty" as String) as "adSourceDirty" ,
                    cast("productName" as String) as "productName" ,
                    cast("adCampaignName" as String) as "adCampaignName" ,
                    cast("adGroupName" as String) as "adGroupName" ,
                    cast("adId" as String) as "adId" ,
                    cast("adPhraseId" as String) as "adPhraseId" ,
                    cast("utmSource" as String) as "utmSource" ,
                    cast("utmMedium" as String) as "utmMedium" ,
                    cast("utmCampaign" as String) as "utmCampaign" ,
                    cast("utmTerm" as String) as "utmTerm" ,
                    cast("utmContent" as String) as "utmContent" ,
                    cast("utmHash" as String) as "utmHash" ,
                    cast("adTitle1" as String) as "adTitle1" ,
                    cast("adTitle2" as String) as "adTitle2" ,
                    cast("adText" as String) as "adText" ,
                    cast("adPhraseName" as String) as "adPhraseName" ,
                    cast("adCost" as Float64) as "adCost" ,
                    cast("impressions" as Int32) as "impressions" ,
                    cast("clicks" as Int32) as "clicks" ,
                    cast("load_date" as DateTime) as "load_date" 

            from test.join_datestat_vkads_default

            
        )

        union all
        

        (
            select

                
                    cast("__datetime" as Date) as "__datetime" ,
                    cast("reportType" as String) as "reportType" ,
                    cast("accountName" as String) as "accountName" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("adSourceDirty" as String) as "adSourceDirty" ,
                    cast("productName" as String) as "productName" ,
                    cast("adCampaignName" as String) as "adCampaignName" ,
                    cast("adGroupName" as String) as "adGroupName" ,
                    cast("adId" as String) as "adId" ,
                    cast("adPhraseId" as String) as "adPhraseId" ,
                    cast("utmSource" as String) as "utmSource" ,
                    cast("utmMedium" as String) as "utmMedium" ,
                    cast("utmCampaign" as String) as "utmCampaign" ,
                    cast("utmTerm" as String) as "utmTerm" ,
                    cast("utmContent" as String) as "utmContent" ,
                    cast("utmHash" as String) as "utmHash" ,
                    cast("adTitle1" as String) as "adTitle1" ,
                    cast("adTitle2" as String) as "adTitle2" ,
                    cast("adText" as String) as "adText" ,
                    cast("adPhraseName" as String) as "adPhraseName" ,
                    cast("adCost" as Float64) as "adCost" ,
                    cast("impressions" as Int32) as "impressions" ,
                    cast("clicks" as Int32) as "clicks" ,
                    cast("load_date" as DateTime) as "load_date" 

            from test.join_datestat_yd_default

            
        )

        )
  )