{% macro limpar_texto(coluna) %}

    LOWER(
        TRIM(
            REPLACE(
                COALESCE(
                    {{ coluna }},
                    '{{ var("valor_nulo_texto") }}'
                ),
                ' ',
                '_'
            )
        )
    )

{% endmacro %}