---
category: auxiliary
step: 2_staging
sub_step: 3_hash
in_main_macro: hash
doc_status: ready
---
# macro `zero_date`

## Описание

Этот макрос нужен, чтобы для разных типов баз данных сгенерировать “нулевое” поле с датой.
## Аргументы

Этот макрос не принимает  аргументы.
## Функциональность

Этот макрос имеет следующие варианты:
- default
- clickhouse
- bigquery
  
“Нулевой” датой задаётся `1970-01-01`.
