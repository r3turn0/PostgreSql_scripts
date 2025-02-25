-- Table: etc.uom

-- DROP TABLE IF EXISTS etc.uom;

CREATE TABLE IF NOT EXISTS etc.uom
(
    running_id integer NOT NULL DEFAULT nextval('etc.uom_id_seq'::regclass),
    filename character varying COLLATE pg_catalog."default" NOT NULL,
    date_upload character varying COLLATE pg_catalog."default" NOT NULL,
    uploaded_by character varying COLLATE pg_catalog."default" NOT NULL,
    item_type_name character varying COLLATE pg_catalog."default" NOT NULL,
    internal_id character varying COLLATE pg_catalog."default",
    unit_name character varying COLLATE pg_catalog."default" NOT NULL,
    plural_name character varying COLLATE pg_catalog."default" NOT NULL,
    abbreviation character varying COLLATE pg_catalog."default" NOT NULL,
    plural_abbreviation character varying COLLATE pg_catalog."default" NOT NULL,
    conversion_rate_base character varying COLLATE pg_catalog."default" NOT NULL,
    base_unit character varying COLLATE pg_catalog."default" NOT NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS etc.uom
    OWNER to "DUser";