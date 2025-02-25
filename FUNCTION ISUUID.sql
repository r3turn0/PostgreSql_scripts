CREATE OR REPLACE FUNCTION etc.ISUUID(value TEXT) 
RETURNS BOOLEAN AS $$
    BEGIN
		-- return true or false whether value is like a UUID case insensitive
        RETURN value ~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$';
    END;
$$ LANGUAGE plpgsql;


--EXEC sp_executesql @sql;