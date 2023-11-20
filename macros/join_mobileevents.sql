{% macro join_mobileevents(source_types, streams, templates, params = none) %}

SELECT 

    x.__datetime AS event_time
    ,x.*EXCEPT(__emitted_at, __normalized_at)
{% if "post_attribution_in_app_events" in streams %} 
    ,y.appsflyer_id = x.appsflyer_id as is_fraud
    ,detection_date
    ,fraud_reason	
    ,fraud_reasons
    ,fraud_sub_reason
{% endif %}        
FROM {{ref('incremental_' ~ templates ~ '_in_app_events')}} as x
{% if "post_attribution_in_app_events" in streams %} 
left join {{ref('incremental_' ~ templates ~ '_post_attribution_in_app_events')}} as y
    using(appsflyer_id)
{% endif %}

{% endmacro %}