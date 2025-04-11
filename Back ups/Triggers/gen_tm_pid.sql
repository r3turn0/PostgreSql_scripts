-- FUNCTION: etc.gen_tm_pid()

-- DROP FUNCTION IF EXISTS etc.gen_tm_pid();

CREATE OR REPLACE FUNCTION etc.gen_tm_pid()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	-- Error handling for concatenation
	BEGIN

		WITH cte AS (
			SELECT etc.uuid_nil() as nil, item_name, item_size, item_color, id, product_id FROM etc.tm_product
		)
		UPDATE etc.tm_product 
		SET pid = subquery.pid
		FROM (
			SELECT product_id, etc.uuid_generate_v3(nil, id || ' ' || item_name || ' ' || item_size || ' ' || item_color) as pid
			FROM cte
		) AS subquery
		WHERE etc.tm_product.product_id = subquery.product_id;
				
	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'Error in populating product_uuid column';
	END;
	RETURN NEW;
END;
$BODY$;

ALTER FUNCTION etc.gen_tm_pid()
    OWNER TO "DUser";
