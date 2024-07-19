
  
    
    
        
        insert into test.graph_lookup__dbt_backup ("key_hash", "key_number")
  -- depends_on: test.graph_tuples




with all_keys as
(
    
    select distinct hash as key_hash from test.graph_tuples
    union distinct select distinct node_left as key_hash from test.graph_tuples
)


select *, row_number() over() as key_number from all_keys

LIMIT 0



  