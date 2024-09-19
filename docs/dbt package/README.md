**Шаги и подшаги** - основной путь данных:

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

**Единая структура описания макросов (от общего - к  частному):**
- Описание
- Использование
- Аргументы
- Функциональность
- Пример
- Примечания   

**Макросы можно условно поделить на несколько категорий**:

- **main**: это “основные”, или главные, макросы.  Глобально - эти макросы прокладывают путь от сырых данных к финальным таблицам. В частности, они обеспечивают реализацию основных шагов по преобразованию данных. Всего таких шагов 7.
  
- **sub_main**: это подвиды “основных” макросов. В частности, они используются на шагах join, graph, attribution. Такие макросы нужны, когда основной макрос или перераспределяет работу по под-макросам в зависимости от источника данных (как на шаге join), или когда работа основного макроса распределяется по последовательным шагам (как в graph, attribution).
  
- **auxiliary**: это вспомогательные макросы. Они выполняют какую-то одну специальную техническую задачу, которую нужно решить в процессе исполнения “основного” макроса. Например, задать нормализовать имя столбцов, или задать “пустую” дату, если это необходимо.

## main

```dataview
TABLE 
doc_status AS "Doc Status",
category AS "Category", 
step AS "Step", 
sub_step AS "Substep"
FROM "dbt Package"
WHERE (file.name!="README" AND file.name!="TEMPLATE MAIN rus") 
AND (category="main") AND language!="eng"
SORT step, sub_step, category DESC, doc_status 
```

## sub_main

```dataview
TABLE 
doc_status AS "Doc Status",
step AS "Step", 
sub_step AS "Substep",
in_main_macro AS "In Main Macro"
FROM "dbt Package"
WHERE (file.name!="README" AND file.name!="TEMPLATE MAIN rus") 
AND (category="sub_main") AND language!="eng"
SORT step, sub_step, doc_status 
```

## auxiliary

```dataview
TABLE 
doc_status AS "Doc Status",
step AS "Step", 
sub_step AS "Substep",
in_main_macro AS "In Main Macro"
FROM "dbt Package"
WHERE (file.name!="README" AND file.name!="TEMPLATE AUXILIARY rus") 
AND (category="auxiliary") AND language!="eng"
SORT step, sub_step, doc_status 
```
