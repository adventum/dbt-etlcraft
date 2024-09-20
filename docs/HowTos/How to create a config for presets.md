---
description: Инструкция как сформировать файл конфига для пресетов
type: howtos
doc_status: in progress
---
[[Написать инструкцию, как сформировать конфиг для presets]]

## I Получаем данные о соединениях

#### 1. Заходим в Airbyte и выбираем нужное соединение (Connection)
#### ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfYR8cC5sohOe8GyaPFCBpqdcNZ0vsxyzk-O1W5lMf1tdkVUa-PHyQXebHdbI2LQSkz3YUlyCDpR0jt_uRyWNNiQa6vhzEP8aBBz4lUU7rJkIG2DVKyGsaFe8ky99e29tqutXHV_SwsHmtMVqlVkyds3nEL?key=WLrhqU9b79UJM2CtoA6d9A)

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXe2b_SRpcwH3HRO2XQvXdGwOXFjphM4Wa7hN8mC9j41iSwdUVRC36CtS1jZrGcGr7ci3GFCYS3BnESoVIiu0X8bLqGfeRw2Wr2xxrVnFzxwdW1_rjpFL44-vuUnE4cQ0VqPG2UFH6Zg1ONciYiBNzrTceSn?key=WLrhqU9b79UJM2CtoA6d9A)

  
#### 2. Теперь нужно открыть инструменты разработчика (Ctrl + Shift + J или F12 (или Fn + F12) для Google Chrome; Ctrl + Shift + I в Яндекс Браузере)
Слева на экране появится панель разработчика. Здесь нужно зайти в раздел “Сеть” (Network).

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXe-oEuBOOuItA23P_WLgV46Rw4fHw9fOJXQxofV6OShOk1dmJuh5CdqYKV3UU5bh4O8VyQ11FatA_JW1Y3zpSfdLp8ruFtPcFqFHoemcJC4iYSVDoEtzuesZ7nudjLb8ONGgyKu7fzyBQt3kELdQ6OgBRCj?key=WLrhqU9b79UJM2CtoA6d9A)

После того как зашли в раздел “Сеть” (Network) необходимо обновить страницу.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXc-ZqQPEb7Na9kodwzd2M0U3I0awPcw5RnjYqMKpuB3CcDFPBIvjMl2JjRKYGhtZ-16SzYKbpKihmUSgBg0V29rD5lOBD0G6eco20_8K9iPe46pR2UPKL4INZwF4UMjjgooIt7B0S2i8z5yiKiJlCk3qxV7?key=WLrhqU9b79UJM2CtoA6d9A)

⇩

Затем в ФИЛЬТР в панели разработчика вбиваем слово `get` и нажимаем `Enter`.

После этого в панели чуть ниже появится список. В нём нужно выбрать третий сверху “get” и в окошке справа от “get” выбрать раздел “Ответ”. В нём и будет находится нужный нам json с конфигурацией источника. Выделяем всё и копируем.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcmOdpIIxVLHu1AsPATpA5sX3GugygY4IM-dqeHjiqm5jNHJcHgz8S1cEZebvphK0_xcDjilOBmZWOY_3OUfY9UyUlPAqRztrC1i_nK4zXcQx8RqRrIQCDfqdL9CQYWHV3mdBzKiYNojHwkDr64O5GbznNL?key=WLrhqU9b79UJM2CtoA6d9A)

  

## II Как подготовить эти данные для [[presets|шаблона пресетов]]

#### 1. Данные, которые меняются от клиента/продукта к клиенту/продукту  необходимо заменить звёздочками (эти данные будут заполняться автоматически DAG-ом в Airflow) 

#task когда появится этот даг, дать на него ссылку

Список параметров, которые будут заполнятся автоматически, меняется от источника к источнику, но в целом это:

- id аккаунта / id клиента /  id счётчика / id приложений и т.д.
- пароли / токены / хосты  / id токена

Также заменяем на звёздочки "sourceDefinitionId", т.к. этот id будет генерироваться DAG-ом в Airflow. #task уточнить: так ли это до сих пор?
#### 2. Необходимо добавить для каждого уникального пресета:

-  раздел entities 
	Entities (сущности) - реальные бизнес-концепции, такие как клиенты, транзакции, продукты, рекламные кампании и т.д.. Подробнее о сущностях можно почитать [тут](https://github.com/adventum/dbt-etlcraft/wiki/4.-%D0%9E%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5-%D1%84%D0%B0%D0%B9%D0%BB%D0%B0-metadata.sql) или [[Entity|тут]]. Посмотреть список сущностей для источников можно [тут](https://docs.google.com/spreadsheets/d/17L2DaVe9fkugxNb99yqwg9e5r3wZ1ia7S_RBx3ZHh9A/edit?gid=928479100#gid=928479100).

#task добавить в документацию табличку соответствия сущностей и источников???
#task убрать все ссылки на wiki и таблички в шитсах, когда будут готовы соответствующие разделы в obsidian 

-  раздел links. 
	Подробнее о линках можно почитать [[Terms/Link|тут]].
	Посмотреть список линков можно посмотреть [тут](https://docs.google.com/spreadsheets/d/17L2DaVe9fkugxNb99yqwg9e5r3wZ1ia7S_RBx3ZHh9A/edit?gid=99744490#gid=99744490).

#task добавить список линков в [[Terms/Link|Link]]

#### 3. В каждый [[Stream|стрим]] нужно добавить к какому [[Pipeline|пайплайн]] он относится

Соответствие пайплайнов можно можно посмотреть [тут](https://docs.google.com/spreadsheets/d/17L2DaVe9fkugxNb99yqwg9e5r3wZ1ia7S_RBx3ZHh9A/edit?gid=1025378649#gid=1025378649).

#task добавить в документацию табличку с соответствием???

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