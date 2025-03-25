INSERT INTO etc.thd_netsuite_union (vid, item_name, item_size, item_color)
SELECT thd.item_name, thd.item_size, thd.item_color, v.vid FROM etc.vendor v JOIN etc.thd_product thd ON v.vendor_id_thd || ' ' || v.name = thd.vendor WHERE thd.vendor LIKE '%' || v.vendor_id_thd || '%'; 
