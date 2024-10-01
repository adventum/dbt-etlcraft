---
description: "Информация о модели данных: список сущностей с атрибутами и связи между ними"
config_default_type: "`templated_file`"
config_default_format: "`yaml`"
type: config
doc_status: in progress
---
# Описание


Эти данные добавляются в проект с помощью DAG’а [[template_configs]].
# Пример
```
entities:
  Account:
    keys:
    - name: accountName
  Product:
    keys:
    - name: productName
  AdSource:
    keys:
    - name: adSourceDirty  
  UtmParams:
    keys:
    - name: utmSource
    - name: utmMedium
    - name: utmCampaign
    - name: utmTerm
    - name: utmContent    
  UtmHash:
    keys:
    - name: utmHash
  AdPhrase:
    keys:
    - name: adPhraseId
  AdCampaign:
    keys:
    - name: adCampaignName
  AdGroup:
    keys:
    - name: adGroupName
  Ad:
    keys:
    - name: adId    
  YmClient:
    glue: yes
    keys:
    - name: clientId
  CrmUser:
    glue: yes
    keys:
    - name: crmUserId
  PromoCode:
    keys:
    - name: promoCode
  City:
    keys:
    - name: cityName
  MobileAdsId:
    keys:
    - name: mobileAdsId
  OsName:
    keys:
    - name: osName
  Visit:
    keys:
    - name: visitId
  Transaction:
    keys:
    - name: transactionId  
  PeriodStart:
    keys:
    - name: periodStart
  PeriodEnd:
    keys:
    - name: periodEnd
  AppMetricaDevice:
    glue: yes
    keys:
    - name: appmetricaDeviceId
  AppMetricaDeviceId:
    keys:
    - name: appmetricaDeviceId
  AppSession:
    keys:
    - name: installationDeviceId
links:
  ManualAdCostStat:
    pipeline: periodstat
    keys:
    - name: periodStart
    main_entities:
    - PeriodStart
    - PeriodEnd  
  UtmHashRegistry:
    pipeline: registry
    keys:
    main_entities:
    - UtmHash
  AdCostStat:
    pipeline: datestat
    datetime_field: __date
    keys:
    - name: __date
    - name: reportType
    main_entities:
    - Account
    - AdSource
    - AdCampaign
    - AdGroup
    - Ad
    - AdPhrase  
    - UtmParams
    - UtmHash
  MediaplanStat:
    datetime_field: planCostDate
    keys:
    - name: planCostDate
    main_entities:
    - Account
    - Product
    - CityCode
    - AdSource
    - UtmParams
  VisitStat:
    pipeline: events
    datetime_field: __date
    keys:
    - name: __date
    main_entities:
    - Visit
    other_entities:
    - Account
    - YmClient
    - PromoCode
    - OsName
    - City
    - AdSource
    - UtmParams  
    - UtmHash
  AppInstallStat:
    pipeline: events
    datetime_field: event_datetime
    keys:
    - name: event_datetime
    main_entities:
    - Account
    - AppMetricaDevice
    - MobileAdsId
    - CrmUser
    - OsName
    - City
    - AdSource
    - UtmParams
    - UtmHash
  AppEventStat:
    pipeline: events
    datetime_field: event_datetime
    keys:
    - name: event_datetime
    main_entities:
    - Account
    - AppMetricaDevice
    - MobileAdsId
    - CrmUser
    - Transaction
    - PromoCode
    - OsName
    - City
  AppSessionStat:
    pipeline: events
    datetime_field: event_datetime
    keys:
    - name: event_datetime
    main_entities:
    - Account
    - AppSession
    - AppMetricaDevice
    - MobileAdsId
    - CrmUser
    - OsName
    - City
  AppDeeplinkStat:
    pipeline: events
    datetime_field: event_datetime
    keys:
    - name: event_datetime
    main_entities:
    - Account
    - AppMetricaDevice
    - MobileAdsId
    - CrmUser
    - OsName
    - City
    - AdSource
    - UtmParams  
    - UtmHash
  AppProfileMatching:
    pipeline: registry
    keys:
    main_entities:
    - AppMetricaDevice
    - CrmUser
glue_models:
  hash_events:
    datetime_field: __datetime
    cols:
    - CrmUserHash
    - YmClientHash
    - AppEventStatHash
    - AppMetricaDeviceHash  
  hash_registry_appprofilematching:
    datetime_field: toDateTime(0)
    cols:
    - AppProfileMatchingHash
    - AppMetricaDeviceHash
    - CrmUserHash
```