
  
    
    
        
        insert into test.attr_myfirstfunnel_create_missed_steps__dbt_backup ("qid", "__link", "__id", "__priority", "__datetime", "__period_number", "__if_missed", "__step", "__rn")
  -- depends_on: test.attr_myfirstfunnel_calculate_period_number




with calc_max_priority as (
    select
        qid, 
        __link,
        __id,
        __datetime,
        __rn,
        __priority,
        __period_number,
        __step,
        max(__priority) over(partition by qid, __period_number) as max_priority
    from test.attr_myfirstfunnel_calculate_period_number
),


generate_all_priorities as (
    select
        distinct qid, __link,
        arrayJoin(range(1, assumeNotNull(max_priority) + 1)) as gen_priority
    from calc_max_priority
),


final as (
    select
        first_value(__id) OVER (PARTITION BY qid ORDER BY gen_priority ROWS BETWEEN current row AND UNBOUNDED FOLLOWING ) as __id,
        gen_priority as __priority,
        qid, __link,
        first_value(__datetime) OVER (PARTITION BY qid ORDER BY gen_priority ROWS BETWEEN current row AND UNBOUNDED FOLLOWING ) as __datetime,
        first_value(__period_number) OVER (PARTITION BY qid ORDER BY gen_priority ROWS BETWEEN current row AND UNBOUNDED FOLLOWING ) as __period_number,
        case when calc_max_priority.qid = 0 then true else false end as __if_missed,
        __step
    from generate_all_priorities
    left join calc_max_priority
        on generate_all_priorities.qid = calc_max_priority.qid and
           generate_all_priorities.gen_priority = calc_max_priority.__priority
)


select
    qid, __link, __id,
    __priority, __datetime,
    __period_number,
    __if_missed,__step,
    row_number() over (partition by qid order by __datetime, __priority, __id) AS __rn
from final





  