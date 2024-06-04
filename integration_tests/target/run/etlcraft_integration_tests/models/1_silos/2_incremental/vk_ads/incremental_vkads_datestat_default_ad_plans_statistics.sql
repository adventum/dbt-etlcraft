
        
  
    
    
        
        insert into test.incremental_vkads_datestat_default_ad_plans_statistics__dbt_new_data_dd0d5b65_f7d9_4a8d_b2dd_47c481a6cc3b ("__date", "ad_offers", "ad_plan_id", "base", "carousel", "date", "events", "moat", "playable", "romi", "social_network", "tps", "uniques", "uniques_video", "video", "__table_name", "__emitted_at", "__normalized_at")
  -- depends_on: test.normalize_vkads_datestat_default_ad_plans_statistics

SELECT * 
REPLACE(toDate(__date, 'UTC') AS __date)
FROM (

        (
            select
                            toString("__date") as __date ,
                            toString("ad_offers") as ad_offers ,
                            toString("ad_plan_id") as ad_plan_id ,
                            toString("base") as base ,
                            toString("carousel") as carousel ,
                            toString("date") as date ,
                            toString("events") as events ,
                            toString("moat") as moat ,
                            toString("playable") as playable ,
                            toString("romi") as romi ,
                            toString("social_network") as social_network ,
                            toString("tps") as tps ,
                            toString("uniques") as uniques ,
                            toString("uniques_video") as uniques_video ,
                            toString("video") as video ,
                            toString("__table_name") as __table_name ,
                            toDateTime("__emitted_at") as __emitted_at ,
                            toDateTime("__normalized_at") as __normalized_at 

            from test.normalize_vkads_datestat_default_ad_plans_statistics
        )

        )

  
      