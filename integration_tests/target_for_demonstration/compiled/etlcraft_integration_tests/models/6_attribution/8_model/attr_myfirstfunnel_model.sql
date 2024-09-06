-- depends_on: test.attr_myfirstfunnel_join_to_attr_prepare_with_qid







with
max_last_click_rank as (

    select
        *

        ,max(__last_click_rank) over(partition by qid, __period_number order by __datetime, __priority, __id) as __max_last_click_rank

        ,max(__first_click_rank) over(partition by qid, __period_number order by __datetime, __priority, __id) as __max_first_click_rank

     from test.attr_myfirstfunnel_join_to_attr_prepare_with_qid

),


target_count as (

    select
        *

         ,__last_click_rank = __max_last_click_rank as  __last_click__rank_condition
         ,sum(case when __last_click__rank_condition then 1 else 0 end) over(partition by qid, __period_number order by __datetime, __priority, __id) as __last_click__target_count 

         ,__first_click_rank = __max_first_click_rank as  __first_click__rank_condition
         ,sum(case when __first_click__rank_condition then 1 else 0 end) over(partition by qid, __period_number order by __datetime, __priority, __id) as __first_click__target_count 

    from max_last_click_rank
)


SELECT 
    qid, __datetime, __id, __priority,`__if_missed`,__link,__period_number


    
        
        
            ,first_value(utmSource) over(partition by qid, __period_number, __last_click__target_count  order by  __datetime, __priority, __id) as __myfirstfunnel_last_click_utmSource
        
            ,first_value(utmMedium) over(partition by qid, __period_number, __last_click__target_count  order by  __datetime, __priority, __id) as __myfirstfunnel_last_click_utmMedium
        
            ,first_value(utmCampaign) over(partition by qid, __period_number, __last_click__target_count  order by  __datetime, __priority, __id) as __myfirstfunnel_last_click_utmCampaign
        
            ,first_value(utmTerm) over(partition by qid, __period_number, __last_click__target_count  order by  __datetime, __priority, __id) as __myfirstfunnel_last_click_utmTerm
        
            ,first_value(utmContent) over(partition by qid, __period_number, __last_click__target_count  order by  __datetime, __priority, __id) as __myfirstfunnel_last_click_utmContent
        
            ,first_value(adSourceDirty) over(partition by qid, __period_number, __last_click__target_count  order by  __datetime, __priority, __id) as __myfirstfunnel_last_click_adSourceDirty
        
     

    
        
        
            ,first_value(utmSource) over(partition by qid, __period_number order by __first_click_rank desc,__datetime, __priority, __id) as __myfirstfunnel_first_click_utmSource
        
            ,first_value(utmMedium) over(partition by qid, __period_number order by __first_click_rank desc,__datetime, __priority, __id) as __myfirstfunnel_first_click_utmMedium
        
            ,first_value(utmCampaign) over(partition by qid, __period_number order by __first_click_rank desc,__datetime, __priority, __id) as __myfirstfunnel_first_click_utmCampaign
        
            ,first_value(utmTerm) over(partition by qid, __period_number order by __first_click_rank desc,__datetime, __priority, __id) as __myfirstfunnel_first_click_utmTerm
        
            ,first_value(utmContent) over(partition by qid, __period_number order by __first_click_rank desc,__datetime, __priority, __id) as __myfirstfunnel_first_click_utmContent
        
            ,first_value(adSourceDirty) over(partition by qid, __period_number order by __first_click_rank desc,__datetime, __priority, __id) as __myfirstfunnel_first_click_adSourceDirty
        
     


FROM target_count



