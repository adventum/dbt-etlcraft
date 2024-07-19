
        
  
    
    
        
        insert into test.hash_events__dbt_new_data_087659a2_aa28_455d_8cec_34f515445ad6 ("__date", "__table_name", "event_datetime", "accountName", "appmetricaDeviceId", "mobileAdsId", "crmUserId", "promoCode", "osName", "cityName", "adSourceDirty", "utmSource", "utmMedium", "utmCampaign", "utmTerm", "utmContent", "transactionId", "utmHash", "sessions", "addToCartSessions", "cartViewSessions", "checkoutSessions", "webSalesSessions", "sales", "amountSales", "registrationCardSessions", "registrationButtonClick", "linkingCardToPhoneNumberSessions", "registrationLendingPromotionsSessions", "registrationCashbackSessions", "instantDiscountActivationSessions", "couponActivationSessions", "participationInLotterySessions", "pagesViews", "screenView", "installApp", "installs", "installationDeviceId", "__emitted_at", "__link", "touch_type", "touch_time", "install_time", "event_time", "event_name", "event_source", "partner", "media_source", "campaign", "site_id", "ad", "country_code", "city", "appsflyer_id", "custom_uid", "platform", "is_retargeting", "is_primary_attribution", "visitId", "clientId", "cityCode", "pageViews", "VisitStatHash", "AppInstallStatHash", "AppEventStatHash", "AppSessionStatHash", "AppDeeplinkStatHash", "YmClientHash", "UtmHashHash", "AppMetricaDeviceHash", "CrmUserHash", "__id", "__datetime")
  -- depends_on: test.combine_events
SELECT *,
  assumeNotNull(CASE  
    WHEN __link = 'VisitStat' 
    THEN VisitStatHash 
  
    WHEN __link = 'AppInstallStat' 
    THEN AppInstallStatHash 
  
    WHEN __link = 'AppEventStat' 
    THEN AppEventStatHash 
  
    WHEN __link = 'AppSessionStat' 
    THEN AppSessionStatHash 
  
    WHEN __link = 'AppDeeplinkStat' 
    THEN AppDeeplinkStatHash 

    END) as __id
  , assumeNotNull(CASE
    WHEN __link = 'VisitStat' 
    
    THEN toDateTime(__date) 
    
    WHEN __link = 'AppInstallStat' 
    
    THEN toDateTime(event_datetime) 
    
    WHEN __link = 'AppEventStat' 
    
    THEN toDateTime(event_datetime) 
    
    WHEN __link = 'AppSessionStat' 
    
    THEN toDateTime(event_datetime) 
    
    WHEN __link = 'AppDeeplinkStat' 
    
    THEN toDateTime(event_datetime) 
    END) AS __datetime
FROM (

SELECT *, 
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(__date))), ''), '') || ifnull(nullif(upper(trim(toString(visitId))), ''), '') || ifnull(nullif(upper(trim(toString(__date))), ''), '') = '', null, hex(MD5('VisitStat' || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(visitId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '')))))) as VisitStatHash,
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(__date))), ''), '') || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ifnull(nullif(upper(trim(toString(adSourceDirty))), ''), '') || ifnull(nullif(upper(trim(toString(utmSource))), ''), '') || ifnull(nullif(upper(trim(toString(utmMedium))), ''), '') || ifnull(nullif(upper(trim(toString(utmCampaign))), ''), '') || ifnull(nullif(upper(trim(toString(utmTerm))), ''), '') || ifnull(nullif(upper(trim(toString(utmContent))), ''), '') || ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '') = '', null, hex(MD5('AppInstallStat' || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(adSourceDirty))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmSource))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmMedium))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmCampaign))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmTerm))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmContent))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '')))))) as AppInstallStatHash,
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(__date))), ''), '') || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ifnull(nullif(upper(trim(toString(transactionId))), ''), '') || ifnull(nullif(upper(trim(toString(promoCode))), ''), '') || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '') = '', null, hex(MD5('AppEventStat' || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(transactionId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(promoCode))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '')))))) as AppEventStatHash,
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(__date))), ''), '') || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ifnull(nullif(upper(trim(toString(installationDeviceId))), ''), '') || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '') = '', null, hex(MD5('AppSessionStat' || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(installationDeviceId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '')))))) as AppSessionStatHash,
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(__date))), ''), '') || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ifnull(nullif(upper(trim(toString(adSourceDirty))), ''), '') || ifnull(nullif(upper(trim(toString(utmSource))), ''), '') || ifnull(nullif(upper(trim(toString(utmMedium))), ''), '') || ifnull(nullif(upper(trim(toString(utmCampaign))), ''), '') || ifnull(nullif(upper(trim(toString(utmTerm))), ''), '') || ifnull(nullif(upper(trim(toString(utmContent))), ''), '') || ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '') = '', null, hex(MD5('AppDeeplinkStat' || ';' || ifnull(nullif(upper(trim(toString(__date))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(accountName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(mobileAdsId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(osName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(cityName))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(adSourceDirty))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmSource))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmMedium))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmCampaign))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmTerm))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmContent))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(utmHash))), ''), '') || ';' || ifnull(nullif(upper(trim(toString(event_datetime))), ''), '')))))) as AppDeeplinkStatHash

,
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(clientId))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(clientId))), ''), '')))))) as YmClientHash

,
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(utmHash))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(utmHash))), ''), '')))))) as UtmHashHash

,
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(appmetricaDeviceId))), ''), '')))))) as AppMetricaDeviceHash

,
assumeNotNull(coalesce(if(ifnull(nullif(upper(trim(toString(crmUserId))), ''), '') = '', null, hex(MD5(ifnull(nullif(upper(trim(toString(crmUserId))), ''), '')))))) as CrmUserHash


FROM test.combine_events 
WHERE 

    True AND 
    True AND 
    True AND 
    True AND 
    True
)
-- SETTINGS short_circuit_function_evaluation=force_enable


  
      