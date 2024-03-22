
        
  
    
    
        
        insert into test.incremental_vkads_default_ad_plans_statistics__dbt_tmp ("__datetime", "ad_offers", "ad_plan_id", "base", "carousel", "events", "moat", "playable", "romi", "social_network", "tps", "uniques", "uniques_video", "video", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDateTime(__datetime, 'UTC') AS __datetime)
FROM test.normalize_vkads_default_ad_plans_statistics

  
    