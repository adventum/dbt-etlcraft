-- depends_on: test.graph_qid
-- depends_on: test.link_appmetrica_registry


SELECT * 
FROM (
    SELECT * FROM test.link_events
    LEFT JOIN test.graph_qid USING (__id, __link, __datetime)
) t1
LEFT JOIN 

        (
            select
                            toString("appmetricaDeviceId") as appmetricaDeviceId ,
                            toString("crmUserId") as crmUserId ,
                            toString("cityName") as cityName ,
                            toString("utmHash") as utmHash ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__table_name") as __table_name ,
                            toString("__link") as __link ,
                            toString("UtmHashRegistryHash") as UtmHashRegistryHash ,
                            toString("AppProfileMatchingHash") as AppProfileMatchingHash ,
                            toString("UtmHashHash") as UtmHashHash ,
                            toString("AppMetricaDeviceHash") as AppMetricaDeviceHash ,
                            toString("CrmUserHash") as CrmUserHash ,
                            toString("__id") as __id ,
                            toDateTime("__datetime") as __datetime 

            from test.link_appmetrica_registry
        )

         t2 USING (__id, __link, __datetime)