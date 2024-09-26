# dbt Package

Dbt Package содержит 10 основных шагов обработки данных. Каждый шаг - это один из “главных” макросов. Работа “главных” макросов в некоторых случаях обеспечивается за счёт работы подвидов основных макросов. Также во многих главных макросов и их подвидов используются вспомогательные макросы.

10 главных макросов:
01. [[normalize]]
02. [[incremental]]
03. [[join]]
04. [[combine]]
05. [[hash]]
06. [[link]]
07. [[graph]]
08. [[full]] 
09. [[attr]]
10. [[create_dataset]]


## Шаги и подшаги - основной путь данных

| **step**      | **sub_step**                    |
| ------------- | ------------------------------- |
| 1_silos       | 1_normalize                     |
|               | 2_incremental                   |
|               |                                 |
| 2_staging     | 1_join                          |
|               | 2_combine                       |
|               | 3_hash                          |
|               |                                 |
| 3_raw         | link                            |
|               |                                 |
| 4_graph       | 1_tuples                        |
|               | 2_lookup                        |
|               | 3_unique                        |
|               | 4_edge                          |
|               | 5_glue                          |
|               | 6_qid                           |
|               |                                 |
| 5_full        | full                            |
|               |                                 |
| 6_attribution | 1_prepare                       |
|               | 2_create_events                 |
|               | 3_add_row_number                |
|               | 4_find_new_period               |
|               | 5_calculate_period_number       |
|               | 6_create_missed_steps           |
|               | 7_join_to_attr_prepare_with_qid |
|               | 8_model                         |
|               | 9_final_table                   |
|               |                                 |
| 7_dataset     |                                 |

## Категории макросов

- **main**: это “основные”, или главные, макросы.  Глобально - эти макросы прокладывают путь от сырых данных к финальным таблицам. В частности, они обеспечивают реализацию основных шагов по преобразованию данных. Всего таких шагов 7.
  
- **sub_main**: это подвиды “основных” макросов. В частности, они используются на шагах join, graph, attribution. Такие макросы нужны, когда основной макрос или перераспределяет работу по под-макросам в зависимости от источника данных (как на шаге join), или когда работа основного макроса распределяется по последовательным шагам (как в graph, attribution).
  
- **auxiliary**: это вспомогательные макросы. Они выполняют какую-то одну специальную техническую задачу, которую нужно решить в процессе исполнения “основного” макроса. Например, нормализовать имя столбцов, или задать “пустую” дату, если это необходимо.

## Детали по категориям макросов:
## main - основные макросы

```dataview
TABLE 
doc_status AS "Doc Status",
main_number AS "Number", 
step AS "Step", 
sub_step AS "Substep"
FROM "dbt Package"
WHERE (file.name!="README" AND file.name!="TEMPLATE MAIN rus") 
AND (category="main") AND language!="eng"
SORT main_number
```

## sub_main - подвиды основных макросов

```dataview
TABLE 
doc_status AS "Doc Status",
in_main_macro AS "In Main Macro",
step AS "Step", 
sub_step AS "Substep"
FROM "dbt Package"
WHERE (file.name!="README" AND file.name!="TEMPLATE MAIN rus"
AND file.name!="TEMPLATE SUB_MAIN rus") 
AND (category="sub_main") AND language!="eng"
SORT step, sub_step, doc_status DESC 
```

## auxiliary - вспомогательные макросы

```dataview
TABLE 
doc_status AS "Doc Status",
in_main_macro AS "In Main Macro",
in_sub_main_macro AS "In Sub-Main Macro",
in_aux_macro AS "In Auxiliary Macro",
step AS "Step", 
sub_step AS "Substep"
FROM "dbt Package"
WHERE (file.name!="README" AND file.name!="TEMPLATE AUXILIARY rus") 
AND (category="auxiliary") AND language!="eng"
SORT doc_status DESC, step, sub_step
```
