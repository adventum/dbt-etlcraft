
        
  
    
    
        
        insert into test.incremental_vkads_datestat_default_ad_plans_statistics__dbt_new_data_f6e8ee16_f9a8_4fbb_be99_0c523e494e40 ("__date", "ad_offers", "ad_plan_id", "base", "carousel", "date", "events", "moat", "playable", "romi", "social_network", "tps", "uniques", "uniques_video", "video", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_vkads_datestat_default_ad_plans_statistics

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_vkads_datestat_default_ad_plans_statistics

  
      