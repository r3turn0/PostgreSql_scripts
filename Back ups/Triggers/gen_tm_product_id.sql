-- FUNCTION: etc.gen_tm_product_id()

-- DROP FUNCTION IF EXISTS etc.gen_tm_product_id();

CREATE OR REPLACE FUNCTION etc.gen_tm_product_id()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	-- Error handling for concatenation
	BEGIN
		NEW.product_id := 'tm' || NEW.running_id;
	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'Error in concatenating ID with letter p';
	END;
	RETURN NEW;
END;
$BODY$;

ALTER FUNCTION etc.gen_tm_product_id()
    OWNER TO "DUser";
