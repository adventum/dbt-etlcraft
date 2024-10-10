---
description: Инструкция как сформировать файл конфига для пресетов
type: howtos
doc_status: ready (нужно ревью)
---
## I Получаем данные о соединениях

#### 1. Заходим в Airbyte и выбираем нужное соединение (Connection)

![[airbyte_creat_presets_instruction_step1.jpg]]

![[airbyte_creat_presets_instruction_step2.jpg]]

  
#### 2. Теперь нужно открыть инструменты разработчика (Ctrl + Shift + J или F12 (или Fn + F12) для Google Chrome; Ctrl + Shift + I в Яндекс Браузере)
Слева на экране появится панель разработчика. Здесь нужно зайти в раздел “Сеть” (Network).
![[airbyte_creat_presets_instruction_step3.jpg]]

После того как зашли в раздел “Сеть” (Network) необходимо обновить страницу.
![[airbyte_creat_presets_instruction_step4.jpg]]

Затем в ФИЛЬТР в панели разработчика вбиваем слово `get` и нажимаем `Enter`.

После этого в панели чуть ниже появится список. В нём нужно выбрать третий сверху “get” и в окошке справа от “get” выбрать раздел “Ответ”. В нём и будет находится нужный нам json с конфигурацией соединения. Выделяем всё и копируем.
![[airbyte_creat_presets_instruction_step5.jpg]]


## II Как подготовить эти данные для [[presets|шаблона пресетов]]

#### 1. Данные, которые меняются от клиента/продукта к клиенту/продукту  необходимо заменить звёздочками (эти данные будут заполняться автоматически DAG-ом в Airflow) 

За создание [[Airbyte Connection]] отвечает DAG [[create_connections]].

Список параметров, которые будут заполнятся автоматически, меняется от источника к источнику, но в целом это:

- id аккаунта / id клиента /  id счётчика / id приложений и т.д.
- пароли / токены / хосты  / id токена

То есть вся конфиденциальная информация.

Также заменяем на звёздочки "sourceDefinitionId", т.к. этот id будет генерироваться DAG-ом в Airflow. 
#### 2. Необходимо добавить для каждого уникального пресета:

-  раздел entities 
	Entities (сущности) - реальные бизнес-концепции, такие как клиенты, транзакции, продукты, рекламные кампании и т.д.. Подробнее о сущностях можно почитать [[Entity|тут]]. 

#task добавить в документацию табличку соответствия сущностей и источников??? - Ответ: по каждому источнику будет документация, туда можно добавить сущности, потом можно будет отследить, собрав в табличку   

-  раздел links
	Link - набор данных c определенным набором колонок.
	Подробнее о линках можно почитать [[Terms/Link|тут]].

#### 3. В каждый [[Stream|стрим]] нужно добавить к какому [[Pipeline|пайплайну]] он относится

**Пример пресета с добавлением разделов `entities`, `links` и `pipeline`:**
```
{   
<...>

"source_presets": {
    "appmetrica_default":
    {
        "connectionId": "*****",
        "name": "appmetrica_default_ → default",
        "namespaceDefinition": "destination",
        "namespaceFormat": "${SOURCE_NAMESPACE}",
        "prefix": "appmetrica_default_",
        "sourceId": "******",
        "destinationId": "*****",
        "entities": ["Account", #ТУТ ПРИВОДИМ СПИСОК СУЩНОСТЕЙ
            "AdSource",
            "UtmParams",
            "UtmHash",
            "CrmUser",
            "PromoCode",
            "City",
            "MobileAdsId",
            "OsName",
            "Transaction",
            "AppMetricaDevice",
            "AppMetricaDeviceId",
            "AppSession"],

        "links": ["AppEventStat", #ТУТ ПРИВОДИМ СПИСОК ЛИНКОВ
            "AppDeeplinkStat",
            "AppProfileMatching",
            "AppInstallStat"],        
        "syncCatalog": {
            "streams": [
                {
                    "stream": {
                        "name": "events",
                        "pipeline": "events", #ТУТ УКАЗЫВАЕМ НАЗВАНИЕ ПАЙПЛАЙНА
                        "jsonSchema": {
                            "$schema": "http://json-schema.org/draft-07/schema#",
                            "type": "object",
                            "properties": {
                                "google_aid": {
                                    "type": [
                                        "null",
                                        "string"
                                    ]
                                },
<...>
}
```

#### 4. Опционально, при наличии, в шаблон пресетов можно добавить раздел `directintegration_presets`

Этот раздел содержит сведения о [[Direct integration|прямых интеграциях]].

**Пример раздела:**
```
{   "directintegration_presets": {
    "example1": {
        "scheme": "название схем в кликхаусе",
        "table": "название таблицы",
        "fields": ["field1", "field2", "field3"],
        "entities": ["entity1", "entity2"]
    }      
        },
 <...>
```