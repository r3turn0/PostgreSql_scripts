-- Table: etc.e_product

-- DROP TABLE IF EXISTS etc.e_product;

CREATE TABLE IF NOT EXISTS etc.e_product
(
    running_id integer NOT NULL DEFAULT nextval('etc.e_product_id_seq'::regclass),
    itemid character varying COLLATE pg_catalog."default",
    cost_id double precision,
    vendor_id character varying COLLATE pg_catalog."default",
    filename character varying COLLATE pg_catalog."default",
    load_id uuid,
    date_upload timestamp without time zone,
    uploaded_by character varying COLLATE pg_catalog."default",
    subsidiary1_id character varying COLLATE pg_catalog."default",
    subsidiary2_id character varying COLLATE pg_catalog."default",
    product_id character varying COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS etc.e_product
    OWNER to "DUser";