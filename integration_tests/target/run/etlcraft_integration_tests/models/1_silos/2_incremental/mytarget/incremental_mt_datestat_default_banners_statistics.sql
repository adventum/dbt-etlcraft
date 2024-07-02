
        
  
    
    
        
        insert into test.incremental_mt_datestat_default_banners_statistics__dbt_new_data_ad331357_6a84_4c95_8464_974832726b93 ("__date", "__clientName", "__productName", "banner_id", "base", "date", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_mt_datestat_default_banners_statistics


SELECT * REPLACE(toDate(__date, 'UTC') AS __date) 

FROM test.normalize_mt_datestat_default_banners_statistics
  
      