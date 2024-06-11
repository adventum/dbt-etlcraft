{% macro calc_graph() %}
    {# Запрос для обновления правой таблицы #}
    {% set right_query %}
        create or replace table {{ target.schema }}.graph_right engine=Log() as
        with
        min_group_id as (
            select
                node_id_left,
                min(group_id) as min_group_id
            from {{ target.schema }}.graph_edge
            group by node_id_left
        )

        select
            node_id_left,
            node_id_right,
            min_group_id as group_id,
            min_group_id != e.group_id as has_changed
        from {{ target.schema }}.graph_edge e
        join min_group_id r on r.node_id_left = e.node_id_left
    {% endset %}

    {# Запрос для обновления левой таблицы #}
    {% set left_query %}
        create or replace table {{ target.schema }}.graph_edge engine=Log() as
        with
        min_group_id as (
            select
                node_id_right,
                min(group_id) as min_group_id
            from {{ target.schema }}.graph_right
            group by node_id_right
        )

        select
            node_id_left,
            node_id_right,
            min_group_id as group_id,
            min_group_id != e.group_id as has_changed
        from {{ target.schema }}.graph_right e
        join min_group_id r on r.node_id_right = e.node_id_right
    {% endset %}

    {# Запрос для проверки наличия изменений #}
    {% set check_changed %}
        select 
            max(has_changed) 
        from {{ target.schema }}.graph_edge
    {% endset %}

    {# Если необходимо выполнить запросы #}
    {% if execute %}
        {% set ns = namespace(check_change=1) %}
        {% for i in range(0, 14) %}
            {{ log("Running iteration " ~ i) }}
            {{ check_change }}

            {# Проверяем, были ли изменения #}
            {% if ns.check_change == 1 %}
                {# Обновляем правую таблицу #}
                {% do run_query(right_query) %}
                {# Обновляем левую таблицу #}
                {% do run_query(left_query) %}
                {# Проверяем наличие изменений в данных #}
                {% set ns.check_change = run_query(check_changed).rows[0][0] %}
                {{ log('VALUE: ' ~ ns.check_change) }}
            {% endif %}
        {% endfor %}
    {% endif %}
{% endmacro %}