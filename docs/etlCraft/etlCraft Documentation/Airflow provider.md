
# Обзор

Провайдер `airflow-etlcraft-provider` — это пакет для Apache Airflow. предназначен позволяет провести все операции по обработке данных без написания кода. В то же время, он позволяет использовать свои отдельные блоки для написания собственных DAG’ов.

# Структура

Провайдер содержит:

[Operators for Airbyte work](Operators%20for%20Airbyte%20work.md)

- функции для сбора конфигурации
- конструктор DAG’ов, позволяющий решить следующие задачи:
    - установить в Airbyte необходимые коннекторы
    - настроить sources, destinations, и connections в Airbyte на основе конфигурации YAML
    - создание модели dbt по умолчанию
    - запускать обновление данных через Airbyte за нужные даты
    - запускать обработку через dbt

[Configuration](Configuration.md)

[Description of DAGs](Description%20of%20DAGs.md)

[How DAGs work](How%20DAGs%20work.md)

Интеграция с dataCraft

# Установка

В среде с установленным Airflow выполнить:

```bash
pip install airflow-etlcraft-provider
```

В DAG’ах сделать:

```python
from airflow-etlcraft-provider import XXXXXXXXXXXXXXXXX
```

[https://adventum.kaiten.ru/space/339647/card/32596925](https://adventum.kaiten.ru/space/339647/card/32596925)