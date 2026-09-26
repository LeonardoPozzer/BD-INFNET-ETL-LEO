{% test unique_all_columns(model) %}

    {% set columns = adapter.get_columns_in_relation(model) %}
    {% for column in columns %}

        SELECT
            '{{ column.name }}' AS coluna,
            TO_JSON_STRING({{ adapter.quote(column.name) }}) AS valor,
            COUNT(*) AS quantidade
        FROM {{ model }}
        GROUP BY {{ adapter.quote(column.name) }}
        HAVING COUNT(*) > 1

        {% if not loop.last %}
            UNION ALL
        {% endif %}
    {% endfor %}
{% endtest %}