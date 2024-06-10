
        
  
    
    
        
        insert into test.join_vkads_datestat__dbt_new_data_e73065dd_cb2b_48cf_898d_f49bff11cfc3 ("__date", "reportType", "accountName", "__table_name", "adSourceDirty", "adCampaignName", "adId", "adCost", "impressions", "clicks", "__emitted_at", "__link")
  -- depends_on: test.incremental_vkads_datestat_default_ad_plans_statistics
-- depends_on: test.incremental_vkads_registry_default_ad_plans
                                                             
  
  
  
  
  
  
WITH ad_plans_statistics AS (
SELECT * FROM (
    

        (
            select
                cast('test.incremental_vkads_datestat_default_ad_plans_statistics' as String) as _dbt_source_relation,

                
                    cast("__date" as Date) as "__date" ,
                    cast("ad_offers" as String) as "ad_offers" ,
                    cast("ad_plan_id" as String) as "ad_plan_id" ,
                    cast("base" as String) as "base" ,
                    cast("carousel" as String) as "carousel" ,
                    cast("date" as String) as "date" ,
                    cast("events" as String) as "events" ,
                    cast("moat" as String) as "moat" ,
                    cast("playable" as String) as "playable" ,
                    cast("romi" as String) as "romi" ,
                    cast("social_network" as String) as "social_network" ,
                    cast("tps" as String) as "tps" ,
                    cast("uniques" as String) as "uniques" ,
                    cast("uniques_video" as String) as "uniques_video" ,
                    cast("video" as String) as "video" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_vkads_datestat_default_ad_plans_statistics

            
        )

        ) 
WHERE toDate(__date) between '2024-02-26' and '2024-03-02'),

ad_plans AS (
SELECT * FROM (
    

        (
            select
                cast('test.incremental_vkads_periodstat_default_ad_plans' as String) as _dbt_source_relation,

                
                    cast("ad_groups" as String) as "ad_groups" ,
                    cast("autobidding_mode" as String) as "autobidding_mode" ,
                    cast("budget_limit" as String) as "budget_limit" ,
                    cast("budget_limit_day" as String) as "budget_limit_day" ,
                    cast("created" as String) as "created" ,
                    cast("date_end" as String) as "date_end" ,
                    cast("date_start" as String) as "date_start" ,
                    cast("id" as String) as "id" ,
                    cast("max_price" as String) as "max_price" ,
                    cast("name" as String) as "name" ,
                    cast("objective" as String) as "objective" ,
                    cast("priced_goal" as String) as "priced_goal" ,
                    cast("pricelist_id" as String) as "pricelist_id" ,
                    cast("status" as String) as "status" ,
                    cast("updated" as String) as "updated" ,
                    cast("vkads_status" as String) as "vkads_status" ,
                    cast("__table_name" as String) as "__table_name" ,
                    cast("__emitted_at" as DateTime) as "__emitted_at" ,
                    cast("__normalized_at" as DateTime) as "__normalized_at" 

            from test.incremental_vkads_periodstat_default_ad_plans

            
        )

        )
)

SELECT
    toDate(ad_plans_statistics.__date) AS __date,
    toLowCardinality('*') AS reportType,
    toLowCardinality(splitByChar('_', ad_plans.__table_name)[6]) AS accountName,
    toLowCardinality(ad_plans.__table_name) AS __table_name,
    'VK Ads' AS adSourceDirty,
    ad_plans.name AS adCampaignName,
    ad_plans.id AS adId,
    toFloat64(JSONExtractString(ad_plans_statistics.base, 'spent'))* 1.2 AS adCost,
    toInt32(JSONExtractString(ad_plans_statistics.base, 'shows')) AS impressions,
    toInt32(JSONExtractString(ad_plans_statistics.base, 'clicks')) AS clicks,
    ad_plans.__emitted_at AS __emitted_at,
    toLowCardinality('AdCostStat') AS __link 
FROM ad_plans
JOIN ad_plans_statistics ON ad_plans.id = ad_plans_statistics.ad_plan_id


  
      