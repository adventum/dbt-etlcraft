---
category: auxiliary
step: 1_silos
sub_step: 1_normalize
in_main_macro: normalize
doc_status: ready
---
# macro `custom_union_relations_source`

## Описание

Это немного переделанный вариант макроса из пакета dbt_utils,  документация оригинального макроса: [здесь](https://github.com/dbt-labs/dbt-utils?tab=readme-ov-file#union_relations-source)
## Аргументы

Этот макрос принимает следующие аргументы:
```sql
relations, column_override=none, include=[], exclude=[], source_column_name='_dbt_source_relation'
```
## Функциональность

Этот макрос объединяет с помощью `UNION ALL` весь массив отношений, даже если столбцы в каждом отношении имеют разный порядок следования и/или некоторые столбцы отсутствуют в некоторых отношениях. 

Все столбцы, относящиеся только к подмножеству этих отношений, в оригинальном макросе будут заполнены значением null, если оно отсутствует. В этом же варианте макроса вместо null - пустые строки `''` или `0`. Также здесь есть новый столбец (`_dbt_source_relation`), указывающий источник для каждой записи.


