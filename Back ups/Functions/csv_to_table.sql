-- FUNCTION: etc.csv_to_table(text, text, integer, text[], text[])

-- DROP FUNCTION IF EXISTS etc.csv_to_table(text, text, integer, text[], text[]);

CREATE OR REPLACE FUNCTION etc.csv_to_table(
	target_table text,
	csv_path text,
	col_count integer,
	columns_from text[],
	columns_to text[])
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

declare 

iter integer; --dummy integer to iterate with
col text; --dummy variable to iterate with
col_first text; --first column label, e.g., top left corner on a csv file or spreadsheet

columns_from_str text;
columns_to_str text;

begin
set schema 'public';

drop table if exists temp_table;

create table temp_table ();

-- add just enough number of columns
for iter in 1..col_count
loop
    execute 'alter table temp_table add column col_' || iter || ' 
varchar;';
end loop;

-- copy the data from csv file
execute 'copy temp_table from ''' || csv_path || ''' with delimiter 
'',''';

iter := 1;
col_first := (select col_1 from temp_table limit 1);

-- update the column names based on the first row which has the column names
for col in execute 'select 
unnest(string_to_array(trim(temp_table::text, ''()''), '','')) from 
temp_table where col_1 = ''' || col_first || ''''
loop
    execute 'alter table temp_table rename column col_' || iter || ' 
to ' || col;
    iter := iter + 1;
end loop;

-- delete the columns row
execute 'delete from temp_table where ' || col_first || ' = ''' || 
col_first || '''';

-- make string from all columns 
columns_from_str := array_to_string(columns_from, ', ');
columns_to_str := array_to_string(columns_to, ', ');

execute format('insert into %s(%s) select %s from temp_table;', 
target_table, columns_to_str, columns_from_str);

end;

$BODY$;

ALTER FUNCTION etc.csv_to_table(text, text, integer, text[], text[])
    OWNER TO "DUser";
