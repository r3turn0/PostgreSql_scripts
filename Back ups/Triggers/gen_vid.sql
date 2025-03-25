-- FUNCTION: etc.gen_vid()

-- DROP FUNCTION IF EXISTS etc.gen_vid();

CREATE OR REPLACE FUNCTION etc.gen_vid()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	-- Error handling for concatenation
	BEGIN
		NEW.vid := 'vetc' || NEW.running_id;
	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'Error in concatenating running id with letter c';
	END;
	RETURN NEW;
END;
$BODY$;

ALTER FUNCTION etc.gen_vid()
    OWNER TO "DUser";
