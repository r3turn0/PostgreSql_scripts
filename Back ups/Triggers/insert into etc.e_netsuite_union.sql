SELECT * FROM etc.e_netsuite_union
INSERT INTO etc.e_netsuite_union (vid, item_name, item_size, item_color, product_id)
SELECT v.vid, e.item_name, e.item_size, e.item_color, e.product_id 
	FROM etc.e_product e JOIN etc.vendor v ON v.vendor_id_elittile || ' ' || v.name = e.vendor1_name; 
UPDATE etc.e_netsuite_union e1 SET vendor_item_code = e2.vendor1_code FROM etc.e_product e2 WHERE e1.product_id = e2.product_id; 