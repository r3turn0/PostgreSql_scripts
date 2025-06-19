-- FUNCTION: etc.update etc.tm_product.pid()

-- DROP FUNCTION IF EXISTS etc."update etc.tm_product.pid"();

CREATE OR REPLACE FUNCTION etc."update etc.tm_product.pid"(
	)
    RETURNS void
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
WITH cte AS (
	SELECT etc.uuid_nil() as nil, item_name, item_size, item_color, id FROM etc.tm_product
)
UPDATE etc.tm_product 
SET pid = subquery.pid
FROM (
	SELECT etc.uuid_generate_v3(etc.uuid_nil(), id || ' ' || item_name || ' ' || item_size || ' ' || item_color) as pid
	FROM etc.tm_product
) AS subquery
WHERE etc.tm_product.pid IS NULL;
$BODY$;

ALTER FUNCTION etc."update etc.tm_product.pid"()
    OWNER TO "DUser";
