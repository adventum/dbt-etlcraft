
  
    
    
        
        insert into test.full_events__dbt_backup ("__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "adSourceDirty", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "visitId", "clientId", "cityCode", "pageViews", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "VisitStatHash", "AppMetricaDeviceHash", "CrmUserHash", "UtmHashHash", "YmClientHash", "__id", "__datetime", "qid", "link_registry_utmhashregistry.utmHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "link_registry_utmhashregistry.__emitted_at", "link_registry_utmhashregistry.__table_name", "link_registry_utmhashregistry.__link", "UtmHashRegistryHash", "link_registry_utmhashregistry.__id", "link_registry_utmhashregistry.__datetime", "link_registry_appprofilematching.appmetricaDeviceId", "link_registry_appprofilematching.crmUserId", "link_registry_appprofilematching.cityName", "link_registry_appprofilematching.__emitted_at", "link_registry_appprofilematching.__table_name", "link_registry_appprofilematching.__link", "AppProfileMatchingHash", "link_registry_appprofilematching.__id", "link_registry_appprofilematching.__datetime")
  -- depends_on: test.graph_qid
-- depends_on: test.link_registry_appprofilematching
-- depends_on: test.link_registry_utmhashregistry

WITH t0 AS (
SELECT * FROM test.link_events
LEFT JOIN test.graph_qid USING (__id, __link, __datetime)
)
, t1 AS ( 
SELECT * FROM t0
LEFT JOIN link_registry_utmhashregistry USING (UtmHashHash) 
)
, t2 AS ( 
SELECT * FROM t1
LEFT JOIN link_registry_appprofilematching USING (AppMetricaDeviceHash,CrmUserHash) 
) 
SELECT * FROM t2 





  