CREATE OR REPLACE FUNCTION etc.gen_product_id()
RETURNS TRIGGER AS $$
BEGIN
	-- Error handling for concatenation
	BEGIN
		NEW.product_id := 'p' || NEW.id;
	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'Error in concatenating ID with letter p';
	END;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_product_id
BEFORE INSERT ON etc.product
FOR EACH ROW
EXECUTE FUNCTION etc.gen_product_id();