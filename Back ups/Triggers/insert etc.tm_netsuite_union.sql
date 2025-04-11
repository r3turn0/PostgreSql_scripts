SELECT * FROM etc.tm_netsuite_union

INSERT INTO etc.tm_netsuite_union (vid, item_name, item_size, item_color, product_id)
SELECT v.vid, tm.item_name, tm.item_size, tm.item_color, tm.product_id FROM etc.tm_product tm JOIN etc.vendor v ON v.vendor_id_tilemart || ' ' || v.name = tm.vendor1_name;