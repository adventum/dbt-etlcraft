
  
    
    
        
        insert into test.attr_myfirstfunnel_prepare_with_qid__dbt_backup ("qid", "__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "adSourceDirty", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "touch_type", "touch_time", "install_time", "event_time", "event_name", "event_source", "partner", "media_source", "campaign", "site_id", "ad", "country_code", "city", "appsflyer_id", "custom_uid", "platform", "is_retargeting", "is_primary_attribution", "visitId", "clientId", "cityCode", "pageViews", "VisitStatHash", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "YmClientHash", "UtmHashHash", "AppMetricaDeviceHash", "CrmUserHash", "__id", "__datetime", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "UtmHashRegistryHash", "AppProfileMatchingHash")
  -- depends_on: test.full_events
-- depends_on: test.graph_qid

WITH full_events_without_qid AS (
SELECT *EXCEPT(qid) FROM test.full_events
)

SELECT y.qid, x.*
FROM full_events_without_qid AS x
LEFT JOIN test.graph_qid AS y
    USING (__datetime,__link, __id)



  