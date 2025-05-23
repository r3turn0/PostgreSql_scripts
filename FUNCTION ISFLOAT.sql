CREATE OR REPLACE FUNCTION etc.ISFLOAT(value VARCHAR) 
RETURNS BOOLEAN AS $$
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
$$ LANGUAGE plpgsql;