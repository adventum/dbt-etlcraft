{% macro normalize_name(name) %}
    {% set vars = namespace(normalized_name=name) %}
    {% set vars.normalized_name = modules.re.sub('[^A-ZА-Яa-zа-я_\\s]', '', vars.normalized_name) %}
    {% set vars.normalized_name = modules.re.sub('\\s', '_', vars.normalized_name) %}
    {% set transliteration_map = {
        'а': 'a', 'б': 'b', 'в': 'v', 'г': 'g', 'д': 'd', 'е': 'e', 'ё': 'yo', 'ж': 'zh',
        'з': 'z', 'и': 'i', 'й': 'y', 'к': 'k', 'л': 'l', 'м': 'm', 'н': 'n', 'о': 'o',
        'п': 'p', 'р': 'r', 'с': 's', 'т': 't', 'у': 'u', 'ф': 'f', 'х': 'kh', 'ц': 'ts',
        'ч': 'ch', 'ш': 'sh', 'щ': 'shch', 'ъ': '', 'ы': 'y', 'ь': '', 'э': 'e', 'ю': 'yu',
        'я': 'ya'
    } %}
    {% for cyrillic, latin in transliteration_map.items() %}
        {% set vars.normalized_name = vars.normalized_name.replace(cyrillic, latin) %}
        {% set vars.normalized_name = vars.normalized_name.replace(cyrillic.upper(), latin.upper()) %}
    {% endfor %}    
    {{ return(vars.normalized_name) }}
{% endmacro %}