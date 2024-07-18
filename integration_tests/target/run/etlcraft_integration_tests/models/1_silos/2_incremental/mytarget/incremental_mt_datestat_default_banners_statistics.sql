
        
  
    
    
        
        insert into test.incremental_mt_datestat_default_banners_statistics__dbt_new_data_f50e9b17_4bb0_4344_8a76_0ec649a9f6b0 ("__date", "__clientName", "__productName", "banner_id", "base", "date", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_mt_datestat_default_banners_statistics


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_mt_datestat_default_banners_statistics
  
      