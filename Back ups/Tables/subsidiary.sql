-- Table: etc.subsidiary

-- DROP TABLE IF EXISTS etc.subsidiary;

CREATE TABLE IF NOT EXISTS etc.subsidiary
(
    internal_id integer NOT NULL,
    name character varying COLLATE pg_catalog."default",
    code character varying COLLATE pg_catalog."default",
    filename character varying COLLATE pg_catalog."default",
    load_id uuid,
    date_upload timestamp without time zone,
    uploaded_by character varying COLLATE pg_catalog."default",
    running_id integer NOT NULL DEFAULT nextval('etc.subsidiary_id_seq'::regclass),
    netsuite_name character varying COLLATE pg_catalog."default",
    CONSTRAINT subsidiary_pkey PRIMARY KEY (internal_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS etc.subsidiary
    OWNER to "DUser";