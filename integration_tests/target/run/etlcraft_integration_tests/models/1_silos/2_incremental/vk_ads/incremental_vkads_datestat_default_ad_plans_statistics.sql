
        
  
    
    
        
        insert into test.incremental_vkads_datestat_default_ad_plans_statistics__dbt_new_data_8321cbef_6326_48d2_a58a_4e787ccb0180 ("__date", "ad_offers", "ad_plan_id", "base", "carousel", "date", "events", "moat", "playable", "romi", "social_network", "tps", "uniques", "uniques_video", "video", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_vkads_datestat_default_ad_plans_statistics

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_vkads_datestat_default_ad_plans_statistics

  
      