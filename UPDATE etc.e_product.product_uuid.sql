WITH cte AS (
    SELECT etc.uuid_nil() as nil, item_name, item_size, item_color, internal_id FROM etc.e_product
)
UPDATE etc.e_product 
SET product_uuid = subquery.product_uuid
FROM (
    SELECT internal_id, etc.uuid_generate_v3(etc.uuid_nil(), item_name || ' ' || item_size || ' ' || item_color) as product_uuid
    FROM etc.e_product
) AS subquery
WHERE etc.e_product.internal_id = subquery.internal_id






