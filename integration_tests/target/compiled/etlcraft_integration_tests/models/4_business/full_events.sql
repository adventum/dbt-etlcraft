-- depends_on: test.graph_qid
-- depends_on: test.link_appmetrica_registry
SELECT * FROM 

        (
            select

                --toLowCardinality('graph_qid')  as _dbt_source_relation,
                
                            toString("__link") as __link ,
                            toDateTime("__datetime") as __datetime ,
                            toString("__id") as __id ,
                            toUInt64("qid") as qid ,
                            toString('') as appmetricaDeviceId ,
                            toString('') as crmUserId ,
                            toString('') as cityName ,
                            toDateTime(0) as __emitted_at ,
                            toString('') as AppProfileMatchingHash ,
                            toString('') as AppMetricaDeviceHash ,
                            toString('') as CrmUserHash 

            from test.graph_qid
        )

        union all
        

        (
            select

                --toLowCardinality('link_appmetrica_registry')  as _dbt_source_relation,
                
                            toString("__link") as __link ,
                            toDateTime("__datetime") as __datetime ,
                            toString("__id") as __id ,
                            toUInt64(0) as qid ,
                            toString("appmetricaDeviceId") as appmetricaDeviceId ,
                            toString("crmUserId") as crmUserId ,
                            toString("cityName") as cityName ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("AppProfileMatchingHash") as AppProfileMatchingHash ,
                            toString("AppMetricaDeviceHash") as AppMetricaDeviceHash ,
                            toString("CrmUserHash") as CrmUserHash 

            from test.link_appmetrica_registry
        )

        



