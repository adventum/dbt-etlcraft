
        
  
    
    
        
        insert into test.full_datestat__dbt_tmp ("__date", "reportType", "accountName", "__table_name", "adSourceDirty", "productName", "adCampaignName", "adGroupName", "adId", "adPhraseId", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "utmHash", "adTitle1", "adTitle2", "adText", "adPhraseName", "adCost", "impressions", "clicks", "__emitted_at", "__link", "AdCostStatHash", "UtmHashHash", "__id", "__datetime", "appmetricaDeviceId", "crmUserId", "cityName", "AppProfileMatchingHash", "AppMetricaDeviceHash", "CrmUserHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "UtmHashRegistryHash")
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

            from test.link_registry_appprofilematching
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

            from test.link_registry_utmhashregistry
        )

        
)
, t3 AS (
SELECT * FROM t1
LEFT JOIN t2 USING (__id, __link, __datetime)
)
SELECT * EXCEPT(`t2.__emitted_at`, `t2.__table_name`, `t2.utmHash`, `t2.UtmHashHash`)
FROM t3


  
    