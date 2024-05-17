
  
    
    
        
        insert into test.incremental_adjust_registry_default_events__dbt_backup ("app_token", "description", "formatting", "id", "is_skad_event", "name", "section", "short_name", "tokens", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_adjust_registry_default_events


SELECT *
FROM (

        (
            select
                            toString("app_token") as app_token ,
                            toString("description") as description ,
                            toString("formatting") as formatting ,
                            toString("id") as id ,
                            toString("is_skad_event") as is_skad_event ,
                            toString("name") as name ,
                            toString("section") as section ,
                            toString("short_name") as short_name ,
                            toString("tokens") as tokens ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_adjust_registry_default_events
        )

        )

  