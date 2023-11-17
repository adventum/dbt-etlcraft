{% macro join_mobile_install( source_types, streams, templates) %}

{% if source_types == 'appsflyer' %}

    {% for stream in streams %}

        {% if stream == 'installs' %} 

            WITH install as (
                --test query_type
                SELECT 
                    __datetime AS install_time,
                    toDate(__datetime) AS install_date,
                    toDate(attributed_touch_time) AS attributed_touch_date,
                    toDate(event_time) AS event_date,
                    * EXCEPT(__emitted_at, __normalized_at)
                FROM {{ref('incremental_' ~ templates ~ '_' ~ stream)}}
                )

        {% elif stream == 'post_attribution_installs' %}   

            ,post_attribution as (
                SELECT 
                    x.*,
                    y.appsflyer_id = x.appsflyer_id as is_fraud,
                    detection_date,
                    fraud_reason,	
                    fraud_reasons,	
                    fraud_sub_reason
                FROM install as x 
                left join {{ref('incremental_' ~ templates ~ '_' ~ stream)}} as y
                using(appsflyer_id)
                )

        {% endif %}
    {% endfor %}

    {% if "installs" in streams %}
        {% if "post_attribution_installs" in streams %}
            SELECT * FROM post_attribution
        {% else %}
            SELECT * FROM install
        {% endif %}
    {% endif %}

{% endif %}

{% endmacro %}