SELECT * FROM etc.netsuite_union

SELECT pid FROM etc.product GROUP BY pid;
INSERT INTO etc.product (product_id, pid, vendor_name, item_type, vid, item_name, item_size, item_color, vendor_item_code)
SELECT n.product_id, n.pid, n.vendor_name, n.item_type, n.vid, n.item_name, n.item_size, n.item_color, n.vendor_item_code FROM etc.netsuite_union n GROUP BY ROLLUP(n.pid), n.product_id, n.pid, n.vendor_name, n.item_type, n.vid, n.item_name, n.item_size, n.item_color, n.vendor_item_code 




UPDATE etc.product SET pid = (SELECT etc.uuid_generate_v3('00000000-0000-0000-0000-000000000000', item_name || ' ' || item_size || ' ' || item_color || ' ' || vendor_item_code)) WHERE pid isnull;

CREATE TABLE etc.product (product_id, pid, vendor_name, item_type, vid, item_name, item_size, item_color, vendor_item_code, cost)
SELECT *, c.cost FROM etc.nesuite_union n 