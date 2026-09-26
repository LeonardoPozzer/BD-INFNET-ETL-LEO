SELECT
    product_id,

    {{ limpar_texto('product_category_name') }}
        AS product_category_name,

    COALESCE(product_name_lenght, 0)
        AS product_name_length,

    COALESCE(product_description_lenght, 0)
        AS product_description_length,

    COALESCE(product_photos_qty, 0)
        AS product_photos_qty,

    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm

FROM {{ source('consumo', 'stg_produtos') }}