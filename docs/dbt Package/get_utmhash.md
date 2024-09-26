---
category: auxiliary
step: 2_staging
sub_step: 1_join
in_sub_main_macro: join_ym_events
doc_status: ready
---
# macro `get_utmhash`

## Описание

Этот макрос нужен для работы с utm-метками. Он создаёт хэш-поле на основе передаваемых аргументов.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
delimiter='~', fields=['adGroupName', 'utmContent', 'utmCampaign', 'adCampaignName']
```
## Функциональность

Действие макроса:
```sql

{% if fields | length > 1 %}greatest({% endif %}{% for field in fields -%}

  coalesce(extract({{ field }}, '{{ delimiter }}([a-zA-Z0-9]{8})'), ''){% if not loop.last %}, {% endif %}

{%- endfor %}{% if fields | length > 1 %}){% endif %}
```

