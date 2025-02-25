SELECT * FROM etc.load_staging;
SELECT * FROM etc.load_latest_load;
SELECT * FROM etc.copy_table_with_types('etc.load_staging','etc.load_latest_load');
SELECT * FROM etc.rejected;
TRUNCATE etc.rejected RESTART IDENTITY;

DECLARE
	column_record RECORD;
    column_name TEXT;
    column_type TEXT;
    create_table_query TEXT;
    err TEXT;
    s TEXT;
	v TEXT;
	col_names TEXT;
    col_values TEXT;
	col_values_expr TEXT;
BEGIN
    -- Start creating the new table
    create_table_query := 'CREATE TABLE IF NOT EXISTS ' || target_table_name || ' (';

    -- Loop through each column in the source table
    FOR column_record IN
        SELECT c.column_name, c.data_type, row(source_table_name, c.column_name) as record
        FROM information_schema.columns c
        WHERE c.table_name = SPLIT_PART(source_table_name, '.', 2) 
        AND c.table_schema = SPLIT_PART(source_table_name, '.', 1)
	
	LOOP
        column_name := column_record.column_name;
		IF etc.get_value(column_name, source_table_name) <> NULL THEN
	        column_type := CASE 
				WHEN etc.isdate(etc.get_value(column_record.column_name, source_table_name)) IS TRUE THEN column_record.data_type = 'TIMESTAMP' 
				WHEN etc.isfloat(etc.get_value(column_record.column_name, source_table_name)) IS TRUE THEN column_record.data_type = 'FLOAT'
				WHEN etc.isinteger(etc.get_value(column_record.column_name, source_table_name)) IS TRUE THEN column_record.data_type = 'INTEGER'
				WHEN etc.isnumeric(etc.get_value(column_record.column_name, source_table_name)) IS TRUE THEN column_record.data_type = 'NUMERIC'
				WHEN etc.isuuid(etc.get_value(column_record.column_name, source_table_name)) IS TRUE THEN column_record.data_type = 'UUID'
				WHEN column_record.data_type = 'character varying' THEN 'VARCHAR'
				ELSE column_record.data_type
	        END;
		ELSE
				column_type := 'VARCHAR';
		END IF;
		
        -- Determine the column type based on the column name or sample values
        IF column_name ILIKE '%running_id%' THEN
            column_type := 'SERIAL';
        END IF;

        -- Append the column definition to the create table query
        create_table_query := create_table_query || column_name || ' ' || column_type || ', ';
    END LOOP;

    -- Remove the trailing comma and space, and close the create table statement
    create_table_query := rtrim(create_table_query, ', ') || ');';

    -- Create the table
    EXECUTE create_table_query;

    -- Truncate the destination table to prepare it for loading the data record by record
    EXECUTE 'TRUNCATE ' || target_table_name;

    FOR column_record IN EXECUTE 'SELECT * FROM ' || source_table_name
    LOOP
        BEGIN
            col_names := '';
            col_values := '';
			col_values_expr := '';
			
            FOR column_name IN
                SELECT c.column_name
                FROM information_schema.columns c
                WHERE c.column_name NOT ILIKE '%running_id%'
                AND table_name = SPLIT_PART(source_table_name, '.', 2)
                AND table_schema = SPLIT_PART(source_table_name, '.', 1)
            LOOP
		   		col_names := col_names || column_name || ', ';
				--col_values := col_values || quote_literal(column_record.(column_name)::text) || ', ';
                col_values_expr := col_values_expr || '$$' || ', ';
			END LOOP;
			
			WITH array_data AS(
				SELECT array_agg(column_record) as arr
			) SELECT arr,
				(SELECT arr[array_length(arr, 1)] FROM array_data) AS last_element,
				ARRAY(
					SELECT elem - (SELECT arr[array_length(arr, 1)] FROM array_data)
					FROM unnest(arr) AS elem
				) AS result_array
			FROM array_data;
			
			-- Remove trailing commas and spaces
			   	col_names := rtrim(col_names, ', ');
				--col_values := rtrim(col_values, ', ');
				--col_values_expr := rtrim(col_values_expr, ', ');
				col_values := array_data;

            -- Use EXECUTE to perform the INSERT statement
            -- EXECUTE 'INSERT INTO ' || target_table_name || ' (' || col_names || ') VALUES (' || col_values || ');';
			EXECUTE format('INSERT INTO %I (%s) VALUES (%s)', target_table_name, col_names, col_values)
            USING column_record.*;
		EXCEPTION
            WHEN OTHERS THEN
                RAISE NOTICE 'Error inserting row: %', SQLERRM;
                err := SQLERRM;
                EXECUTE 'INSERT INTO etc.rejected (data, error) VALUES ('
                    || quote_literal(row_to_json(column_record))
                    || ', ' || quote_literal(err) || ');';
        END;
    END LOOP;
END;

CREATE TYPE etc.my_table_type AS (
    column_name TEXT,
    data_type TEXT
);