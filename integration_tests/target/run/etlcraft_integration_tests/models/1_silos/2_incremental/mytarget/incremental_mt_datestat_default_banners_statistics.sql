
        
  
    
    
        
        insert into test.incremental_mt_datestat_default_banners_statistics__dbt_new_data_d00f206f_3a10_4cf3_beb1_b14662f886e4 ("__date", "__clientName", "__productName", "banner_id", "base", "date", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_mt_datestat_default_banners_statistics


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_mt_datestat_default_banners_statistics
  
      