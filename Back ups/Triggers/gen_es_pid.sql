-- FUNCTION: etc.gen_es_pid()

-- DROP FUNCTION IF EXISTS etc.gen_es_pid();

CREATE OR REPLACE FUNCTION etc.gen_es_pid()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	-- Error handling for concatenation
	BEGIN

		WITH cte AS (
			SELECT etc.uuid_nil() as nil, title, id, product_id FROM etc.e_shopify
		)
		UPDATE etc.e_shopify 
		SET pid = subquery.pid
		FROM (
			SELECT product_id, etc.uuid_generate_v3(nil, title) as pid
			FROM cte
		) AS subquery
		WHERE etc.e_shopify.product_id = subquery.product_id;
				
	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'Error in populating pid column';
	END;
	RETURN NEW;
END;
$BODY$;

ALTER FUNCTION etc.gen_es_pid()
    OWNER TO "DUser";
