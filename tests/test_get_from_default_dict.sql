{% set my_dict = {
    'fruit': {
        'color': 'red',
        'name': 'apple',
        'details': {
            'origin': 'Washington',
            'variety': 'Red Delicious'
        }
    },
    'animal': {
        'type': 'dog',
        'name': 'Rex',
        'details': {
            'breed': 'Labrador',
            'color': 'Black'
        }
    }
} %}

{% set test1 = get_from_default_dict(my_dict, ['fruit', 'color']) %}
{% set test2 = get_from_default_dict(my_dict, ['animal', 'details', 'breed']) %}
{% set test3 = get_from_default_dict(my_dict, ['fruit', 'details', 'origin']) %}
{% set test4 = get_from_default_dict(my_dict, ['animal', 'type']) %}
{% set test5 = get_from_default_dict(my_dict, ['fruit', 'taste']) %}
{% set test6 = get_from_default_dict(my_dict, ['animal', 'details', 'age'], 'Unknown') %}
{% set test7 = get_from_default_dict(my_dict, ['fruit', 'details', 'size'], 'N/A') %}

SELECT 'Test1 failed - expected red' WHERE '{{ test1 }}' != 'red'
UNION ALL SELECT 'Test2 failed - expected Labrador' WHERE '{{ test2 }}' != 'Labrador'
UNION ALL SELECT 'Test3 failed - expected Washington' WHERE '{{ test3 }}' != 'Washington'
UNION ALL SELECT 'Test4 failed - expected dog' WHERE '{{ test4 }}' != 'dog'
UNION ALL SELECT 'Test5 failed - expected {}' WHERE '{{ test5 }}' != '{}'
UNION ALL SELECT 'Test6 failed - expected Unknown' WHERE '{{ test6 }}' != 'Unknown'
UNION ALL SELECT 'Test7 failed - expected N/A' WHERE '{{ test7 }}' != 'N/A'
