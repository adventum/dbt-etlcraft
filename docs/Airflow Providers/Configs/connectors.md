---
description: Коннекторы (докер-образы), которые нужно подключить в Airbyte
config_default_type: "`templated_file`"
config_default_format: "`yaml`"
type: config
doc_status: in progress
---

# Описание

Словарь состоит из двух частей: `source_definitions` (откуда коннектор будет получать данные) и `destination_definitions` (куда коннектор будет выгружать данные). В обоих разделах одинаковая структура:

- `slug`  — идентификатор, 
	- соответствующий краткому названию источника данных для `source_definitions`, взятое из [[Configs#Список конфигов]] #task тут непонятно почему на список конфигов ссылка, нужно же на список кратких названий источников???? , 
	- и для `destination_definitions` соответствующий названию базы данных, куда коннектором будут выгружаться данные
    
    [[Add slug validation check to connector creation DAG]]
    
- `image` — название Docker-образа на DockerHub для `source_definitions` и название места назначения для `destination_definitions` #task уточнить определение
- `documentation`  — ссылка на этот Notion (раздел “[[Configs#Список конфигов]]”), где даны инструкции, как подключить коннектор в Aibyte #task непонятно почему именно на этот раздел, уточнить! 


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