-- PROCEDURE: etc.update_product_tables()

-- DROP PROCEDURE IF EXISTS etc.update_product_tables();

CREATE OR REPLACE PROCEDURE etc.update_product_tables(
	)
LANGUAGE 'sql'

BEGIN ATOMIC
 UPDATE etc.e_product SET running_id = e_product.running_id;
 UPDATE etc.la_nh_product SET running_id = la_nh_product.running_id;
 UPDATE etc.thd_product SET running_id = thd_product.running_id;
 UPDATE etc.tm_product SET running_id = tm_product.running_id;
END;

ALTER PROCEDURE etc.update_product_tables()
    OWNER TO "DUser";
