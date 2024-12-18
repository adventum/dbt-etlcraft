---
term_name: Airbyte Source
description: сущности внутри Airbyte, которые можно создать вручную или по API
type: term
doc_status: ready (нужно ревью)
---
В Airbyte под источником понимается исходная система, из которой данные извлекаются для последующей передачи в целевое хранилище ([[Airbyte Destination]]). 

Airbyte поддерживает взаимодействие с довольно большой спектром различных источников. Источники могут быть различными типами баз данных, файловых хранилищ или API-сервисов. 

В Airbyte, чтобы получить данные из определённого источника, необходимо настроить к нему подключение. Подключение осуществляется через специальные [[Airbyte Connector|коннекторы]]. Можно выбрать как среди стандартных коннекторов Airbyte, так и использовать собственные. А также можно воспользоваться коннекторами из раздела Marketplace, которые поддерживаются сообществом Airbyte.

![[airbyte_new_source_example_1.jpg]]

После выбора коннектора, для каждого источника необходимо настроить параметры подключения. Они зависят от коннектора, но в большинстве случаев параметры подключения предоставляет собой информацию для аутентификации (имя пользователя и пароль, ключ API) и информацию о том, какие данные следует извлечь, например, перечень полей которые нужно выгрузить, период за который нужно выгрузить данные или дату с которой нужно предоставить данные и так далее. Airbyte может извлекать данные как в табличной (структурированной) форме, так и в виде плоских файлов или API-запросов.

Пример параметров, которые нужно заполнить при подключении данных из Google Sheets:

![[airbyte_new_source_example_2.jpg]]

В **dataCraft Core** создание новых и обновление существующих источников в Airbyte автоматизировано и осуществляется DAG’ом [[create_connections]].


### Наименование Airbyte Source

Для наименования источников данных в **dataCraft Core** существуют определённая схема:
`{название источника}_{название шаблона}_`
* указываем [[Source|краткое название источника данных]] 
* под названием шаблона подразумевается организация набора данных ([[Template|подробнее]]). Если организация стандартная, то шаблон называется `default`.

**Пример**
![[airbyte_source_name_example.jpg]]
