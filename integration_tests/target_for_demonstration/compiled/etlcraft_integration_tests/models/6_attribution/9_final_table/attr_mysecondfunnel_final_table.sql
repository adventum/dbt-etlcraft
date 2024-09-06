-- depends_on: test.attr_mysecondfunnel_model
-- depends_on: test.attr_mysecondfunnel_join_to_attr_prepare_with_qid




with 
    out as ( 
        select * except(_dbt_source_relation) 
        from  test.attr_mysecondfunnel_join_to_attr_prepare_with_qid
        join  test.attr_mysecondfunnel_model
            using (qid, __datetime, __id, __link, __period_number, __if_missed, __priority)
    )
    
select * from out 



