WITH cte AS (
	SELECT etc.uuid_nil() as nil, title FROM etc.tm_shopify
)
UPDATE etc.tm_shopify 
SET pid = subquery.pid
FROM (
	SELECT etc.uuid_generate_v3(etc.uuid_nil(), title) as pid
	FROM etc.tm_shopify
) AS subquery
WHERE etc.tm_shopify.pid IS NULL;