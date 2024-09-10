Шаги и подшаги в соответствии с внутренней документацией здесь: https://docs.google.com/spreadsheets/d/17L2DaVe9fkugxNb99yqwg9e5r3wZ1ia7S_RBx3ZHh9A/edit?gid=494885188#gid=494885188


```dataview
TABLE step AS "Step", sub_step AS "Substep" FROM "dbt package"
WHERE file.name != "README"
SORT step, sub_step
```



