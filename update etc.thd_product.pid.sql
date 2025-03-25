WITH cte AS (
	SELECT etc.uuid_nil() as nil, item_name, item_size, item_color, internal_id FROM etc.thd_product
)
UPDATE etc.thd_product 
SET pid = subquery.pid
FROM (
	SELECT etc.uuid_generate_v3(etc.uuid_nil(), internal_id || ' ' || item_name || ' ' || item_size || ' ' || item_color) as pid
	FROM etc.thd_product
) AS subquery
WHERE etc.thd_shopify.product_id IS NULL;