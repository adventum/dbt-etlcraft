-- depends_on: test.attr_myfirstfunnel_prepare_with_qid
-- depends_on: test.attr_myfirstfunnel_create_missed_steps






select 
    y.__period_number as __period_number, 
    y.__if_missed as __if_missed, 
    y.__priority as __priority, 
    y.__step as __step,
    x.*EXCEPT(adSourceDirty),



    CASE
    WHEN LENGTH (adSourceDirty) < 2 THEN 1
    WHEN match(adSourceDirty, 'Органическая установка') THEN 2
    WHEN __priority = 4 and not __if_missed = 1 THEN 3
    WHEN __priority = 3 and not __if_missed = 1 THEN 4
    WHEN __priority = 2 and not __if_missed = 1 THEN 5
    WHEN __priority = 1 and not __if_missed = 1 THEN 6
    
    ELSE 0
    END as __last_click_rank,

    CASE
    WHEN __priority = 3 and not __if_missed = 1 THEN 1
    WHEN __priority = 2 and not __if_missed = 1 THEN 2
    WHEN __priority = 1 and not __if_missed = 1 THEN 3
    
    ELSE 0
    END as __first_click_rank,



CASE

         WHEN  __if_missed and __priority = 1 
         THEN '[Без веб сессии]'
    

         WHEN  __if_missed and __priority = 2 
         THEN '[Без установки]'
    

         WHEN  __if_missed and __priority = 3 
         THEN '[Без апп сессии]'
    
         WHEN  __if_missed and __priority = 3 
         THEN '[Без апп сессии]'
    

         WHEN  __if_missed and __priority = 4 
         THEN ''
    

ELSE adSourceDirty
END as adSourceDirty

from test.attr_myfirstfunnel_prepare_with_qid AS x
join test.attr_myfirstfunnel_create_missed_steps AS y
    using (qid, __datetime, __link, __id)




