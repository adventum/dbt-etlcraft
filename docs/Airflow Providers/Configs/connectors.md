---
description: Коннекторы (докер-образы), которые нужно подключить в Airbyte
config_default_type: "`templated_file`"
config_default_format: "`yaml`"
type: config
doc_status: in progress
---

# Описание

Словарь состоит из двух частей: `source_definitions` (определение коннектора источника данных ) и `destination_definitions` (определение коннектора для места назначения). В обоих разделах одинаковая структура:

- `slug`  — идентификатор, 
	- соответствующий краткому названию источника данных для `source_definitions`, взятое из [[Connectors]] 
	- и для `destination_definitions` соответствующий названию базы данных, куда коннектором будут выгружаться данные
    
    [[Add slug validation check to connector creation DAG]]
    
- `image` — название Docker-образа на DockerHub для `source_definitions` и название места назначения для `destination_definitions` #task уточнить определение
- `documentation`  — ссылка на раздел “[[Connectors]]”, где даны инструкции, как подключить коннектор в Aibyte #task будет внутри ссылка на документацию по каждому коннектору (пока нет этой документации)


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