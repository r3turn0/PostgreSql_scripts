SELECT * FROM etc.la_nh_netsuite_union


INSERT INTO etc.la_nh_netsuite_union (
	vid,
	item_name,
	item_size,
	item_color,
	product_id
)
SELECT v.vid, la_nh.item_name, la_nh.item_size, la_nh.item_color, la_nh.product_id FROM
etc.la_nh_product la_nh JOIN etc.vendor_new v ON v.vendor_id_la_nh || ' ' || v.vendor_name = la_nh.vendor1_name WHERE la_nh.pid IS NULL;

INSERT INTO etc.netsuite_union (
	product_id,
	item_id,
	vendor_name,
	vid, 
	item_name, 
	item_color,
	item_size,
	vendor_item_code,
	display_name
)
SELECT l_n.product_id, la_nh.itemid, la_nh.vendor1_name, l_n.vid, l_n.item_name, l_n.item_color, l_n.item_size, la_nh.vendor1_code, la_nh.displayname FROM etc.la_nh_product la_nh
JOIN etc.la_nh_netsuite_union l_n ON l_n.product_id = la_nh.product_id WHERE l_n.pid is NULL;