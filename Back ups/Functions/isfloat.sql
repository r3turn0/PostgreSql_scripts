-- FUNCTION: etc.isfloat(character varying)

-- DROP FUNCTION IF EXISTS etc.isfloat(character varying);

CREATE OR REPLACE FUNCTION etc.isfloat(
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
		result := (value ~ '^[+-]?([0-9]*[.])?[0-9]+$');
	EXCEPTION
		WHEN others THEN
			result := FALSE;
	END;
	RETURN result;
END
$BODY$;

ALTER FUNCTION etc.isfloat(character varying)
    OWNER TO "DUser";
