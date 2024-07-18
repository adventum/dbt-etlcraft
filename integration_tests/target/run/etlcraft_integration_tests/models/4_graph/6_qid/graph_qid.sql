
  
    
    
        
        insert into test.graph_qid__dbt_tmp ("__link", "__datetime", "__id", "qid")
  -- depends_on: test.graph_lookup
-- depends_on: test.graph_glue




select  
    toLowCardinality(
        tupleElement(key_hash, 1)
    ) as __link,
    tupleElement(key_hash, 2) as __datetime,
    tupleElement(key_hash, 3) as __id,
    qid
from test.graph_glue  -- Объединение с таблицей graph_glue
join test.graph_lookup on key_number = node_id_left  -- Соединение с таблицей graph_lookup




  