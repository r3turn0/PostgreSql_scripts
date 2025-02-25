-- Table: etc.class_table

-- DROP TABLE IF EXISTS etc.class_table;

CREATE TABLE IF NOT EXISTS etc.class
(
    class integer,
    group_name character varying COLLATE pg_catalog."default",
    filename character varying COLLATE pg_catalog."default",
    load_id uuid,
    date_upload timestamp without time zone,
    uploaded_by character varying COLLATE pg_catalog."default",
    running_id integer NOT NULL DEFAULT nextval('etc.class_id_seq'::regclass)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS etc.class_table
    OWNER to "DUser";