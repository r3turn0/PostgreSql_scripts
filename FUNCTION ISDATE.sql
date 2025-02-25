CREATE OR REPLACE FUNCTION etc.ISDATE(value TEXT) 
RETURNS BOOLEAN AS $$
    BEGIN
		-- return true or false whether value is like a timestamp case insensitive
        RETURN split_part(value, ' ', 1) ~* '^\d{4}-\d{2}-\d{2}$'
    END;
$$ LANGUAGE plpgsql;