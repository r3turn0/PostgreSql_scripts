WITH cte AS (
	SELECT etc.uuid_nil() as nil, title, id FROM etc.e_shopify
)
UPDATE etc.e_shopify 
SET pid = subquery.pid
FROM (
	SELECT etc.uuid_generate_v3(etc.uuid_nil(), title) as pid
	FROM etc.e_shopify
) AS subquery
WHERE etc.e_shopify.pid IS NULL;