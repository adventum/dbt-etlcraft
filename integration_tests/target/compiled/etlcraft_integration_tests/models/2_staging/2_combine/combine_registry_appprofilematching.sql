-- depends_on: test.join_appmetrica_registry_appprofilematching
SELECT * REPLACE(toLowCardinality(__table_name) AS __table_name)
FROM (

(
SELECT
        toString("appmetricaDeviceId") as appmetricaDeviceId ,
        toString("crmUserId") as crmUserId ,
        toString("cityName") as cityName ,
        toDateTime("__emitted_at") as __emitted_at ,
        toString("__table_name") as __table_name ,
        toString("__link") as __link 
FROM test.join_appmetrica_registry_appprofilematching
)

) 

