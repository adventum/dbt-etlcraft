
  
    
    
        
        insert into test.incremental_vkads_periodstat_default_ad_plans__dbt_backup ("ad_groups", "autobidding_mode", "budget_limit", "budget_limit_day", "created", "date_end", "date_start", "id", "max_price", "name", "objective", "priced_goal", "pricelist_id", "status", "updated", "vkads_status", "__table_name", "__emitted_at", "__normalized_at")
  

SELECT *
FROM (

        (
            select
                            toString("ad_groups") as ad_groups ,
                            toString("autobidding_mode") as autobidding_mode ,
                            toString("budget_limit") as budget_limit ,
                            toString("budget_limit_day") as budget_limit_day ,
                            toString("created") as created ,
                            toString("date_end") as date_end ,
                            toString("date_start") as date_start ,
                            toString("id") as id ,
                            toString("max_price") as max_price ,
                            toString("name") as name ,
                            toString("objective") as objective ,
                            toString("priced_goal") as priced_goal ,
                            toString("pricelist_id") as pricelist_id ,
                            toString("status") as status ,
                            toString("updated") as updated ,
                            toString("vkads_status") as vkads_status ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_vkads_periodstat_default_ad_plans
        )

        )

  