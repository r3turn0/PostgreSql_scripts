-- FUNCTION: etc.gen_la_nh_pid()

-- DROP FUNCTION IF EXISTS etc.gen_la_nh_pid();

CREATE OR REPLACE FUNCTION etc.gen_la_nh_pid()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	WITH cte AS (
		SELECT etc.uuid_nil() as nil, item_name, item_size, item_color, internalid FROM etc.la_nh_product
	)
	UPDATE etc.la_nh_product 
	SET pid = subquery.pid
	FROM (
		SELECT product_id, etc.uuid_generate_v3(etc.uuid_nil(), internalid || ' ' || item_name || ' ' || item_size || ' ' || item_color) as pid
		FROM etc.la_nh_product
	) AS subquery
	WHERE etc.la_nh_product.product_id = subquery.product_id;	
EXCEPTION WHEN OTHERS THEN
	RAISE EXCEPTION 'Error in populating pid column';
RETURN NEW;
END;
$BODY$;

ALTER FUNCTION etc.gen_la_nh_pid()
    OWNER TO "DUser";
