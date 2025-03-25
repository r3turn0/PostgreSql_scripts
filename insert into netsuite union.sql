INSERT INTO etc.netsuite_union (product_id, vid, item_name, item_color, item_size, vendor_item_code) 
SELECT e.product_id, e.vid, e.item_name, e.item_color, e.item_size, e.vendor_item_code FROM etc.e_netsuite_union e
UNION
SELECT la_nh.product_id, la_nh.vid, la_nh.item_name, la_nh.item_color, la_nh.item_size, la_nh.vendor_item_code FROM etc.la_nh_netsuite_union la_nh
UNION 
SELECT thd.product_id, thd.vid, thd.item_name, thd.item_color, thd.item_size, thd.vendor_item_code FROM etc.thd_netsuite_union thd
UNION
SELECT tm.product_id, tm.vid, tm.item_name, tm.item_color, tm.item_size, tm.vendor_item_code FROM etc.tm_netsuite_union tm


SELECT * FROM etc.netsuite_union