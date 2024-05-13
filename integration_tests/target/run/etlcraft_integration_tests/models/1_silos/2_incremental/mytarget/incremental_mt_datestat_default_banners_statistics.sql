
        
  
    
    
        
        insert into test.incremental_mt_datestat_default_banners_statistics__dbt_tmp ("__date", "__clientName", "__productName", "banner_id", "base", "date", "__table_name", "__emitted_at", "__normalized_at")
  
SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM (

        (
            select
                            toString("__date") as __date ,
                            toString("__clientName") as __clientName ,
                            toString("__productName") as __productName ,
                            toString("banner_id") as banner_id ,
                            toString("base") as base ,
                            toString("date") as date ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_mt_datestat_default_banners_statistics
        )

        )

  
    