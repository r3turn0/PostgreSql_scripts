CREATE OR REPLACE FUNCTION etc.gen_cost_id()
RETURNS TRIGGER AS $$
BEGIN
	-- Error handling for concatenation
	BEGIN
		NEW.cost_id := 'c' || NEW.id;
	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'Error in concatenating ID with letter c';
	END;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_cost
BEFORE INSERT ON etc.cost
FOR EACH ROW
EXECUTE FUNCTION etc.gen_cost_id();

