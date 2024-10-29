{%- macro fix_phone_decimal(
    field_name
) -%}

{#- это вспомогательный макрос для макроса fix_phone, здесь мы: -#}
{#- заменяем все нечисловые символы на пустоту -#}
{#- заменяем 9 одинаковых вхождений любой цифры на пустоту - чтобы убрать значения наподобие 7000000000 -#}

replaceRegexpAll( 
    replaceRegexpAll({{field_name}},'[^0-9]', '') 
, '0{9}|1{9}|2{9}|3{9}|4{9}|5{9}|6{9}|7{9}|8{9}|9{9}', '')

{%- endmacro -%}

{%- macro fix_phone(
    field_name
) -%}

{#- логика этого макроса -#}
{#- сначала мы делаем предобработку значений в переданном столбце -#}
{#- при помощи вспомогательного макроса fix_phone_decimal -#}
{#- затем мы проверяем условия → макрос действует по-разному для различных условий -#}

{#- если после предобработки длина значения равна 10 цифрам -#}
{#- то мы оставляем такое значение с предобработкой + к началу добавляем цифру 7 -#}
CASE  
WHEN length({{datacraft.fix_phone_decimal(field_name)}}) = 10 
THEN concat('7', {{datacraft.fix_phone_decimal(field_name)}})

{#- если после предобработки длина значения равна 11 цифрам  и начинается с цифры 7 -#}
{#- то мы оставляем такое значение с предобработкой и больше ничего с ним не делаем -#}
WHEN length({{datacraft.fix_phone_decimal(field_name)}}) = 11 
AND startsWith({{datacraft.fix_phone_decimal(field_name)}},'7')
THEN {{datacraft.fix_phone_decimal(field_name)}}

{#- если после предобработки длина значения равна 11 цифрам  и начинается с цифры 8 -#}
{#- то мы оставляем такое значение с предобработкой + заменяем начальную цифру 8 на 7 -#}
WHEN length({{datacraft.fix_phone_decimal(field_name)}}) = 11 
AND startsWith({{datacraft.fix_phone_decimal(field_name)}},'8')
THEN replaceOne({{datacraft.fix_phone_decimal(field_name)}}, '8', '7')

{#- в остальных случаях вместо значения будет пустота -#}
ELSE '' 
END
{%- endmacro %}
