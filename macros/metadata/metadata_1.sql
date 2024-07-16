{%- macro metadata_1(features) -%}

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
{% if 'appmetrica' in features %}
  AppMetricaDevice:
    glue: yes
    keys:
    - name: appmetricaDeviceId
  AppMetricaDeviceId:
    keys:
    - name: appmetricaDeviceId
  AppSession:
    keys:
    {# - name: appSessionId #}
    - name: installationDeviceId
{% endif %}
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
    {# datetime_field: toDateTime(0) #}
    keys:
    {# - name: toDateTime(0) #}
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
    datetime_field: __date {# с event_datetime без appmetrica выдает ошибку #}
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
{% if 'appmetrica' in features %}
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
    {# datetime_field: toDateTime(0) #}
    keys:
    {# - name: toDateTime(0) #}
    main_entities: 
    - AppMetricaDevice
    - CrmUser
{% endif %}

glue_models:
  hash_events:
    datetime_field: __datetime
    cols:
    - CrmUserHash
    - YmClientHash
{% if 'appmetrica' in features %} 
    - AppEventStatHash
    - AppMetricaDeviceHash   
  hash_registry_appprofilematching:
    datetime_field: toDateTime(0)
    cols:
    - AppProfileMatchingHash
    - AppMetricaDeviceHash
    - CrmUserHash
{% endif %}

steps:
  visits_step:
      - link: VisitStat
        datetime_field: __datetime
        condition: osName = 'web'
        period: 90
        if_missed: '[Без веб сессии]'
  install_step:
      - link: AppInstallStat
        datetime_field: __datetime
        condition: installs >= 1
        period: 30
        if_missed: '[Без установки]'
  app_visits_step:
      - link: AppSessionStat
        datetime_field: __datetime
        condition: sessions >= 1
        period: 30
        if_missed: '[Без апп сессии]'
      - link: AppDeeplinkStat
        datetime_field: __datetime
        period: 30
        if_missed: '[Без апп сессии]'
  event_step:
      - link: AppEventStat
        datetime_field: __datetime
        condition: screenView >= 1
        period: 7
attribution_models:
  my_first_model:
    type: last_click
    priorities: 
    - LENGTH (adSourceDirty) < 2
    - match(adSourceDirty, 'Органическая установка')
    - __priority = 4 and not __if_missed = 1
    - __priority = 3 and not __if_missed = 1
    - __priority = 2 and not __if_missed = 1
    - __priority = 1 and not __if_missed = 1
    fields:
    - utmSource
    - utmMedium
    - utmCampaign
    - utmTerm
    - utmContent
    - adSourceDirty
  my_second_model:
    type: first_click
    priorities: 
    - __priority = 3 and not __if_missed = 1
    - __priority = 2 and not __if_missed = 1
    - __priority = 1 and not __if_missed = 1
    fields:
    - utmSource
    - utmMedium
    - utmCampaign
    - utmTerm
    - utmContent
    - adSourceDirty
  my_third_model:
    type: first_click
    priorities: 
    - __priority = 3 and not __if_missed = 1
    - __priority = 2 and not __if_missed = 1
    - __priority = 1 and not __if_missed = 1
    fields:
    - utmSource
    - utmMedium
    - utmCampaign
    - utmTerm
    - utmContent
    - adSourceDirty
funnels:
  myfirstfunnel:
    steps:
    - visits_step
    - install_step
    - app_visits_step
    - event_step
    models:
    - my_first_model
    - my_second_model
  mysecondfunnel:
    steps:
    - install_step
    - app_visits_step
    - event_step
    models:
    - my_first_model
datasets:
  event_table:
    pipelines: events
    sources:
{% if 'appmetrica' in features %} 
    - appmetrica
{% endif %}
    - ym
    preset: default
    accounts:
    - testaccount
    funnel: myfirstfunnel
  cost_table:
    pipelines: datestat
    sources:
{% if 'appmetrica' in features %} 
    - appmetrica
{% endif %}
    - ym
    preset: default
    accounts:
    - testaccount
{%- endmacro -%}