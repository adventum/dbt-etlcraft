

  create view test.link_events__dbt_tmp 
  
  as (
    -- depends_on: test.hash_events


SELECT _dbt_source_relation,None,__date,__table_name,event_datetime,accountName,appmetricaDeviceId,mobileAdsId,crmUserId,visitId,clientId,promoCode,osName,cityName,adSourceDirty,utmSource,utmMedium,utmCampaign,utmTerm,utmContent,transactionId,utmHash,SUM(sessions) AS sessions,SUM(addToCartSessions) AS addToCartSessions,SUM(cartViewSessions) AS cartViewSessions,SUM(checkoutSessions) AS checkoutSessions,SUM(webSalesSessions) AS webSalesSessions,SUM(sales) AS sales,SUM(amountSales) AS amountSales,SUM(registrationCardSessions) AS registrationCardSessions,SUM(registrationButtonClick) AS registrationButtonClick,SUM(linkingCardToPhoneNumberSessions) AS linkingCardToPhoneNumberSessions,SUM(registrationLendingPromotionsSessions) AS registrationLendingPromotionsSessions,SUM(registrationCashbackSessions) AS registrationCashbackSessions,SUM(instantDiscountActivationSessions) AS instantDiscountActivationSessions,SUM(couponActivationSessions) AS couponActivationSessions,SUM(participationInLotterySessions) AS participationInLotterySessions,SUM(pagesViews) AS pagesViews,SUM(screenView) AS screenView,SUM(installApp) AS installApp,SUM(installs) AS installs,installationDeviceId,__emitted_at,__link,cityCode,SUM(pageViews) AS pageViews,AppInstallStatHash,AppEventStatHash,AppSessionStatHash,AppDeeplinkStatHash,VisitStatHash,AppMetricaDeviceHash,CrmUserHash,YmClientHash,__id,__datetime 
FROM test.hash_events
GROUP BY _dbt_source_relation, None, __date, __table_name, event_datetime, accountName, appmetricaDeviceId, mobileAdsId, crmUserId, visitId, clientId, promoCode, osName, cityName, adSourceDirty, utmSource, utmMedium, utmCampaign, utmTerm, utmContent, transactionId, utmHash, installationDeviceId, __emitted_at, __link, cityCode, AppInstallStatHash, AppEventStatHash, AppSessionStatHash, AppDeeplinkStatHash, VisitStatHash, AppMetricaDeviceHash, CrmUserHash, YmClientHash, __id, __datetime



  )