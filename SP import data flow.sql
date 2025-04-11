CREATE PROCEDURE importDataFlow()
	BEGIN
		-- Update product_ids in each subsidiary, assuming CSV to staging, staging to product tables worked
		EXECUTE IMMEDIATE 'UPDATE etc.e_product SET running_id = running_id;';
		EXECUTE IMMEDIATE 'UPDATE etc.la_nh_product SET running_id = running_id;';
		EXECUTE IMMEDIATE 'UPDATE etc.thd_product SET running_id = running_id;';
		EXECUTE IMMEDIATE 'UPDATE etc.tm_product SET running_id = running_id;';
		EXCEPTION
			WHEN OTHERS THEN
			ROLLBACK;
	END;

	COMMIT;
	BEGIN
		EXECUTE IMMEDIATE 'INSERT INTO etc.e_netsuite_union(
			vid, item_name, item_size, item_color, vendor_item_code, product_id
		) SELECT v.vid, e.item_name, e.item_size, e.item_color, e.vendor1_code, e.product_id FROM etc.e_product e
			JOIN etc.vendor_new v ON v.vendor_id_elittile || '' '' || v.vendor_name = e.vendor1_name;';
		EXECUTE IMMEDIATE 'INSERT INTO etc.la_nh_netsuite_union(
			pid, vid, item_name, item_size, item_color, vendor_item_code, product_id
		) SELECT v.vid, lanh.item_name, lanh.item_size, lanh.item_color, lanh.vendor1_code, lanh.product_id FROM etc.la_nh_product lanh
			JOIN etc.vendor_new v ON v.vendor_id_la_nh || '' '' || v.vendor_name = lanh.vendor1_name;';
		EXECUTE IMMEDIATE 'INSERT INTO etc.thd_netsuite_union(
			pid, vid, item_name, item_size, item_color, product_id
		) SELECT v.vid, thd.item_name, thd.item_size, thd.item_color, thd.product_id FROM etc.thd_product thd
			JOIN etc.vendor_new v ON v.vendor_id_thd || '' '' || v.vendor_name = thd.vendor;';
		EXECUTE IMMEDIATE 'INSERT INTO etc.tm_netsuite_union(
			pid, vid, item_name, item_size, item_color, vendor_item_code, product_id
		) SELECT v.vid, tm.item_name, tm.item_size, tm.item_color, tm.product_id FROM etc.tm_product tm
			JOIN etc.vendor_new v ON v.vendor_id_tilemart || '' '' || v.vendor_name = tm.vendor1_name;';
	EXCEPTION
		WHEN OTHERS THEN
		ROLLBACK;
	END;

	COMMIT;
	BEGIN
		EXECUTE IMMEDIATE 'INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_color, item_size, vendor_item_code, display_name)
		SELECT en.product_id, e.externalid, v.vendor_name, v.vid, en.item_name, en.item_size, en.item_color, en.vendor_item_code, e.displayname 
		FROM etc.e_netsuite_union en JOIN etc.e_product e ON en.product_id = e.product_id
		JOIN etc.vendor_new v ON v.vid = en.vid;';
	
		EXECUTE IMMEDIATE 'INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_color, item_size, vendor_item_code, display_name)
		SELECT lanh_n.product_id, la_nh.externalid, v.vendor_name, v.vid, lanh_n.item_name, lanh_n.item_size, lanh_n.item_color, lanh_n.vendor_item_code, la_nh.displayname 
		FROM etc.la_nh_netsuite_union lanh_n JOIN etc.la_nh_product la_nh ON lanh_n.product_id = la_nh.product_id
		JOIN etc.vendor_new v ON v.vid = lanh_n.vid;';
	
		EXECUTE IMMEDIATE 'INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_color, item_size, vendor_item_code, display_name)
		SELECT thd_n.product_id, thd.name, v.vendor_name, v.vid, thd_n.item_name, thd_n.item_size, thd_n.item_color, thd_n.vendor_item_code, thd.display_name 
		FROM etc.thd_netsuite_union thd_n JOIN etc.thd_product thd ON thd_n.product_id = thd.product_id
		JOIN etc.vendor_new v ON v.vid = thd_n.vid;';
	
		EXECUTE IMMEDIATE 'INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_color, item_size, vendor_item_code, display_name)
		SELECT tm_n.product_id, tm.name, v.vendor_name, v.vid, tm_n.item_name, tm_n.item_size, tm_n.item_color, tm_n.vendor_item_code, tm.display_name 
		FROM etc.thd_netsuite_union tm_n JOIN etc.thd_product tm ON tm_n.product_id = tm.product_id
		JOIN etc.vendor_new v ON v.vid = tm_n.vid;';
	EXCEPTION
		WHEN OTHERS THEN
		ROLLBACK;
	END;

-- 	COMMIT;
-- 	BEGIN
-- 		EXECUTE IMMEDIATE 'UPDATE etc.netsuite_union SET item_type = ''sample'' WHERE item_id ILIKE ''%-S%'';';
-- 		EXECUTE IMMEDIATE 'UPDATE etc.netsuite_union SET item_type = ''mfg'' WHERE item_id ILIKE ''%mfg%'';';
-- 		EXECUTE IMMEDIATE 'UPDATE etc.netsuite_union SET item_type = ''real'' WHERE item_type <> ''sample'' AND item_type <> ''mfg'';';
-- 	EXCEPTION
-- 		WHEN OTHERS THEN
-- 		ROLLBACK;
-- 	END;	

-- 	COMMIT;
-- 	BEGIN
		EXECUTE IMMEDIATE 'INSERT INTO etc.products (product_id, vendor_name, item_type, vid, item_name, item_color, item_size, vendor_item_code)
		SELECT n.product_id, n.vendor_name, n.item_type, n.vid, n.item_name, n.item_color, n.item_size, n.vendor_item_code FROM etc.netsuite_union;';

		EXECUTE IMMEDIATE 'UPDATE etc.products SET pid = (SELECT etc.uuid_generate_v3(''00000000-0000-0000-0000-000000000000'', item_name || '' '' || item_size || '' '' || item_color || '' '' || vendor_item_code)) WHERE pid IS NULL;';

		EXECUTE IMMEDIATE 'INSERT INTO etc.product (vendor_name, pid, display_name, item_id, product_id)
		SELECT p.vendor_name, p.pid, (p.item_name || '' '' || p.item_size || '' '' || p.item_color) as display_name, string_agg(n.item_id, '', '') as item_ids, p.product_id FROM etc.products p
		JOIN etc.netsuite_union n ON p.product_id = n.product_id GROUP BY p.pid, p.vendor_name, p.item_name, p.item_size, p.item_color, p.product_id;';
-- 	EXCEPTION
-- 		WHEN OTHERS THEN
-- 		ROLLBACK;
END$$

DELIMITER ;	END;
-- END;
$$;