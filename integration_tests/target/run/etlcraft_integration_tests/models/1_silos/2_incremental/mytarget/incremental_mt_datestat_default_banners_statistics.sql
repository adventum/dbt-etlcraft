
        
  
    
    
        
        insert into test.incremental_mt_datestat_default_banners_statistics__dbt_new_data_8321cbef_6326_48d2_a58a_4e787ccb0180 ("__date", "__clientName", "__productName", "banner_id", "base", "date", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_mt_datestat_default_banners_statistics

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM normalize_mt_datestat_default_banners_statistics

  
      