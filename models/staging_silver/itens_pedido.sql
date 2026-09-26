SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,

    ROUND(price, 2) AS price,
    ROUND(freight_value, 2) AS freight_value

FROM {{ source('consumo', 'stg_itens_pedido') }}