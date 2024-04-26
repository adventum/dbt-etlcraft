
  
    
    
        
        insert into test.attr_myfirstfunnel_prepare_with_qid__dbt_backup ("qid", "__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "adSourceDirty", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "visitId", "clientId", "cityCode", "pageViews", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "VisitStatHash", "AppMetricaDeviceHash", "CrmUserHash", "UtmHashHash", "YmClientHash", "__id", "__datetime", "t2.utmHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "t2.__emitted_at", "t2.__table_name", "UtmHashRegistryHash", "t2.UtmHashHash", "t2.appmetricaDeviceId", "t2.crmUserId", "t2.cityName", "AppProfileMatchingHash", "t2.AppMetricaDeviceHash", "t2.CrmUserHash")
  -- depends_on: test.full_events
-- depends_on: test.graph_qid

WITH full_events_without_qid AS (
SELECT *EXCEPT(qid) FROM test.full_events
)

SELECT y.qid, x.*
FROM full_events_without_qid AS x
LEFT JOIN test.graph_qid AS y
    USING (__datetime,__link, __id)



  