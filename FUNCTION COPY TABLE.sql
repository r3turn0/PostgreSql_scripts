CREATE OR REPLACE FUNCTION etc.copy_table(source_table TEXT, destination_table TEXT)
RETURNS VOID AS $$
BEGIN
    -- Check if the destination table exists
    IF NOT EXISTS (
        SELECT FROM information_schema.tables 
        WHERE table_name = SPLIT_PART(destination_table, '.', 2)
        AND table_schema = SPLIT_PART(destination_table, '.', 1)
    ) THEN
        -- Create the destination table if it does not exist
        EXECUTE format('CREATE TABLE %I AS TABLE %I', destination_table, source_table);
    ELSE
        -- Insert data from the source table to the destination table if it exists
        EXECUTE format('INSERT INTO %I SELECT * FROM %I', destination_table, source_table);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$ LANGUAGE plpgsql;