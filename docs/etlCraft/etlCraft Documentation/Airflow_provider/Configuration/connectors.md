Описание: Коннекторы (докер-образы), которые нужно подключить в Airbyte
Тип по умолчанию: templated_file
Формат по умолчанию: yaml

# Описание

Словарь состоит из двух частей: `source_definitions` и `destination_definitions`. В обоих разделах одинаковая структура:

- `slug`  — идентификатор коннектора, его сокращенное название, взятое из [[Configuration#Список конфигов]]
    
    [[Add slug validation check to connector creation DAG]]
    
- `image` — название Docker-образа на DockerHub
- `documentation`  — ссылка на этот Notion (раздел “[[Configuration#Список конфигов]]”), где даны инструкции, как подключить коннектор в Aibyte

[[Заменить в конфиге connectors name на slug]]

# Пример

```yaml
source_definitions:
  - name: sheets
    image: adventum/source-google-sheets:1.0.0
    documentation: example.com
  - name: ydisk
    image: adventum/source-yandex-disk:0.2.0
    documentation: example.com
destination_definitions:
  - name: clickhouse
    image: airbyte/destination-clickhouse:1.0.0
    documentation: example.com
```