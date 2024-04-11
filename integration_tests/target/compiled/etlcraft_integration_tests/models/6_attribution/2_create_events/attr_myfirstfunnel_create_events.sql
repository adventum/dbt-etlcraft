-- depends_on: test.attr_myfirstfunnel_prepare_with_qid




select
    qid, 
    __link,
    CASE
    WHEN __link = 'VisitStat'  and osName = 'web'  THEN  1
        
    WHEN __link = 'AppInstallStat'  and installs >= 1  THEN  2
        
    WHEN __link = 'AppSessionStat'  and sessions >= 1  THEN  3
        WHEN __link = 'AppDeeplinkStat'  THEN  3
        
    WHEN __link = 'AppEventStat'  and screenView >= 1  THEN  4
        
    
    ELSE 0
    END as __priority, 
    __id,
    __datetime,
    toLowCardinality(
    CASE
    WHEN __link = 'VisitStat' THEN 'visits_step'
        
    WHEN __link = 'AppInstallStat' THEN 'install_step'
        
    WHEN __link = 'AppSessionStat' THEN 'app_visits_step'
        WHEN __link = 'AppDeeplinkStat' THEN 'app_visits_step'
        
    WHEN __link = 'AppEventStat' THEN 'event_step'
        
    
    END) as __step
 from test.attr_myfirstfunnel_prepare_with_qid




