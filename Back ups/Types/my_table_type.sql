-- Type: my_table_type

-- DROP TYPE IF EXISTS etc.my_table_type;

CREATE TYPE etc.my_table_type AS
(
	column_name text,
	data_type text
);

ALTER TYPE etc.my_table_type
    OWNER TO "DUser";
