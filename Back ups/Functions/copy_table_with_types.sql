-- FUNCTION: etc.copy_table_with_types(text, text)

-- DROP FUNCTION IF EXISTS etc.copy_table_with_types(text, text);

CREATE OR REPLACE FUNCTION etc.copy_table_with_types(
	source_table_name text,
	target_table_name text)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    column_record RECORD;
    column_name TEXT;
    column_type TEXT;
    create_table_query TEXT;
    err TEXT;
    col_names TEXT;
    col_values TEXT;
	col_value TEXT;
	--cur CURSOR FOR SELECT * FROM temp_table;
BEGIN
    -- Start creating the new table
    create_table_query := 'CREATE TABLE IF NOT EXISTS ' || target_table_name || ' (';

    -- Loop through each column in the source table
    FOR column_record IN
        SELECT c.column_name, c.data_type
        FROM information_schema.columns c
        WHERE table_name = SPLIT_PART(source_table_name, '.', 2) 
        AND table_schema = SPLIT_PART(source_table_name, '.', 1)
    LOOP
        column_name := column_record.column_name;
        IF etc.get_value(column_name, source_table_name) IS NOT NULL THEN
            column_type := CASE 
                WHEN etc.isinteger(etc.get_value(column_name, source_table_name)) IS TRUE THEN 'INTEGER'
                WHEN etc.isfloat(etc.get_value(column_name, source_table_name)) IS TRUE THEN 'DOUBLE PRECISION'
                WHEN etc.isnumeric(etc.get_value(column_name, source_table_name)) IS TRUE THEN 'NUMERIC'
                WHEN etc.isdate(etc.get_value(column_name, source_table_name)) IS TRUE THEN 'TIMESTAMP'
                WHEN etc.isuuid(etc.get_value(column_name, source_table_name)) IS TRUE THEN 'UUID'
                ELSE 'VARCHAR'
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

	BEGIN
    -- Create the table
    	EXECUTE create_table_query;

		EXCEPTION
	            WHEN OTHERS THEN
	                RAISE NOTICE 'Error creating table: %', SQLERRM;
	                err := SQLERRM;
	                EXECUTE 'INSERT INTO etc.rejected (data, error) VALUES ('
	                    || quote_literal(row_to_json(column_record))
	                    || ', ' || quote_literal(err || ', Create table query:  ' || create_table_query) || ');';
	END;
	
	-- Truncate the destination table to prepare it for loading the data record by record
	EXECUTE 'TRUNCATE ' || target_table_name;
	
	BEGIN
		-- DROP THE TEMP TABLE
		EXECUTE 'DROP TABLE IF EXISTS temp_table;';
		
		-- Create a temporary table with just the headers, 1=0 ensures that the table is created with the correct columns but no values
		EXECUTE 'CREATE TEMPORARY TABLE temp_table AS SELECT * FROM ' || source_table_name;

		EXECUTE 'DELETE FROM temp_table';
		
		-- Drop the running_id column from the temporary table
		-- EXECUTE 'ALTER TABLE temp_table DROP COLUMN "running_id"';

		--OPEN cur;
		FOR column_record IN EXECUTE 'SELECT * FROM ' || source_table_name
	    LOOP
	        BEGIN

				-- INSERT INTO TEMP TABLE THE COLUMN RECORD AND DROP THE running_id column
				EXECUTE 'INSERT INTO ' || temp_table || ' ('
			    || (SELECT string_agg(column_name, ', ') FROM information_schema.columns 
			        WHERE table_name = SPLIT_PART(source_table_name, '.', 2) 
			        AND table_schema = SPLIT_PART(source_table_name, '.', 1))
			    || ') VALUES (' || column_record || ');';

				EXECUTE 'ALTER TABLE temp_table DROP COLUMN IF EXISTS running_id';

				col_names := '';
	            -- col_values := '';
				
	            FOR column_name IN
		            SELECT c.column_name
		            FROM information_schema.columns c
		            WHERE c.column_name NOT ILIKE '%running_id%' AND
					table_name = SPLIT_PART(source_table_name, '.', 2)
		            AND table_schema = SPLIT_PART(source_table_name, '.', 1)
	            
				LOOP
					col_names := col_names || column_name || ', ';
					--col_values = string_agg(quote_literal(column_record), ', ');
					--col_values := col_values || COALESCE(quote_literal(col_value), 'NULL') || ', ';
				END LOOP;

				--LOOP
					--FETCH NEXT from cur INTO col_value;
					--EXIT WHEN NOT FOUND;
					--col_values := col_values || col_value || ', ';
								
				-- Remove trailing commas and spaces
	            col_names := rtrim(col_names, ', ');
				-- col_values := rtrim(col_values, ', ');
				
				 -- Output the constructed columns and values
				RAISE NOTICE 'Columns: %', col_names;
				RAISE NOTICE 'Values: %', col_values;
				
	            -- Use EXECUTE to perform the INSERT statement
	            -- EXECUTE format('INSERT INTO %I (%s) VALUES (%s)', target_table_name, col_names, col_values);
				EXECUTE 'INSERT INTO ' || target_table_name || '(' || col_names || ')' || 'SELECT * FROM temp_table);';
				--END LOOP;

				-- Delete all records from the temp_table to ensure that each insert is 1 record and 1 record only
				EXECUTE 'DELETE FROM temp_table';

				-- Add the column back in only for it to be deleted 
				EXECUTE 'ALTER TABLE temp_table ADD COLUMN running_id';
				
			EXCEPTION
	            WHEN OTHERS THEN
	                RAISE NOTICE 'Error inserting row: %', SQLERRM;
	                err := SQLERRM;
	                EXECUTE 'INSERT INTO etc.rejected (data, error) VALUES ('
	                    || quote_literal(row_to_json(column_record))
	                    || ', ' || quote_literal(err || ' -- columns: ' || col_names || ' values: ' || col_values ) || ');';
				
	        END;		
		END LOOP;
		--CLOSE cur;
	END;
END;
$BODY$;

ALTER FUNCTION etc.copy_table_with_types(text, text)
    OWNER TO "DUser";

COMMENT ON FUNCTION etc.copy_table_with_types(text, text)
    IS 'omits the running_id column becauase it''s always set to auto increment. ';
