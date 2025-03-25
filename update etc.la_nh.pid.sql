WITH cte AS (
			SELECT etc.uuid_nil() as nil, item_name, item_size, item_color, internalid FROM etc.la_nh_product
		)
UPDATE etc.la_nh_product 
SET pid = subquery.pid
FROM (
	SELECT etc.uuid_generate_v3(etc.uuid_nil(), internalid || ' ' || item_name || ' ' || item_size || ' ' || item_color) as pid
	FROM etc.la_nh_product
) AS subquery
WHERE etc.la_nh_product.pid IS NULL;

SELECT * FROM etc.la_nh_product;