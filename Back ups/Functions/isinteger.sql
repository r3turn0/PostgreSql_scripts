-- FUNCTION: etc.isinteger(character varying)

-- DROP FUNCTION IF EXISTS etc.isinteger(character varying);

CREATE OR REPLACE FUNCTION etc.isinteger(
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
		result := (value ~ '^\d+$');
	EXCEPTION
		WHEN others THEN
			result := FALSE;
	END;
	RETURN result;
END
$BODY$;

ALTER FUNCTION etc.isinteger(character varying)
    OWNER TO "DUser";
