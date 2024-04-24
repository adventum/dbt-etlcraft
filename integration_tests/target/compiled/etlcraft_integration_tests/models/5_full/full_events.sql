-- depends_on: test.graph_qid
-- depends_on: test.link_appmetrica_registry
-- depends_on: test.link_utmcraft_registry


WITH t1 AS (
SELECT * FROM test.link_events
LEFT JOIN test.graph_qid USING (__id, __link, __datetime)
)
, t2 AS (
SELECT * FROM 

        (
            select
                            toString("appmetricaDeviceId") as appmetricaDeviceId ,
                            toString("crmUserId") as crmUserId ,
                            toString("cityName") as cityName ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__table_name") as __table_name ,
                            toString("__link") as __link ,
                            toString("AppProfileMatchingHash") as AppProfileMatchingHash ,
                            toString("AppMetricaDeviceHash") as AppMetricaDeviceHash ,
                            toString("CrmUserHash") as CrmUserHash ,
                            toString("__id") as __id ,
                            toDateTime("__datetime") as __datetime ,
                            toString('') as utmHash ,
                            toString('') as utm_base_url ,
                            toString('') as utm_utmSource ,
                            toString('') as utm_utmMedium ,
                            toString('') as utm_utmCampaign ,
                            toString('') as utm_project ,
                            toString('') as utm_utmContent ,
                            toString('') as utm_strategy ,
                            toString('') as utm_audience ,
                            toString('') as UtmHashRegistryHash ,
                            toString('') as UtmHashHash 

            from test.link_appmetrica_registry
        )

        union all
        

        (
            select
                            toString('') as appmetricaDeviceId ,
                            toString('') as crmUserId ,
                            toString('') as cityName ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__table_name") as __table_name ,
                            toString("__link") as __link ,
                            toString('') as AppProfileMatchingHash ,
                            toString('') as AppMetricaDeviceHash ,
                            toString('') as CrmUserHash ,
                            toString("__id") as __id ,
                            toDateTime("__datetime") as __datetime ,
                            toString("utmHash") as utmHash ,
                            toString("utm_base_url") as utm_base_url ,
                            toString("utm_utmSource") as utm_utmSource ,
                            toString("utm_utmMedium") as utm_utmMedium ,
                            toString("utm_utmCampaign") as utm_utmCampaign ,
                            toString("utm_project") as utm_project ,
                            toString("utm_utmContent") as utm_utmContent ,
                            toString("utm_strategy") as utm_strategy ,
                            toString("utm_audience") as utm_audience ,
                            toString("UtmHashRegistryHash") as UtmHashRegistryHash ,
                            toString("UtmHashHash") as UtmHashHash 

            from test.link_utmcraft_registry
        )

        
)
, t3 AS (
SELECT * 
FROM t1
LEFT JOIN t2 USING (__id, __link, __datetime)
)
SELECT * EXCEPT(`t2.__emitted_at`, `t2.__table_name`, `t2.appmetricaDeviceId`, `t2.crmUserId`, 
`t2.cityName`, `t2.utmHash`, `t2.UtmHashHash`, `t2.AppMetricaDeviceHash`, `t2.CrmUserHash`)
FROM t3

