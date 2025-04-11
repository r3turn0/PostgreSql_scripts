-- FUNCTION: etc.gen_thd_pid()

-- DROP FUNCTION IF EXISTS etc.gen_thd_pid();

CREATE OR REPLACE FUNCTION etc.gen_thd_pid()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	-- Error handling for concatenation
	BEGIN

		WITH cte AS (
			SELECT etc.uuid_nil() as nil, item_name, item_size, item_color, internal_id, product_id FROM etc.thd_product
		)
		UPDATE etc.thd_product 
		SET pid = subquery.pid
		FROM (
			SELECT product_id, etc.uuid_generate_v3(nil, internal_id || ' ' || item_name || ' ' || item_size || ' ' || item_color) as pid
			FROM cte
		) AS subquery
		WHERE etc.thd_product.product_id = subquery.product_id;
				
	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'Error in populating pid column';
	END;
	RETURN NEW;
END;
$BODY$;

ALTER FUNCTION etc.gen_thd_pid()
    OWNER TO "DUser";
