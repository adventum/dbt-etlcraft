-- depends_on: test.hash_events
SELECT __date,__table_name,event_datetime,accountName,appmetricaDeviceId,mobileAdsId,crmUserId,visitId,clientId,promoCode,osName,cityName,adSourceDirty,utmSource,utmMedium,utmCampaign,utmTerm,utmContent,transactionId,utmHash,sessions,addToCartSessions,cartViewSessions,checkoutSessions,webSalesSessions,sales,amountSales,registrationCardSessions,registrationButtonClick,linkingCardToPhoneNumberSessions,registrationLendingPromotionsSessions,registrationCashbackSessions,instantDiscountActivationSessions,couponActivationSessions,participationInLotterySessions,pagesViews,screenView,installApp,installs,installationDeviceId,__emitted_at,__link,cityCode,pageViews,AppInstallStatHash,AppEventStatHash,AppSessionStatHash,AppDeeplinkStatHash,VisitStatHash,AppMetricaDeviceHash,CrmUserHash,UtmHashHash,YmClientHash,__id,__datetime 
FROM test.hash_events
GROUP BY __date, __table_name, event_datetime, accountName, appmetricaDeviceId, mobileAdsId, crmUserId, visitId, clientId, promoCode, osName, cityName, adSourceDirty, utmSource, utmMedium, utmCampaign, utmTerm, utmContent, transactionId, utmHash, sessions, addToCartSessions, cartViewSessions, checkoutSessions, webSalesSessions, sales, amountSales, registrationCardSessions, registrationButtonClick, linkingCardToPhoneNumberSessions, registrationLendingPromotionsSessions, registrationCashbackSessions, instantDiscountActivationSessions, couponActivationSessions, participationInLotterySessions, pagesViews, screenView, installApp, installs, installationDeviceId, __emitted_at, __link, cityCode, pageViews, AppInstallStatHash, AppEventStatHash, AppSessionStatHash, AppDeeplinkStatHash, VisitStatHash, AppMetricaDeviceHash, CrmUserHash, UtmHashHash, YmClientHash, __id, __datetime

