
  
    
    
        
        insert into test.incremental_vkads_registry_default_ad_plans__dbt_backup ("ad_groups", "autobidding_mode", "budget_limit", "budget_limit_day", "created", "date_end", "date_start", "id", "max_price", "name", "objective", "priced_goal", "pricelist_id", "status", "updated", "vkads_status", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_vkads_registry_default_ad_plans


SELECT * 

FROM normalize_vkads_registry_default_ad_plans


  