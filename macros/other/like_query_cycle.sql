{% macro like_query_cycle(list, value) %}
    {% for element in list %}
        {% if not loop.last %}
            {{ value }} like '%_{{ element }}_%' OR
        {% elif loop.first %}
             {{ value }} like '%_{{ element }}_%' 
        {% else %}
            {{ value }} like '%_{{ element }}_%' 
        {% endif %}
    {% endfor %}
{% endmacro %}