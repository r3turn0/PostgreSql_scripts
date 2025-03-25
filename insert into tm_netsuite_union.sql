INSERT INTO etc.tm_netsuite_union (vid, item_name, item_size, item_color)
SELECT tm.item_name, tm.item_size, tm.item_color, v.vid FROM etc.vendor_old v JOIN etc.tm_product tm ON v.vendor_id_tilemart || ' ' || v.name = tm.vendor1_name WHERE v.vendor_id_tilemart LIKE '%' || tm.vendor1_name || '%'; 
