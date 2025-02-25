-- Table: etc.upload

-- DROP TABLE IF EXISTS etc.upload;

CREATE TABLE IF NOT EXISTS etc.upload
(
    running_id integer NOT NULL DEFAULT nextval('etc.documents_id_seq'::regclass),
    filename character varying COLLATE pg_catalog."default",
    date_upload timestamp without time zone,
    uid uuid,
    uploaded_by character varying COLLATE pg_catalog."default",
    filepath character varying COLLATE pg_catalog."default",
    load_id uuid
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS etc.upload
    OWNER to "DUser";