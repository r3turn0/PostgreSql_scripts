CREATE OR REPLACE PROCEDURE InsertFromCSV(FilePath TEXT, TargetTable TEXT)
LANGUAGE plpgsql AS $$
BEGIN
    -- Create a temporary table to hold the CSV data
    CREATE TEMP TABLE TempTable (
        Column1 TEXT,
        Column2 TEXT,
        Column3 TEXT,
        Column4 TEXT,
        Column5 TEXT,
        Column6 TEXT
        -- Add more columns as needed
    );

    -- Import data from the CSV file into the temporary table
    EXECUTE FORMAT('COPY TempTable (Column1, Column2, Column3, Column4, Column5, Column6)
                    FROM %L WITH CSV HEADER', FilePath);

    -- Insert data from the temporary table into the target table
    EXECUTE FORMAT('INSERT INTO %I (Column1, Column2, Column3, Column4, Column5, Column6)
                    SELECT * FROM TempTable', TargetTable);

    -- Drop the temporary table (temporary tables are auto-dropped at the end of the session)
END;
$$;
