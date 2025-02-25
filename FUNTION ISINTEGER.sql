CREATE OR REPLACE FUNCTION etc.ISINTEGER(value VARCHAR) 
RETURNS BOOLEAN AS $$
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
$$ LANGUAGE plpgsql;