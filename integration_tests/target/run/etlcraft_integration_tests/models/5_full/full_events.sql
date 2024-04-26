
  
    
    
        
        insert into test.full_events__dbt_backup ("__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "adSourceDirty", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "visitId", "clientId", "cityCode", "pageViews", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "VisitStatHash", "AppMetricaDeviceHash", "CrmUserHash", "UtmHashHash", "YmClientHash", "__id", "__datetime", "qid", "t2.utmHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "t2.__emitted_at", "t2.__table_name", "UtmHashRegistryHash", "t2.UtmHashHash", "t2.appmetricaDeviceId", "t2.crmUserId", "t2.cityName", "AppProfileMatchingHash", "t2.AppMetricaDeviceHash", "t2.CrmUserHash")
  -- depends_on: test.graph_qid
-- depends_on: test.link_registry_appprofilematching
-- depends_on: test.link_registry_utmhashregistry


WITH t1 AS (
SELECT * FROM test.link_events
LEFT JOIN test.graph_qid USING (__id, __link, __datetime)
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
SELECT * 
FROM t1
LEFT JOIN t2 USING (__id, __link, __datetime)
)
SELECT * --COLUMNS('^[a-z|_][^2]') 
FROM t3
  