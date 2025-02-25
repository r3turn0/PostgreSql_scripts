-- FUNCTION: etc.isuuid(character varying)

-- DROP FUNCTION IF EXISTS etc.isuuid(character varying);

CREATE OR REPLACE FUNCTION etc.isuuid(
	value character varying)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
    BEGIN
		-- return true or false whether value is like a UUID case insensitive
        RETURN value ~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$';
    END;
$BODY$;

ALTER FUNCTION etc.isuuid(character varying)
    OWNER TO postgres;
