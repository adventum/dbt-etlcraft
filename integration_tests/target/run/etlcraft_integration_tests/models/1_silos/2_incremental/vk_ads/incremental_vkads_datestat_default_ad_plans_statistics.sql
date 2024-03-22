
        
  
    
    
        
        insert into test.incremental_vkads_datestat_default_ad_plans_statistics__dbt_tmp ("__date", "ad_offers", "ad_plan_id", "base", "carousel", "date", "events", "moat", "playable", "romi", "social_network", "tps", "uniques", "uniques_video", "video", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_vkads_datestat_default_ad_plans_statistics

  
    