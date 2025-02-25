-- Trigger: insert_cost_id

-- DROP TRIGGER IF EXISTS insert_cost_id ON etc.cost;

CREATE OR REPLACE TRIGGER insert_cost_id
    BEFORE INSERT
    ON etc.cost
    FOR EACH ROW
    EXECUTE FUNCTION etc.gen_cost_id();