
  
    
    
        
        insert into test.attr_myfirstfunnel_final_table__dbt_backup ("__period_number", "__if_missed", "__priority", "__step", "qid", "__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "visitId", "clientId", "cityCode", "pageViews", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "VisitStatHash", "AppMetricaDeviceHash", "CrmUserHash", "UtmHashHash", "YmClientHash", "__id", "__datetime", "link_registry_utmhashregistry.utmHash", "utm_base_url", "utm_utmSource", "utm_utmMedium", "utm_utmCampaign", "utm_project", "utm_utmContent", "utm_strategy", "utm_audience", "link_registry_utmhashregistry.__emitted_at", "link_registry_utmhashregistry.__table_name", "link_registry_utmhashregistry.__link", "UtmHashRegistryHash", "link_registry_utmhashregistry.__id", "link_registry_utmhashregistry.__datetime", "link_registry_appprofilematching.appmetricaDeviceId", "link_registry_appprofilematching.crmUserId", "link_registry_appprofilematching.cityName", "link_registry_appprofilematching.__emitted_at", "link_registry_appprofilematching.__table_name", "link_registry_appprofilematching.__link", "AppProfileMatchingHash", "link_registry_appprofilematching.__id", "link_registry_appprofilematching.__datetime", "__last_click_rank", "__first_click_rank", "adSourceDirty", "__myfirstfunnel_last_click_utmSource", "__myfirstfunnel_last_click_utmMedium", "__myfirstfunnel_last_click_utmCampaign", "__myfirstfunnel_last_click_utmTerm", "__myfirstfunnel_last_click_utmContent", "__myfirstfunnel_last_click_adSourceDirty", "__myfirstfunnel_first_click_utmSource", "__myfirstfunnel_first_click_utmMedium", "__myfirstfunnel_first_click_utmCampaign", "__myfirstfunnel_first_click_utmTerm", "__myfirstfunnel_first_click_utmContent", "__myfirstfunnel_first_click_adSourceDirty")
  -- depends_on: test.attr_myfirstfunnel_model




with 
    out as ( 
        select * except(_dbt_source_relation) 
        from  test.attr_myfirstfunnel_join_to_attr_prepare_with_qid
        join  test.attr_myfirstfunnel_model
            using (qid, __datetime, __id, __link, __period_number, __if_missed, __priority)
    )
    
select * from out



  