-- FUNCTION: etc.gen_tms_pid()

-- DROP FUNCTION IF EXISTS etc.gen_tms_pid();

CREATE OR REPLACE FUNCTION etc.gen_tms_pid()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	-- Error handling for concatenation
	BEGIN

		WITH cte AS (
			SELECT etc.uuid_nil() as nil, title FROM etc.tm_shopify
		)
		UPDATE etc.tm_shopify 
		SET pid = subquery.pid
		FROM (
			SELECT product_id, etc.uuid_generate_v3(etc.uuid_nil(), title) as pid
			FROM etc.tm_shopify
		) AS subquery
		WHERE etc.tm_shopify.product_id = subquery.product_id;

	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'Error in populating pid column';
	END;
	RETURN NEW;
END;
$BODY$;

ALTER FUNCTION etc.gen_tms_pid()
    OWNER TO "DUser";
