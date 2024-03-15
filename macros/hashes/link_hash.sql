{#- макрос берёт на вход имя линка и данные из файла metadata -#} 
{%- macro link_hash(link_name, metadata_dict) -%}
    {#- задаём имена сущности, линка - из словаря metadata -#}
    {%- set entities = metadata_dict['entities'] -%}
    {%- set links = metadata_dict['links'] -%}
    {#- имя хэша задаём из входного аргумента, оборачиваем в кавычки -#}
    {%- set name_hash = "'" ~ link_name ~ "'" -%}

    {#- для заданного линка берём его сущности  и ключи-#}
    {%- set link_entities = links[link_name]['entities'] -%} {# связанные линком хабы #}
    {%- set link_keys = links[link_name].get('keys') -%} {# доп. ключи для линка #}
    {%- set all_keys = [] -%}

    {#- для каждой сущности заданного линка берем его ключи -#}
    {%- for entity in link_entities -%}
        {%- set _ = all_keys.extend(entities[entity]['keys']) -%} {# собираем список ключей хабов #}
    {%- endfor -%}

    {%- if link_keys is not none -%}
        {%- set all_keys = all_keys + link_keys -%} {# добавляем к ключам хабов ключи линков #}
    {%- endif -%}

    {%- set all_cols = [name_hash] -%} {# сюда складываем ключи с трансформациями #}
    {%- set skip_null_cols = [] -%} {# skipInNullCheck #}

    {#- тут происходит техническая предобработка данных для всех ключей -#}
    {%- for key in all_keys -%}
        {#- приводим к формату String -#}
        {%- set sql_string = 'toString({})'.format(key['name']) -%} 
        
        {#- если нет ограничения, убираем пробелы по краям -#}
        {%- if not key.get('notrim') -%}
            {%- set sql_string = 'trim({})'.format(sql_string) -%}
        {%- endif -%}
        {#- если нет ограничения, приводим всё к верхнему регистру -#}
        {%- if not key.get('case-sensitive') -%}
            {%- set sql_string = 'upper({})'.format(sql_string) -%}
        {%- endif -%}

        {#- обработка в случае null -#}
        {%- set sql_string = 'ifnull(nullif({}, \'\'), \'\')'.format(sql_string) -%}

        {%- if not key.get('skipInNullCheck') -%}
            {% set _ = skip_null_cols.append(sql_string) %}
        {%- endif -%}

        {%- set _ = all_cols.append(sql_string) -%}

    {%- endfor -%}

    {%- set all = ' || \';\' || '.join(all_cols) -%}
    {%- set skip_null = ' || '.join(skip_null_cols) -%}

    {#-  здесь то, что получается в результате -#}
    assumeNotNull(coalesce(if({{ skip_null }} = '', null, hex(MD5({{ all }}))))) as {{ link_name }}Hash
    
{%- endmacro -%}