-- depends_on: test.normalize_yd_datestat_default_custom_report

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM (

        (
            select
                            toString("__date") as __date ,
                            toString("__clientName") as __clientName ,
                            toString("__productName") as __productName ,
                            toString("AdId") as AdId ,
                            toString("CampaignId") as CampaignId ,
                            toString("CampaignName") as CampaignName ,
                            toString("CampaignType") as CampaignType ,
                            toString("Clicks") as Clicks ,
                            toString("Cost") as Cost ,
                            toString("Date") as Date ,
                            toString("Impressions") as Impressions ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_yd_datestat_default_custom_report
        )

        )
