**Шаги и подшаги** записаны в соответствии с внутренней документацией: https://docs.google.com/spreadsheets/d/17L2DaVe9fkugxNb99yqwg9e5r3wZ1ia7S_RBx3ZHh9A/edit?gid=494885188#gid=494885188

**Единая структура описания макросов (от общего - к  частному):**
- Summary - Описание
- Usage - Использование
- Arguments - Аргументы
- Functionality - Функциональность
- Example - Пример
- Notes - Примечания   


```dataview
TABLE 
doc_status AS "Doc Status",
category AS "Category", 
step AS "Step", 
sub_step AS "Substep",
in_main_macro AS "In Main Macro"
FROM "dbt Package"
WHERE (file.name!="README"AND file.name!="TEMPLATE MAIN") 
AND (category="main")
SORT step, sub_step, category DESC, doc_status 
```

