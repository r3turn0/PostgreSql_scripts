INSERT INTO etc.thd_netsuite_union (
	vid,
	item_name,
	item_size,
	item_color
) 
SELECT v.vid, thd.item_name, thd.item_size, thd.item_color FROM etc.thd_product thd JOIN etc.vendor_new v ON thd.vendor = (v.vendor_id_thd || ' ' || v.vendor_name);