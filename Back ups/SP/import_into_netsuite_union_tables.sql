-- PROCEDURE: etc.insert_into_netsuite_union_tables()

-- DROP PROCEDURE IF EXISTS etc.insert_into_netsuite_union_tables();

CREATE OR REPLACE PROCEDURE etc.insert_into_netsuite_union_tables(
	)
LANGUAGE 'sql'
AS $BODY$
INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_color, item_size, vendor_item_code, display_name)
SELECT en.product_id, e.externalid, v.vendor_name, v.vid, en.item_name, en.item_size, en.item_color, en.vendor_item_code, e.displayname 
FROM etc.e_netsuite_union en JOIN etc.e_product e ON en.product_id = e.product_id
JOIN etc.vendor_new v ON v.vid = en.vid WHERE e.pid IS NULL;

INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_color, item_size, vendor_item_code, display_name)
SELECT lanh_n.product_id, la_nh.externalid, v.vendor_name, v.vid, lanh_n.item_name, lanh_n.item_size, lanh_n.item_color, lanh_n.vendor_item_code, la_nh.displayname 
FROM etc.la_nh_netsuite_union lanh_n JOIN etc.la_nh_product la_nh ON lanh_n.product_id = la_nh.product_id 
JOIN etc.vendor_new v ON v.vid = lanh_n.vid WHERE la_nh.pid IS NULL;

INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_color, item_size, vendor_item_code, display_name)
SELECT thd_n.product_id, thd.name, v.vendor_name, v.vid, thd_n.item_name, thd_n.item_size, thd_n.item_color, thd_n.vendor_item_code, thd.display_name 
FROM etc.thd_netsuite_union thd_n JOIN etc.thd_product thd ON thd_n.product_id = thd.product_id
JOIN etc.vendor_new v ON v.vid = thd_n.vid WHERE thd.pid IS NULL;

INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_color, item_size, vendor_item_code, display_name)
SELECT tm_n.product_id, tm.name, v.vendor_name, v.vid, tm_n.item_name, tm_n.item_size, tm_n.item_color, tm_n.vendor_item_code, tm.display_name 
FROM etc.thd_netsuite_union tm_n JOIN etc.thd_product tm ON tm_n.product_id = tm.product_id 
JOIN etc.vendor_new v ON v.vid = tm_n.vid WHERE tm.pid IS NULL;
$BODY$;
ALTER PROCEDURE etc.insert_into_netsuite_union_tables()
    OWNER TO "DUser";
