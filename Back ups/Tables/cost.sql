-- Table: etc.cost

-- DROP TABLE IF EXISTS etc.cost;

CREATE TABLE IF NOT EXISTS etc.cost
(
    running_id integer NOT NULL DEFAULT nextval('etc.cost_id_seq'::regclass),
    cost_id character varying COLLATE pg_catalog."default" NOT NULL,
    product_id character varying COLLATE pg_catalog."default",
    cost double precision,
    purchase_price double precision,
    itemid character varying COLLATE pg_catalog."default",
    packaging_unit character varying COLLATE pg_catalog."default",
    filename character varying COLLATE pg_catalog."default",
    load_id uuid,
    date_upload timestamp without time zone,
    uploaded_by character varying COLLATE pg_catalog."default",
    unit character varying COLLATE pg_catalog."default",
    sales_description character varying COLLATE pg_catalog."default",
    CONSTRAINT cost_pkey PRIMARY KEY (cost_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS etc.cost
    OWNER to "DUser";

-- Trigger: insert_cost_id

-- DROP TRIGGER IF EXISTS insert_cost_id ON etc.cost;

CREATE OR REPLACE TRIGGER insert_cost_id
    BEFORE INSERT
    ON etc.cost
    FOR EACH ROW
    EXECUTE FUNCTION etc.gen_cost_id();