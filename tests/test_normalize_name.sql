{% set inputs = ["Space Name", "Прривет, Мир!"] %}
{% set expected_outputs = ["Space_Name", "Prrivet_Mir"] %}
{% for input, expected_output in zip(inputs, expected_outputs) %}
    {{ dbt_unittest.assert_equals(normalize_name(input), expected_output) }}
{% endfor %}

SELECT 1 WHERE FALSE