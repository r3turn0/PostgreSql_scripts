-- Table: etc.user

-- DROP TABLE IF EXISTS etc."user";

CREATE TABLE IF NOT EXISTS etc."user"
(
    running_id integer NOT NULL DEFAULT nextval('etc.users_id_seq'::regclass),
    first_name character varying COLLATE pg_catalog."default" NOT NULL,
    last_name character varying COLLATE pg_catalog."default" NOT NULL,
    user_id uuid NOT NULL DEFAULT gen_random_uuid(),
    email character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS etc."user"
    OWNER to "DUser";