# dbt Package

The Dbt Package contains 10 basic data processing steps. Each step is one of the “main” macros. In some cases, the work of the “main” macros is ensured by the work of subspecies of the main macros. Also, many main macros and their subspecies use auxiliary macros.


10 main macros:
01. [[normalize]]
02. [[incremental]]
03. [[join]]
04. [[combine]]
05. [[hash]]
06. link
07. graph
08. full
09. attr
10. create_dataset

## Steps and sub-steps - the main data path

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

## Categories of macros

- **main**: these are the “main” or main macros.  Globally, these macros pave the way from raw data to final tables. In particular, they provide the implementation of the basic steps for data transformation. There are 7 such steps in total.
  
- **sub_main**: these are subspecies of “basic” macros. In particular, they are used in the join, graph, and attribution steps. Such macros are needed when the main macro either redistributes work across sub-macros depending on the data source (as in the join step), or when the work of the main macro is distributed in successive steps (as in graph, attribution).
  
- **auxiliary**: these are auxiliary macros. They perform some special technical task that needs to be solved during the execution of the “main” macro. For example, set the normalize column name, or set an “empty” date, if necessary.

## Details by macro category:

## main 
| Name                                                     | Doc Status | Category | Step      | Substep       | In Main Macro |
| -------------------------------------------------------- | ---------- | -------- | --------- | ------------- | ------------- |
| [[dbt Package/english_version/normalize\|normalize]]     | ready      | main     | 1_silos   | 1_normalize   | -             |
| [[dbt Package/english_version/incremental\|incremental]] | ready      | main     | 1_silos   | 2_incremental | -             |
| [[dbt Package/english_version/join\|join]]               | ready      | main     | 2_staging | 1_join        | -             |
| [[dbt Package/english_version/combine\|combine]]         | ready      | main     | 2_staging | 2_combine     | -             |
| [[dbt Package/english_version/hash\|hash]]               | ready      | main     | 2_staging | 3_hash        | -             |

## auxiliary 

| Name                                                                         | Doc Status | Category  | Step    | Substep     | In Main Macro |
| ---------------------------------------------------------------------------- | ---------- | --------- | ------- | ----------- | ------------- |
| [[dbt Package/english_version/get_from_default_dict\|get_from_default_dict]] | ready      | auxiliary | 1_silos | 1_normalize | normalize     |
| [[dbt Package/english_version/normalize_name\|normalize_name]]               | ready      | auxiliary | 1_silos | 1_normalize | normalize     |
| [[dbt Package/english_version/json_extract_string\|json_extract_string]]     | ready      | auxiliary | 1_silos | 1_normalize | normalize     |

