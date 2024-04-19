
  
    
    
        
        insert into test.combine_appmetrica_registry__dbt_tmp ("appmetricaDeviceId", "crmUserId", "cityName", "utmHash", "__emitted_at", "__table_name", "__link")
  -- depends_on: test.join_appmetrica_registry
SELECT * REPLACE(toLowCardinality(__table_name) AS __table_name)
FROM (

        (
            select
                            toString("appmetricaDeviceId") as appmetricaDeviceId ,
                            toString("crmUserId") as crmUserId ,
                            toString("cityName") as cityName ,
                            toString("utmHash") as utmHash ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__table_name") as __table_name ,
                            toString("__link") as __link 

            from test.join_appmetrica_registry
        )

        ) 


  