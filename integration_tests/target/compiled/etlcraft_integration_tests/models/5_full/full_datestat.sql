-- depends_on: test.link_datestat
-- depends_on: test.link_registry_appprofilematching
-- depends_on: test.link_registry_utmhashregistry


WITH t1 AS (
SELECT * FROM test.link_datestat
)
, t2 AS (
SELECT * FROM 

        (
            select
                            toString("utmHash") as utmHash ,
                            toString("utm_base_url") as utm_base_url ,
                            toString("utm_utmSource") as utm_utmSource ,
                            toString("utm_utmMedium") as utm_utmMedium ,
                            toString("utm_utmCampaign") as utm_utmCampaign ,
                            toString("utm_project") as utm_project ,
                            toString("utm_utmContent") as utm_utmContent ,
                            toString("utm_strategy") as utm_strategy ,
                            toString("utm_audience") as utm_audience ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__table_name") as __table_name ,
                            toString("__link") as __link ,
                            toString("UtmHashRegistryHash") as UtmHashRegistryHash ,
                            toString("UtmHashHash") as UtmHashHash ,
                            toString("__id") as __id ,
                            toDateTime("__datetime") as __datetime ,
                            toString('') as appmetricaDeviceId ,
                            toString('') as crmUserId ,
                            toString('') as cityName ,
                            toString('') as AppProfileMatchingHash ,
                            toString('') as AppMetricaDeviceHash ,
                            toString('') as CrmUserHash 

            from test.link_registry_utmhashregistry
        )

        union all
        

        (
            select
                            toString('') as utmHash ,
                            toString('') as utm_base_url ,
                            toString('') as utm_utmSource ,
                            toString('') as utm_utmMedium ,
                            toString('') as utm_utmCampaign ,
                            toString('') as utm_project ,
                            toString('') as utm_utmContent ,
                            toString('') as utm_strategy ,
                            toString('') as utm_audience ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__table_name") as __table_name ,
                            toString("__link") as __link ,
                            toString('') as UtmHashRegistryHash ,
                            toString('') as UtmHashHash ,
                            toString("__id") as __id ,
                            toDateTime("__datetime") as __datetime ,
                            toString("appmetricaDeviceId") as appmetricaDeviceId ,
                            toString("crmUserId") as crmUserId ,
                            toString("cityName") as cityName ,
                            toString("AppProfileMatchingHash") as AppProfileMatchingHash ,
                            toString("AppMetricaDeviceHash") as AppMetricaDeviceHash ,
                            toString("CrmUserHash") as CrmUserHash 

            from test.link_registry_appprofilematching
        )

        
)
, t3 AS (
SELECT * FROM t1
LEFT JOIN t2 USING (__id, __link, __datetime)
)
SELECT * --COLUMNS('^[a-z|_][^2]') 
FROM t3