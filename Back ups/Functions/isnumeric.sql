-- FUNCTION: etc.isnumeric(character varying)

-- DROP FUNCTION IF EXISTS etc.isnumeric(character varying);

CREATE OR REPLACE FUNCTION etc.isnumeric(
	value character varying)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	result BOOLEAN := FALSE;
BEGIN
	BEGIN
		result := (value ~ '^[0-9]+$');
	EXCEPTION
		WHEN others THEN
			result := FALSE;
	END;
	RETURN result;
END
$BODY$;

ALTER FUNCTION etc.isnumeric(character varying)
    OWNER TO "DUser";
