-- Table: etc.vendor

-- DROP TABLE IF EXISTS etc.vendor;

CREATE TABLE IF NOT EXISTS etc.vendor
(
    vendor_id integer NOT NULL,
    name character varying COLLATE pg_catalog."default",
    vendor_id_la_nh character varying COLLATE pg_catalog."default",
    vendor_id_elittile character varying COLLATE pg_catalog."default",
    vendor_id_thd character varying COLLATE pg_catalog."default",
    vendor_id_tilemart character varying COLLATE pg_catalog."default",
    name_tilemart character varying COLLATE pg_catalog."default",
    filename character varying COLLATE pg_catalog."default",
    load_id uuid,
    date_upload timestamp without time zone,
    uploaded_by character varying COLLATE pg_catalog."default",
    running_id integer NOT NULL DEFAULT nextval('etc.vendor_running_id_seq'::regclass),
    CONSTRAINT vendor_pkey PRIMARY KEY (vendor_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS etc.vendor
    OWNER to "DUser";