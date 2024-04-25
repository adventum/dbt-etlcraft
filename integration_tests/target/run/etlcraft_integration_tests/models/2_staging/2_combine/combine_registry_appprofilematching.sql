
  
    
    
        
        insert into test.combine_registry_appprofilematching__dbt_backup ("appmetricaDeviceId", "crmUserId", "cityName", "__emitted_at", "__table_name", "__link")
  -- depends_on: test.join_appmetrica_registry_appprofilematching
SELECT * REPLACE(toLowCardinality(__table_name) AS __table_name)
FROM (

        (
            select
                            toString("appmetricaDeviceId") as appmetricaDeviceId ,
                            toString("crmUserId") as crmUserId ,
                            toString("cityName") as cityName ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__table_name") as __table_name ,
                            toString("__link") as __link 

            from test.join_appmetrica_registry_appprofilematching
        )

        ) 


  