
  
    
    
        
        insert into test.attr_mysecondfunnel_find_new_period__dbt_backup ("qid", "__link", "__priority", "__id", "__datetime", "__rn", "__step", "__is_new_period")
  -- depends_on: test.attr_mysecondfunnel_add_row_number






with prep_new_period as (
    select
        *,
        max(case when __priority in [1, 2, 3] then __datetime else null end) over (partition by qid order by __rn rows between unbounded preceding and 1 preceding) as prep_new_period
    from test.attr_mysecondfunnel_add_row_number
)


select
    qid, 
    __link,
    __priority,
    __id,
    __datetime,
    __rn,
    __step,
    CASE
    
            WHEN __link = 'AppInstallStat' and toDate(__datetime) - toDate(prep_new_period) < 
             30  THEN false
        
            WHEN __link = 'AppSessionStat' and toDate(__datetime) - toDate(prep_new_period) < 
             30  THEN false
        
            WHEN __link = 'AppDeeplinkStat' and toDate(__datetime) - toDate(prep_new_period) < 
             30  THEN false
        
            WHEN __link = 'AppEventStat' and toDate(__datetime) - toDate(prep_new_period) < 
             7  THEN false
        ELSE true
    END as __is_new_period
 from prep_new_period   




  