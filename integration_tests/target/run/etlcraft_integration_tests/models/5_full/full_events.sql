
  
    
    
        
        insert into test.full_events__dbt_backup ("__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "adSourceDirty", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "touch_type", "touch_time", "install_time", "event_time", "event_name", "event_source", "partner", "media_source", "campaign", "site_id", "ad", "country_code", "city", "appsflyer_id", "custom_uid", "platform", "is_retargeting", "is_primary_attribution", "visitId", "clientId", "cityCode", "pageViews", "VisitStatHash", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "YmClientHash", "UtmHashHash", "AppMetricaDeviceHash", "CrmUserHash", "__id", "__datetime", "qid", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "UtmHashRegistryHash", "AppProfileMatchingHash")
  -- depends_on: test.graph_qid
-- depends_on: test.link_registry_appprofilematching
-- depends_on: test.link_registry_utmhashregistry

WITH t0 AS (
SELECT * FROM test.link_events
LEFT JOIN test.graph_qid USING (__id, __link, __datetime)
)
, t1 AS ( 
SELECT t0.*, link_registry_utmhashregistry.*EXCEPT(__emitted_at, __table_name, __id, __datetime, __link) 
FROM t0 
LEFT JOIN link_registry_utmhashregistry USING (UtmHashHash) 
)
, t2 AS ( 
SELECT t1.*, link_registry_appprofilematching.*EXCEPT(__emitted_at, __table_name, __id, __datetime, __link) 
FROM t1 
LEFT JOIN link_registry_appprofilematching USING (AppMetricaDeviceHash,CrmUserHash) 
) 
SELECT COLUMNS('^[^.]+$') FROM t2 

  