-- PROCEDURE: etc.products_to_product()

-- DROP PROCEDURE IF EXISTS etc.products_to_product();

CREATE OR REPLACE PROCEDURE etc.products_to_product(
	)
LANGUAGE 'sql'
AS $BODY$
INSERT INTO etc.products (product_id, vendor_name, item_type, vid, item_name, item_color, item_size, vendor_item_code)
SELECT product_id, vendor_name, item_type, vid, item_name, item_color, item_size, vendor_item_code FROM etc.netsuite_union;

UPDATE etc.products SET pid = (SELECT etc.uuid_generate_v3('00000000-0000-0000-0000-000000000000', vid || ' ' || item_name || ' ' || item_size || ' ' || item_color || ' ' || vendor_item_code)) WHERE pid IS NULL;

INSERT INTO etc.product (vid, item_name, item_size, item_color, pid)
SELECT p.vid, p.item_name, p.item_size, p.item_color, p.pid::UUID FROM etc.products p GROUP BY p.vid, p.item_name, p.item_size, p.item_color, p.pid;
$BODY$;
ALTER PROCEDURE etc.products_to_product()
    OWNER TO "DUser";
