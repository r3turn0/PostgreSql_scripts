-- FUNCTION: etc.replicate_table(text, text)

-- DROP FUNCTION IF EXISTS etc.replicate_table(text, text);

CREATE OR REPLACE FUNCTION etc.replicate_table(
	source_table text,
	destination_table text)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    RESULT JSON;
BEGIN
    -- Check if the source table exists
    IF EXISTS (
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = SPLIT_PART(source_table, '.', 2)
        AND table_schema = SPLIT_PART(source_table, '.', 1)
    ) THEN
        -- Check if the destination table exists
        IF NOT EXISTS (
            SELECT FROM information_schema.tables 
            WHERE table_name = SPLIT_PART(destination_table, '.', 2)
            AND table_schema = SPLIT_PART(destination_table, '.', 1)
        ) THEN
            BEGIN
	            -- Create the destination table if it does not exist
				-- EXECUTE format('CREATE TABLE %I AS TABLE %I', destination_table, source_table);
				EXECUTE 'CREATE TABLE ' || destination_table || ' AS TABLE ' || source_table;
                EXCEPTION
                    WHEN OTHERS THEN
                    RAISE NOTICE 'Error creating table: %', SQLERRM;
                    RESULT := json_build_object(
                        'status', 'error',
                        'message', SQLERRM,
                        'code', SQLSTATE
                    );
                    EXECUTE 'INSERT INTO etc.rejected (data, error) VALUES (''{"data": ' || RESULT || '}'', ' || quote_literal('Error creating table: ' || destination_table) || ')';
            END;
        ELSE
            -- Insert data from the source table to the destination table if it exists
            EXECUTE 'INSERT INTO ' || destination_table || ' SELECT * FROM ' || source_table;
        END IF;
    ELSE
        RAISE NOTICE 'Source table does not exist: %', source_table;
        EXECUTE 'INSERT INTO etc.rejected (data, error) VALUES ( { data: ''' || source_table || '''}, ' || quote_literal('Source table does not exist') || ')';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$BODY$;

ALTER FUNCTION etc.replicate_table(text, text)
    OWNER TO "DUser";
