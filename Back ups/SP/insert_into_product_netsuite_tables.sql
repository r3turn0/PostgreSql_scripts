-- PROCEDURE: etc.insert_into_product_netsuite_tables()

-- DROP PROCEDURE IF EXISTS etc.insert_into_product_netsuite_tables();

CREATE OR REPLACE PROCEDURE etc.insert_into_product_netsuite_tables(
	)
LANGUAGE 'sql'
AS $BODY$
INSERT INTO etc.e_netsuite_union(
	vid, item_name, item_size, item_color, vendor_item_code, product_id
) SELECT v.vid, e.item_name, e.item_size, e.item_color, e.vendor1_code, e.product_id FROM etc.e_product e
	JOIN etc.vendor_new v ON v.vendor_id_elittile || ' ' || v.vendor_name = e.vendor1_name;
INSERT INTO etc.la_nh_netsuite_union(
	vid, item_name, item_size, item_color, vendor_item_code, product_id
) SELECT v.vid, lanh.item_name, lanh.item_size, lanh.item_color, lanh.vendor1_code, lanh.product_id FROM etc.la_nh_product lanh
	JOIN etc.vendor_new v ON v.vendor_id_la_nh || ' ' || v.vendor_name = lanh.vendor1_name;
INSERT INTO etc.thd_netsuite_union(
	vid, item_name, item_size, item_color, product_id
) SELECT v.vid, thd.item_name, thd.item_size, thd.item_color, thd.product_id FROM etc.thd_product thd
	JOIN etc.vendor_new v ON v.vendor_id_thd || ' ' || v.vendor_name = thd.vendor;;
INSERT INTO etc.tm_netsuite_union(
	vid, item_name, item_size, item_color, vendor_item_code, product_id
) SELECT v.vid, tm.item_name, tm.item_size, tm.item_color, tm.vendor_code, tm.product_id FROM etc.tm_product tm
	JOIN etc.vendor_new v ON v.vendor_id_tilemart || ' ' || v.vendor_name = tm.vendor1_name;
$BODY$;
ALTER PROCEDURE etc.insert_into_product_netsuite_tables()
    OWNER TO "DUser";
