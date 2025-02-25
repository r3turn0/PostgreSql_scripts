-- Table: etc.la_nh_product

-- DROP TABLE IF EXISTS etc.la_nh_product;

CREATE TABLE IF NOT EXISTS etc.la_nh_product
(
    running_id integer NOT NULL DEFAULT nextval('etc.la_nh_id_seq'::regclass),
    itemid character varying COLLATE pg_catalog."default",
    cost_id character varying COLLATE pg_catalog."default",
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

ALTER TABLE IF EXISTS etc.la_nh_product
    OWNER to "DUser";