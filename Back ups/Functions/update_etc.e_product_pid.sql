-- FUNCTION: etc.update etc.e_product.pid()

-- DROP FUNCTION IF EXISTS etc."update etc.e_product.pid"();

CREATE OR REPLACE FUNCTION etc."update etc.e_product.pid"(
	)
    RETURNS void
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
WITH cte AS (
	SELECT etc.uuid_nil() as nil, item_name, item_size, item_color, internal_id FROM etc.e_product
)
UPDATE etc.e_product 
SET pid = subquery.pid
FROM (
	SELECT etc.uuid_generate_v3(etc.uuid_nil(), internal_id || ' ' || item_name || ' ' || item_size || ' ' || item_color) as pid
	FROM etc.e_product
) AS subquery
WHERE etc.e_product.pid IS NULL
$BODY$;

ALTER FUNCTION etc."update etc.e_product.pid"()
    OWNER TO "DUser";
