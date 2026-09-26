SELECT
    seller_id,
    seller_zip_code_prefix,

    {{ limpar_texto('seller_city') }} AS seller_city,

    UPPER(
        TRIM(
            COALESCE(seller_state, 'NA')
        )
    ) AS seller_state

FROM {{ source('consumo', 'stg_vendedores') }}