-- FUNCTION: etc.gen_cost_id()

-- DROP FUNCTION IF EXISTS etc.gen_cost_id();

CREATE OR REPLACE FUNCTION etc.gen_cost_id()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	-- Error handling for concatenation
	BEGIN
		NEW.cost_id := 'c' || NEW.running_id;
	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'Error in concatenating running id with letter c';
	END;
	RETURN NEW;
END;
$BODY$;

ALTER FUNCTION etc.gen_cost_id()
    OWNER TO "DUser";
