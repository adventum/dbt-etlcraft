---
description: Коннекторы (докер-образы), которые нужно подключить в Airbyte
config_default_type: "`templated_file`"
config_default_format: "`yaml`"
type: config
doc_status: ready (нужно ревью)
---
# Описание

Словарь состоит из двух частей: 
- `source_definitions`  - определение коннекторов для источников данных
- и `destination_definitions` - определение коннекторов для мест назначения. 

В обоих разделах одинаковая структура:

- `slug`  — идентификатор, 
	- соответствующий краткому названию источника данных для `source_definitions`, взятое из [[Connectors]] 
	- и для `destination_definitions` соответствующий названию базы данных, куда коннектором будут выгружаться данные
    
    [[Add slug validation check to connector creation DAG]]
    
- `image` — название Docker-образа на DockerHub
- `documentation`  — ссылка на раздел “[[Connectors]]”, где даны инструкции, как подключить коннектор в Aibyte

Данные из этого конфига используются для добавления в Airbyte нужных коннекторов. Это осуществляется с помощью DAG’a [[install_connectors]].

[[Заменить в конфиге connectors name на slug]]

# Пример

```yaml
source_definitions:
  - slug: sheets
    image: adventum/source-google-sheets:1.0.0
    documentation: example.com
  - slug: ydisk
    image: adventum/source-yandex-disk:0.2.0
    documentation: example.com
destination_definitions:
  - slug: clickhouse
    image: airbyte/destination-clickhouse:1.0.0
    documentation: example.com
```