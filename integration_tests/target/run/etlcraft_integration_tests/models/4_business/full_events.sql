
  
    
    
        
        insert into test.full_events__dbt_backup ("__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "visitId", "clientId", "promoCode", "osName", "cityName", "adSourceDirty", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "cityCode", "pageViews", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "VisitStatHash", "AppMetricaDeviceHash", "CrmUserHash", "YmClientHash", "__id", "__datetime", "qid", "t2.appmetricaDeviceId", "t2.crmUserId", "t2.cityName", "t2.__emitted_at", "AppProfileMatchingHash", "t2.AppMetricaDeviceHash", "t2.CrmUserHash")
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

                --toLowCardinality('link_appmetrica_registry')  as _dbt_source_relation,
                
                            toString("appmetricaDeviceId") as appmetricaDeviceId ,
                            toString("crmUserId") as crmUserId ,
                            toString("cityName") as cityName ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toString("__link") as __link ,
                            toString("AppProfileMatchingHash") as AppProfileMatchingHash ,
                            toString("AppMetricaDeviceHash") as AppMetricaDeviceHash ,
                            toString("CrmUserHash") as CrmUserHash ,
                            toString("__id") as __id ,
                            toDateTime("__datetime") as __datetime 

            from test.link_appmetrica_registry
        )

         t2 USING (__id, __link, __datetime)
  