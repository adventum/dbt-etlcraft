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
                            toString("adCampaignName") as adCampaignName ,
                            toString("adId") as adId ,
                            toString("utmSource") as utmSource ,
                            toString("utmMedium") as utmMedium ,
                            toString("utmCampaign") as utmCampaign ,
                            toString("utmTerm") as utmTerm ,
                            toString("utmContent") as utmContent ,
                            toString("utmHash") as utmHash ,
                            toString("adTitle1") as adTitle1 ,
                            toString("adText") as adText ,
                            toFloat64("adCost") as adCost ,
                            toInt32("impressions") as impressions ,
                            toInt32("clicks") as clicks ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__link") as __link ,
                            toString('') as adGroupName ,
                            toString('') as adPhraseId 

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
                            toString("adCampaignName") as adCampaignName ,
                            toString("adId") as adId ,
                            toString('') as utmSource ,
                            toString('') as utmMedium ,
                            toString('') as utmCampaign ,
                            toString('') as utmTerm ,
                            toString('') as utmContent ,
                            toString('') as utmHash ,
                            toString('') as adTitle1 ,
                            toString('') as adText ,
                            toFloat64("adCost") as adCost ,
                            toInt32("impressions") as impressions ,
                            toInt32("clicks") as clicks ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__link") as __link ,
                            toString('') as adGroupName ,
                            toString('') as adPhraseId 

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
                            toString("adCampaignName") as adCampaignName ,
                            toString("adId") as adId ,
                            toString('') as utmSource ,
                            toString('') as utmMedium ,
                            toString('') as utmCampaign ,
                            toString('') as utmTerm ,
                            toString('') as utmContent ,
                            toString("utmHash") as utmHash ,
                            toString('') as adTitle1 ,
                            toString('') as adText ,
                            toFloat64("adCost") as adCost ,
                            toInt32("impressions") as impressions ,
                            toInt32("clicks") as clicks ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__link") as __link ,
                            toString("adGroupName") as adGroupName ,
                            toString("adPhraseId") as adPhraseId 

            from test.join_yd_datestat
        )

        ) 

