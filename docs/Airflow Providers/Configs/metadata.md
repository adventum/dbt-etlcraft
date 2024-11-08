---
description: "Информация о модели данных: список сущностей с атрибутами и связи между ними"
config_default_type: "`templated_file`"
config_default_format: "`yaml`"
type: config
doc_status: ready (нужно ревью)
---
# Описание

Конфиг `metadata` необходим для формирования формулы, по которой рассчитывается хэш (hash) - уникальный ключ, а также для проведения графовой склейки. Задействован на слоях hash, link и graph (подробнее [[ОБЗОР|dbt Package]]) и позволяет упростить sql-запросы и использовать макросы.

Конфиг содержит три раздела: 
1) `entities` - описание сущностей (подробнее [[Entity]])
2) `links` - описание линков (подробнее [[Terms/Link|Link]])
3) `glue_models` - описание данных, необходимых для проведения графовой склейки 

В пакете **dataCraft Core** в папке `templated_configs` содержится базовая версия данного конфига, при необходимости его можно кастомизировать. Для работы с конфигами типа `templated_file` (см. [[Airflow Providers/Configs#Типы конфигов|Типы конфигов]]) существует специальный DAG -  [[template_configs]]. 
# Пример
```yaml
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
  hash_events: # hash-таблица, которая участвует в склейке 
    datetime_field: __datetime # название основного поля дат в этой hash-таблице
    cols: # список колонок, необходимых для графовой склейки (колонки, с помощью которых можно идентифицировать пользователя)
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