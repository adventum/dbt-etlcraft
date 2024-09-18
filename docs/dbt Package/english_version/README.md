**Unified macro description structure (from general to particular):**
- Summary 
- Usage 
- Arguments
- Functionality 
- Example 
- Notes

**Macros can be divided into several categories**:

- **main**: these are the “main” or main macros.  Globally, these macros pave the way from raw data to final tables. In particular, they provide the implementation of the basic steps for data transformation. There are 7 such steps in total.
  
- **sub_main**: these are subspecies of “basic” macros. In particular, they are used in the join, graph, and attribution steps. Such macros are needed when the main macro either redistributes work across sub-macros depending on the data source (as in the join step), or when the work of the main macro is distributed in successive steps (as in graph, attribution).
  
- **auxiliary**: these are auxiliary macros. They perform some special technical task that needs to be solved during the execution of the “main” macro. For example, set the normalize column name, or set an “empty” date, if necessary.


```dataview
TABLE 
doc_status AS "Doc Status",
category AS "Category", 
step AS "Step", 
sub_step AS "Substep",
in_main_macro AS "In Main Macro"
FROM "dbt Package"
WHERE (file.name!="README" AND file.name!="TEMPLATE MAIN") 
AND (category="main") AND language="eng"
SORT step, sub_step, category DESC, doc_status 
```

