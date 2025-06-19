-- FUNCTION: etc.update etc.la_nh_product.pid()

-- DROP FUNCTION IF EXISTS etc."update etc.la_nh_product.pid"();

CREATE OR REPLACE FUNCTION etc."update etc.la_nh_product.pid"(
	)
    RETURNS void
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
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
$BODY$;

ALTER FUNCTION etc."update etc.la_nh_product.pid"()
    OWNER TO "DUser";
