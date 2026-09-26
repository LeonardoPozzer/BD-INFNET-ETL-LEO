WITH pedidos AS (

    SELECT *
    FROM {{ ref('pedidos') }}

),

itens AS (

    SELECT *
    FROM {{ ref('itens_pedido') }}

)

SELECT
    i.order_id,
    i.order_item_id,

    p.customer_id,
    i.product_id,
    i.seller_id,

    p.order_purchase_timestamp,
    p.order_status,

    i.price AS valor_produto,
    i.freight_value AS valor_frete,

    i.price + i.freight_value AS valor_total

FROM itens i

INNER JOIN pedidos p
    ON i.order_id = p.order_id