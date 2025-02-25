-- Table: etc.thd_product

-- DROP TABLE IF EXISTS etc.thd_product;

CREATE TABLE IF NOT EXISTS etc.thd_product
(
    running_id integer NOT NULL DEFAULT nextval('etc.thd_id_seq'::regclass),
    itemid character varying COLLATE pg_catalog."default",
    cost_id character varying COLLATE pg_catalog."default",
    vendor_id character varying COLLATE pg_catalog."default",
    filename character varying COLLATE pg_catalog."default",
    load_id uuid,
    date_upload timestamp without time zone,
    uploaded_by timestamp without time zone,
    subsidiary1_id character varying COLLATE pg_catalog."default",
    subsidiary2_id character varying COLLATE pg_catalog."default",
    product_id character varying COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS etc.thd_product
    OWNER to "DUser";