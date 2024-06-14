
  
    
    
        
        insert into test.attr_myfirstfunnel_add_row_number__dbt_backup ("qid", "__link", "__priority", "__id", "__datetime", "__step", "__rn")
  -- depends_on: test.attr_myfirstfunnel_create_events




select
    *,
    row_number() over (partition by qid order by __datetime, __priority, __id) AS __rn
from test.attr_myfirstfunnel_create_events




  