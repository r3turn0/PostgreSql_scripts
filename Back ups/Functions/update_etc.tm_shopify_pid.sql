-- FUNCTION: etc.update etc.tm_shopify.pid()

-- DROP FUNCTION IF EXISTS etc."update etc.tm_shopify.pid"();

CREATE OR REPLACE FUNCTION etc."update etc.tm_shopify.pid"(
	)
    RETURNS void
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
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
$BODY$;

ALTER FUNCTION etc."update etc.tm_shopify.pid"()
    OWNER TO "DUser";
