{% set inputs = ["Space Name", "Прривет, Мир!"] %}
{% set expected_outputs = ["Space_Name", "Prrivet_Mir"] %}

SELECT
{% for input, expected_output in zip(inputs, expected_outputs) -%}
    {% if not loop.first -%} UNION ALL SELECT {% endif %}
    'Test failed for input "{{ input }}". Expected output: "{{ expected_output }}", actual output: "{{ normalize_name(input) }}"' 
    WHERE '{{ normalize_name(input) }}' != '{{ expected_output }}'
{% endfor %}