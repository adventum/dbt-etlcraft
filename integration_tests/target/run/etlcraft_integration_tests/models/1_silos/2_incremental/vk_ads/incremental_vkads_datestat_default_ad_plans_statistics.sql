
        
  
    
    
        
        insert into test.incremental_vkads_datestat_default_ad_plans_statistics__dbt_new_data_2bf53b95_0650_46c0_bde3_29ac391b31f4 ("__date", "ad_offers", "ad_plan_id", "base", "carousel", "date", "events", "moat", "playable", "romi", "social_network", "tps", "uniques", "uniques_video", "video", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_vkads_datestat_default_ad_plans_statistics


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_vkads_datestat_default_ad_plans_statistics
  
      