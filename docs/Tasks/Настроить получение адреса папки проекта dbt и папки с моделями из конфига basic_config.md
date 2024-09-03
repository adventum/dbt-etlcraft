---
task_name: "Настроить получение адреса папки проекта dbt и папки с моделями из конфига basic_config"
status: "In Progress"
assignee: ""
due: ""
---
Сейчас такой код:

```jsx
DBT_DIR = Path(Variable.get('dbt_dir_test'))
models_dir = Path(DBT_DIR) / 'models_test_airflow_NEW_v3'
```

Мы самостоятельно ничего не берем из переменных и файлов, а доверяем это дело функции по работе с конфигами. Такие единичные настройки стоит вынести в общий конфиг basic_config (см. backlink).