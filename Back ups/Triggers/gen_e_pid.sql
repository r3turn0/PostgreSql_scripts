-- FUNCTION: etc.gen_e_pid()

-- DROP FUNCTION IF EXISTS etc.gen_e_pid();

CREATE OR REPLACE FUNCTION etc.gen_e_pid()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	-- Error handling for concatenation
	BEGIN

		WITH cte AS (
			SELECT etc.uuid_nil() as nil, item_name, item_size, item_color, internal_id FROM etc.e_product
		)
		UPDATE etc.e_product 
		SET pid = subquery.pid
		FROM (
			SELECT product_id, etc.uuid_generate_v3(etc.uuid_nil(), internal_id || ' ' || item_name || ' ' || item_size || ' ' || item_color) as pid
			FROM etc.e_product
		) AS subquery
		WHERE etc.e_product.product_id = subquery.product_id;
		
				
	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'Error in populating pid column';
	END;
	RETURN NEW;
END;
$BODY$;

ALTER FUNCTION etc.gen_e_pid()
    OWNER TO "DUser";

COMMENT ON FUNCTION etc.gen_e_pid()
    IS 'WITH CTE AS (
	SELECT etc.uuid_nil() as nil, item_name, item_size, item_color, product_id, unit_price FROM etc.e_product
) SELECT etc.uuid_generate_v3(cte.nil, cte.item_name || '' '' || cte.item_size || '' '' || cte.item_color) as product_uuid, cte.item_name, cte.item_size, cte.item_color, cte.product_id, cte.unit_price as cost FROM cte; ';
