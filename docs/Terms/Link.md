---
term_name: Линк
description: " Набор данных c определенным набором колонок"
type: term
doc_status: ready (нужно ревью)
---
**Линк** - набор данных c определенным набором колонок. Один линк отличается от другого колонками (полями), которые в него входят.

Каждый линк описывается в [[metadata]]. Пример описания линков:
```
links: # словарь линков
  AdCostStat: # название линка. В данном случае набор данных со статистикой по расходам рекламных кампаний
    pipeline: datestat # пайплайн, к которому относится линк
    keys: # собственные уникальные атрибуты для линка (например, все значения для сущностей этого линка могут быть одинаковые, но относится к разным датам, без указания даты эти данные считались бы дублями, но это не так)
    - name: __date 
    - name: reportType
    main_entities: # основные сущности, относящиеся к линку AdCostStat
    - Account
    - AdSource 
    - AdCampaign 
    - AdGroup 
    - Ad 
    - AdPhrase  
    - UtmParams 
    - UtmHash
  AppInstallStat: # название линка (статистика по установкам приложения)
    pipeline: events # пайплан, к которому относится линк
    keys: # уникальные ключи
    - name: event_datetime
    main_entities: # основные сущности, относящиеся к линку AppInstallStat
    - Account
    - AppMetricaDevice
    - MobileAdsId
    - CrmUser
    - OsName
    - City
    - AdSource
    - UtmParams 
    - UtmHash
<...>
  VisitStat: # название линка (статистика по визитам)
    pipeline: events # пайплайн, к которому относится линк
    keys: # собственные уникальные атрибуты для линка
    - name: event_datetime
    main_entities: # основные сущности, относящиеся к линку
    - Visit
    other_entities: # остальные сущности, относящиеся к линку
    - Account 
    - YmClient
    - PromoCode
    - OsName
    - City
    - AdSource
    - UtmParams  
    - UtmHash
<...>
```
Каждому линку обязательно соответствует одна или несколько основных сущностей (`main_entities`) и, в некоторых случаях также несколько дополнительных (`other_entities`). Основные линки, задействованные в [[metadata]]:
- ManualAdCostStat 
- UtmHashRegistry 
- AdCostStat 
- MediaplanStat 
- VisitStat 
- AppInstallStat 
- AppEventStat

На основе этих данных, с помощью макроса [[link_hash]], формируется хэш-поле линка (`link`). Оно необходимо для проведения дедупликации данных на этапе link с помощью макроса [[dbt Package/link|link]] (подробнее см. [[dbt Package]]).

