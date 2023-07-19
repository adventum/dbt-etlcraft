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


{{ dbt_unittest.assert_equals(test1, 'red') }}
{{ dbt_unittest.assert_equals(test2, 'Labrador') }}
{{ dbt_unittest.assert_equals(test3, 'Washington') }}
{{ dbt_unittest.assert_equals(test4, 'dog') }}
{{ dbt_unittest.assert_equals(test5, {}) }}
{{ dbt_unittest.assert_equals(test6, 'Unknown') }}
{{ dbt_unittest.assert_equals(test7, 'N/A') }}

SELECT 1