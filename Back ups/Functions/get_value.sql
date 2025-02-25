-- FUNCTION: etc.get_value(text, text)

-- DROP FUNCTION IF EXISTS etc.get_value(text, text);

CREATE OR REPLACE FUNCTION etc.get_value(
	column_name text,
	table_name text)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    res VARCHAR;
BEGIN
    EXECUTE 'SELECT ' || column_name || ' FROM ' || table_name || ' LIMIT 1' INTO res;
    RETURN res;
END;
$BODY$;

ALTER FUNCTION etc.get_value(text, text)
    OWNER TO "DUser";

COMMENT ON FUNCTION etc.get_value(text, text)
    IS 'gets 1 value of the column in a given table';
