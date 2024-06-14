-- depends_on: test.link_events

    
        
        
        
        
            select
                    tuple(toLowCardinality(__link), __datetime,  __id) as hash,
                    tuple(toLowCardinality('CrmUserHash'), toDateTime(0),  CrmUserHash) as node_left
            from test.hash_events
            where nullIf(CrmUserHash, '') is not null
            
            union all
        
        
        
        
        
            select
                    tuple(toLowCardinality(__link), __datetime,  __id) as hash,
                    tuple(toLowCardinality('YmClientHash'), toDateTime(0),  YmClientHash) as node_left
            from test.hash_events
            where nullIf(YmClientHash, '') is not null
            
            union all
        
        
        
        
        
            select
                    tuple(toLowCardinality(__link), __datetime,  __id) as hash,
                    tuple(toLowCardinality('AppMetricaDeviceHash'), toDateTime(0),  AppMetricaDeviceHash) as node_left
            from test.hash_events
            where nullIf(AppMetricaDeviceHash, '') is not null
            
    
        union all
    
        
        
        
        
            select
                    tuple(toLowCardinality(__link), toDateTime(0),  __id) as hash,
                    tuple(toLowCardinality('AppMetricaDeviceHash'), toDateTime(0),  AppMetricaDeviceHash) as node_left
            from test.hash_registry_appprofilematching
            where nullIf(AppMetricaDeviceHash, '') is not null
            
            union all
        
        
        
        
        
            select
                    tuple(toLowCardinality(__link), toDateTime(0),  __id) as hash,
                    tuple(toLowCardinality('CrmUserHash'), toDateTime(0),  CrmUserHash) as node_left
            from test.hash_registry_appprofilematching
            where nullIf(CrmUserHash, '') is not null
            


