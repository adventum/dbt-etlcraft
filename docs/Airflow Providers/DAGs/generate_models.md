---
dag_name: generate_models
description: Создает файлы моделей dbt, заполненные содержимым по умолчанию, т.е. вызовом макросов по каждому шагу методологии etlCraft
status: требуется доработка
doc_status: in progress
type: dag
---


**Решаемая задача**: Создает файлы моделей dbt, заполненные содержимым по умолчанию, т.е. вызовом макросов по каждому шагу методологии etlCraft

# Обзор

DAG обеспечивает следующий рабочий процесс построения проекта в dbt:

1. Подключить необходимые источники.
2. Дать DAG’у сгенерировать модели, соответствующие этим источникам, которые будут делать типичные для данного источника операции по обработке данных.
3. Изменить сгенерированные модели под свои задачи.

При запуске DAG создаёт структуру папок, соответствующую слоям методологии etlCraft, и записывает в них файлы. Содержимое каждого файла — это вызов соответствующего макроса из пакета `dbt-etlcraft` без аргументов, что подразумевает использование поведения макроса по умолчанию.

Далее пользователь может кастомизировать свои модели: добавлять новые и изменять сгенерированные. Чтобы пользовательские изменения не затёрлись при повторном вызове DAG'а, нужно их либо переименовать, либо положить в специальную папку (см. раздел *Подготовка*).

Файлы, не удовлетворяющие условиям выше, при вызове DAG’а удаляет и генерирует заново.

# Используемые конфиги

`basic_config.dbt_dir`  — путь к проекту dbt (абсолютный или относительный папки с DAG’ами).

`basic_config.dbt_models_dir` — путь к папке с моделями для генерации относительно `basic_config.dbt_dir`.

# Порядок работы

## Подготовка

Вначале DAG очищает директорию, в которой он будет генерировать файлы. На месте остаются лишь файлы, кастомизированные (созданные или измененные) пользователем. Чтобы DAG понял, что файлы кастомизированы должно выполняться одно из следующих условий:

- либо они должны иметь окончание `_manual.sql`. При изменении сгенерированного файла пользователь может просто переименовать его, дописав `_manual`.
- либо они должны находиться в папке с названием, оканчивающимся на `_manual` (или в одной из её подпапок). В этом случае отдельные файлы можно не переименовывать и называть как угодно.

[[Поменять логику очистки файлов и папок]]

[[Настроить получение адреса папки проекта dbt и папки с моделями из конфига basic_config]]

## Формат результата на шаге `prepare`

Словарь, в котором названия папок являются ключами, а на нижнем уровне вложенности находится список генерируемых объектов с полями `file_name`, `path` и `content`:

```jsx
{
    '1_silos': {
        'normalize': [
            {
                'file_name': 'normalize_appmetrica_events_default_events.sql',
                'path': '/mnt/c/test/models_test_airflow_NEW_v4/1_silos/1_normalize',
                'content': '{{% raw %}}{{{{ etlcraft.normalize() }}}}{{% endraw %}}'
            },
            {
                'file_name': 'normalize_appmetrica_events_default_deeplinks.sql',
                'path': '/mnt/c/test/models_test_airflow_NEW_v4/1_silos/1_normalize',
                'content': '{{% raw %}}{{{{ etlcraft.normalize() }}}}{{% endraw %}}'
            },
            {
                'file_name': 'normalize_appmetrica_events_default_installations.sql',
                'path': '/mnt/c/test/models_test_airflow_NEW_v4/1_silos/1_normalize',
                'content': '{{% raw %}}{{{{ etlcraft.normalize() }}}}{{% endraw %}}'
            }
        ],
        'incremental': [
            {
                'file_name': 'incremental_appmetrica_events_default_events.sql',
                'path': '/mnt/c/test/models_test_airflow_NEW_v4/1_silos/2_incremental',
                'content': "{{% raw %}}-- depends_on: {{{{ ref('normalize_appmetrica_events_default_events') }}}}{{% endraw %}}\n{{% raw %}}{{{{ etlcraft.incremental() }}}}{{% endraw %}}"
            },
            {
                'file_name': 'incremental_appmetrica_events_default_deeplinks.sql',
                'path': '/mnt/c/test/models_test_airflow_NEW_v4/1_silos/2_incremental',
                'content': "{{% raw %}}-- depends_on: {{{{ ref('normalize_appmetrica_events_default_deeplinks') }}}}{{% endraw %}}\n{{% raw %}}{{{{ etlcraft.incremental() }}}}{{% endraw %}}"
            },
            {
                'file_name': 'incremental_appmetrica_events_default_installations.sql',
                'path': '/mnt/c/test/models_test_airflow_NEW_v4/1_silos/2_incremental',
                'content': "{{% raw %}}-- depends_on: {{{{ ref('normalize_appmetrica_events_default_installations') }}}}{{% endraw %}}\n{{% raw %}}{{{{ etlcraft.incremental() }}}}{{% endraw %}}"
            }
        ]
    },
    '2_join': {
        # Данные для '2_join'
    }
    # Данные для следующих слоёв
}
```

[[Check the documentation to find out what {{% raw %}} and {{%endraw%}} are.]]

[[Избавиться от prepare_files_data и скорректировать раздел Формат на шаге prepare]]

[[Turn the create_models_file function into a statement]]

## Операции в рамках итерации

DAG создаёт динамическую задачу для каждого генерируемого файла. Оператор `EtlcraftCreateFileOperator` при необходимости создаёт родительские папки, формирует файл и записывает в него содержимое, переданное через аргумент.

# Результат

В папке моделей проекта dbt созданы все необходимые модели, преобразующие сырые данные в готовые к использованию витрины:

[[Attach a screenshot of the generated folder tree to the documentation]]
