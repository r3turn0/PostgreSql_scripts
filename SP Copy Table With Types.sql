DECLARE
    column_record RECORD;
    column_name TEXT;
    column_type TEXT;
    create_table_query TEXT;
BEGIN
    -- Start creating the new table
    create_table_query := 'CREATE TABLE ' || target_table_name || ' (';

    -- Loop through each column in the source table
    FOR column_record IN
        SELECT c.column_name, c.data_type
        FROM information_schema.columns c
        WHERE c.table_name = SPLIT_PART(source_table_name, '.', 2) 
        AND c.table_schema = SPLIT_PART(source_table_name, '.', 1)    
    LOOP
        column_name := column_record.column_name;
        column_type := CASE 
            WHEN column_record.data_type = 'character varying' THEN 'VARCHAR'
            WHEN column_record.data_type = 'double precision' THEN 'DOUBLE PRECISION'
			WHEN column_record.data_type = 'integer' THEN 'INTEGER' 	
            ELSE column_record.data_type
        END;

        -- Determine the column type based on the column name or sample values
        IF column_name ILIKE '%running_id%' THEN
            column_type := 'SERIAL';
        END IF;

        -- Append the column definition to the create table query
        create_table_query := create_table_query || column_name || ' ' || column_type || ', ';
    END LOOP;

    -- Remove the trailing comma and space, and close the create table statement
    create_table_query := rtrim(create_table_query, ', ') || ');';

    -- Execute the create table query
    EXECUTE create_table_query;

	-- Copy data from the source table to the new table
    EXECUTE 'INSERT INTO ' || target_table_name || ' (' || 
    (SELECT string_agg(c.column_name, ', ') FROM information_schema.columns c WHERE c.column_name NOT ILIKE '%running_id%' AND table_name = SPLIT_PART(source_table_name, '.', 2) AND table_schema = SPLIT_PART(source_table_name, '.', 1)) || 
    ') SELECT ' || 
    (SELECT string_agg(c.column_name, ', ') FROM information_schema.columns c WHERE c.column_name NOT ILIKE '%running_id%' AND table_name = SPLIT_PART(source_table_name, '.', 2) AND table_schema = SPLIT_PART(source_table_name, '.', 1)) || 
    ' FROM ' || source_table_name;

	

END;


