-- PROCEDURE: etc.import_data_flow()

-- DROP PROCEDURE IF EXISTS etc.import_data_flow();

CREATE OR REPLACE PROCEDURE etc.import_data_flow(
	)
LANGUAGE 'sql'
AS $BODY$
-- Update product subsidiary tables with product_ids with update_product_tables() assuming the auto trigger has been set up to update product_ids
--  UPDATE etc.e_product SET running_id = running_id;
--  UPDATE etc.la_nh_product SET running_id = running_id;
--  UPDATE etc.thd_product SET running_id = running_id;
--  UPDATE etc.tm_product SET running_id = running_id;

-- -- Insert data into the product netsuite tables with insert_into_product_netsuite_tables()
-- INSERT INTO etc.e_netsuite_union(
-- 	vid, item_name, item_size, item_color, vendor_item_code, product_id
-- ) SELECT v.vid, e.item_name, e.item_size, e.item_color, e.vendor1_code, e.product_id FROM etc.e_product e
-- 	JOIN etc.vendor_new v ON v.vendor_id_elittile || ' ' || v.vendor_name = e.vendor1_name WHERE e.pid IS NULL;
-- INSERT INTO etc.la_nh_netsuite_union(
-- 	vid, item_name, item_size, item_color, vendor_item_code, product_id
-- ) SELECT v.vid, lanh.item_name, lanh.item_size, lanh.item_color, lanh.vendor1_code, lanh.product_id FROM etc.la_nh_product lanh
-- 	JOIN etc.vendor_new v ON v.vendor_id_la_nh || ' ' || v.vendor_name = lanh.vendor1_name WHERE lanh.pid IS NULL;
-- INSERT INTO etc.thd_netsuite_union(
-- 	vid, item_name, item_size, item_color, product_id
-- ) SELECT v.vid, thd.item_name, thd.item_size, thd.item_color, thd.product_id FROM etc.thd_product thd
-- 	JOIN etc.vendor_new v ON v.vendor_id_thd || ' ' || v.vendor_name = thd.vendor WHERE thd.pid IS NULL;
-- INSERT INTO etc.tm_netsuite_union(
-- 	vid, item_name, item_size, item_color, vendor_item_code, product_id
-- ) SELECT v.vid, tm.item_name, tm.item_size, tm.item_color, tm.vendor_code, tm.product_id FROM etc.tm_product tm
-- 	JOIN etc.vendor_new v ON v.vendor_id_tilemart || ' ' || v.vendor_name = tm.vendor1_name WHERE tm.pid IS NULL;

-- Insert data into the netsuite union table with insert_into_netsuite_union_tables()
-- INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_color, item_size, vendor_item_code, display_name)
-- SELECT en.product_id, e.externalid, v.vendor_name, v.vid, en.item_name, en.item_size, en.item_color, en.vendor_item_code, e.displayname 
-- FROM etc.e_netsuite_union en JOIN etc.e_product e ON en.product_id = e.product_id
-- JOIN etc.vendor_new v ON v.vid = en.vid;

-- INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_color, item_size, vendor_item_code, display_name)
-- SELECT lanh_n.product_id, la_nh.externalid, v.vendor_name, v.vid, lanh_n.item_name, lanh_n.item_size, lanh_n.item_color, lanh_n.vendor_item_code, la_nh.displayname 
-- FROM etc.la_nh_netsuite_union lanh_n JOIN etc.la_nh_product la_nh ON lanh_n.product_id = la_nh.product_id
-- JOIN etc.vendor_new v ON v.vid = lanh_n.vid;

-- INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_color, item_size, vendor_item_code, display_name)
-- SELECT thd_n.product_id, thd.name, v.vendor_name, v.vid, thd_n.item_name, thd_n.item_size, thd_n.item_color, thd_n.vendor_item_code, thd.display_name 
-- FROM etc.thd_netsuite_union thd_n JOIN etc.thd_product thd ON thd_n.product_id = thd.product_id
-- JOIN etc.vendor_new v ON v.vid = thd_n.vid;

-- INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_color, item_size, vendor_item_code, display_name)
-- SELECT tm_n.product_id, tm.name, v.vendor_name, v.vid, tm_n.item_name, tm_n.item_size, tm_n.item_color, tm_n.vendor_item_code, tm.display_name 
-- FROM etc.thd_netsuite_union tm_n JOIN etc.thd_product tm ON tm_n.product_id = tm.product_id
-- JOIN etc.vendor_new v ON v.vid = tm_n.vid;

-- Update item types with update_item_types()
-- UPDATE etc.netsuite_union SET item_type = 'sample' WHERE item_id ILIKE '%-S%';
-- UPDATE etc.netsuite_union SET item_type = 'mfg' WHERE item_id ILIKE '%mfg%';
-- UPDATE etc.netsuite_union SET item_type = 'real' WHERE item_type <> 'sample' AND item_type <> 'mfg';

-- Insert into products table with products_to_product()
-- INSERT INTO etc.products (product_id, vendor_name, item_type, vid, item_name, item_color, item_size, vendor_item_code)
-- SELECT product_id, vendor_name, item_type, vid, item_name, item_color, item_size, vendor_item_code FROM etc.netsuite_union;

-- Generate PIDs
-- UPDATE etc.products SET pid = (SELECT etc.uuid_generate_v3('00000000-0000-0000-0000-000000000000', vid || ' ' || item_name || ' ' || item_size || ' ' || item_color || ' ' || vendor_item_code)) WHERE pid IS NULL;

-- Insert into product table
-- INSERT INTO etc.product (vid, item_name, item_size, item_color, pid)
-- SELECT p.vid, p.item_name, p.item_size, p.item_color, p.pid::UUID FROM etc.products p GROUP BY p.vid, p.item_name, p.item_size, p.item_color, p.pid;

DO $$
BEGIN
	CALL etc.update_product_tables();
	BEGIN
	    CALL etc.insert_into_product_netsuite_tables();
		EXCEPTION
		    WHEN OTHERS THEN
		        ROLLBACK;
		        RAISE NOTICE 'Error in insert_into_product_netsuite_tables';
	END;
	BEGIN
	    CALL etc.insert_into_netsuite_union_tables();
	EXCEPTION
	    WHEN OTHERS THEN
	        ROLLBACK;
	        RAISE NOTICE 'Error in insert_into_netsuite_union_tables';
	END;
	
	BEGIN
	    CALL etc.update_item_types();
	EXCEPTION
	    WHEN OTHERS THEN
	        ROLLBACK;
	        RAISE NOTICE 'Error in update_item_types';
	END;
	
	BEGIN
	    CALL etc.products_to_product();
	EXCEPTION
	    WHEN OTHERS THEN
	        ROLLBACK;
	        RAISE NOTICE 'Error in products_to_product';
	END;
END; $$;

$BODY$;
ALTER PROCEDURE etc.import_data_flow()
    OWNER TO "DUser";
