-- Table: etc.rejected

-- DROP TABLE IF EXISTS etc.rejected;

CREATE TABLE IF NOT EXISTS etc.rejected
(
    data json,
    error text COLLATE pg_catalog."default",
    running_id integer NOT NULL DEFAULT nextval('etc.rejected_running_id_seq'::regclass),
    CONSTRAINT rejected_pkey PRIMARY KEY (running_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS etc.rejected
    OWNER to "DUser";