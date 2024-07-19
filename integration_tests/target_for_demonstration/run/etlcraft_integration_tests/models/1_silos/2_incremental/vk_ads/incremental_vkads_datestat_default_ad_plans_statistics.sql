
        
  
    
    
        
        insert into test.incremental_vkads_datestat_default_ad_plans_statistics__dbt_new_data_951bb9ee_eb7b_44e4_99d3_b44e3e697cd0 ("__date", "ad_offers", "ad_plan_id", "base", "carousel", "date", "events", "moat", "playable", "romi", "social_network", "tps", "uniques", "uniques_video", "video", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_vkads_datestat_default_ad_plans_statistics


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_vkads_datestat_default_ad_plans_statistics
  
      