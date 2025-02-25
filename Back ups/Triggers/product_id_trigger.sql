-- Trigger: product_id_trigger

-- DROP TRIGGER IF EXISTS product_id_trigger ON etc.load_latest_load;

CREATE OR REPLACE TRIGGER product_id_trigger
    BEFORE INSERT
    ON etc.load_latest_load
    FOR EACH ROW
    EXECUTE FUNCTION etc.gen_product_id();

COMMENT ON TRIGGER product_id_trigger ON etc.load_latest_load
    IS 'This creates an automatic trigger that populates the product_id field with the running_id number concatenated with a "p"';