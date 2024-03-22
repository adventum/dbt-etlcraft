
        
  
    
    
        
        insert into test.incremental_vkads_datestat_default_ad_plans_statistics__dbt_new_data_7e51c1da_7cf3_4f23_9fa8_84a704e56243 ("__date", "ad_offers", "ad_plan_id", "base", "carousel", "date", "events", "moat", "playable", "romi", "social_network", "tps", "uniques", "uniques_video", "video", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM test.normalize_vkads_datestat_default_ad_plans_statistics

  
      