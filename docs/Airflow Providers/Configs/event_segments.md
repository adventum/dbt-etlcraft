---
description: Содержит описания и формулы сегментов событий?
config_default_type: "`templated_file`"
config_default_format: "`yaml`"
type: config
doc_status: in progress
---
#task может переименовать конфиг в `priorities_ruls` или что-то такое? 
#task поправить description
# Описание

При задании модели атрибуции в интерфейсе **dataCraft** (см. [[attributions]]), в том случае если был выбран тип “Last click”, также указываются `priorities`. Этот раздел содержит список названий правил, по которым будут присваивается приоритеты событиям в данной модели атрибуции. 

В конфиге `event_segments`, в свою очередь, приводятся сами правила (формулы). Структура у конфига следующая:
- `sluge` - идентификатор правила, например, `event_segment_1` 
- `formula`  - правило, по которому событиям присваивается приоритет, например: `LENGTH (adSourceDirty) < 2`
- `description` - описание правила

Данные из `event_segments`, в комбинации с данными из конфига [[attributions]],  используются при обработке данных на шаге атрибуции: на основе правил, указанных в `formula`, каждой строчке в данных присваивается определённый ранг, а затем, в рамках одного пользователя и одного периода активности присваиваем всем строчкам максимальный ранг (наиболее важный) (подробнее см. [[dbt Package]] и [[attr]]). 

Эти данные добавляются в проект с помощью DAG’а [[template_configs]].
# Пример

```
event_segment_1:
  formula: LENGTH (adSourceDirty) < 2
  description: тут какое-то описание
event_segment_2:
  formula: match(adSourceDirty, 'Органическая установка')
  description:
event_segment_3:
  formula: __priority = 4 and not __if_missed = 1
  description:
event_segment_4:
  formula: __priority = 3 and not __if_missed = 1
  description:
event_segment_5:
  formula: __priority = 2 and not __if_missed = 1
  description:
event_segment_6:
  fromula: __priority = 1 and not __if_missed = 1
  description:
```
