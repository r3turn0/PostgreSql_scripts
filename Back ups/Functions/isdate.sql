-- FUNCTION: etc.isdate(character varying)

-- DROP FUNCTION IF EXISTS etc.isdate(character varying);

CREATE OR REPLACE FUNCTION etc.isdate(
	value character varying)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
    BEGIN
		-- return true or false whether value is like a timestamp case insensitive
        RETURN split_part(value, ' ', 1) ~* '^\d{4}-\d{2}-\d{2}$';
    END;
$BODY$;

ALTER FUNCTION etc.isdate(character varying)
    OWNER TO "DUser";
