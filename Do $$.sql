SELECT quote_literal(cr.column_name)
                FROM information_schema.columns cr 
                WHERE cr.column_name NOT ILIKE '%running_id%' 
                AND table_name = SPLIT_PART('etc.load_staging', '.', 2) 
                AND table_schema = SPLIT_PART('etc.load_staging', '.', 1);

DO $$
DECLARE
	column_record RECORD;
	s VARCHAR;
BEGIN
FOR column_record IN SELECT * FROM etc.load_staging 
	LOOP
		s := (SELECT string_agg(cr.column_name, ', ')
		FROM information_schema.columns cr WHERE cr.column_name 
        NOT ILIKE '%running_id%' 
        AND table_name = SPLIT_PART('etc.load_staging', '.', 2) 
        AND table_schema = SPLIT_PART('etc.load_staging', '.', 1));
	END LOOP;
	EXECUTE s;
END;
$$;

DO $$
DECLARE
    --column_record etc.my_table_type;
	column_record RECORD;
    column_name TEXT;
    column_type TEXT;
    col_names TEXT;
    col_values TEXT;
	col_value TEXT;
BEGIN
	-- DROP THE TEMP TABLE
	EXECUTE 'DROP TABLE IF EXISTS temp_table';
	
	-- Create a temporary table and copy the data from etc.load_staging;
	
	EXECUTE 'CREATE TEMPORARY TABLE temp_table AS SELECT * FROM etc.load_staging';
	
	-- Drop the running_id column from the temporary table
	EXECUTE 'ALTER TABLE temp_table DROP COLUMN "running_id"';
    
	FOR column_record IN SELECT * FROM temp_table
    LOOP
        col_names := '';
        col_values := '';
	
        FOR column_name IN
            SELECT c.column_name
            FROM information_schema.columns c
            WHERE c.column_name NOT ILIKE '%running_id%'
            AND table_name = SPLIT_PART('etc.load_staging', '.', 2)
            AND table_schema = SPLIT_PART('etc.load_staging', '.', 1)
        LOOP
            col_names := col_names || column_name || ', ';
            col_value := (SELECT column_name FROM temp_table LIMIT 1);
			col_values := col_values || col_value || ', ';
        END LOOP;

        -- Remove trailing commas and spaces
        col_names := rtrim(col_names, ', ');
        col_values := rtrim(col_values, ', ');

        -- Output the constructed columns and values
		RAISE NOTICE 'Record: %', column_record;
        RAISE NOTICE 'Columns: %', col_names;
        RAISE NOTICE 'Values: %', col_values;
    END LOOP;
END $$;