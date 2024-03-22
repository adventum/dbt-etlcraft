
        
  
    
    
        
        insert into test.incremental_mt_default_banners_statistics__dbt_tmp ("__datetime", "__clientName", "__productName", "banner_id", "base", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDateTime(__datetime, 'UTC') AS __datetime)
FROM test.normalize_mt_default_banners_statistics

  
    