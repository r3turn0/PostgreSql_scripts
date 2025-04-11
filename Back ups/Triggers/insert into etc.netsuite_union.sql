SELECT * FROM etc.netsuite_union
INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_size, item_color, vendor_item_code, display_name)
SELECT e.product_id, ep.externalid, v.name, e.vid, e.item_name, e.item_size, e.item_color, e.vendor_item_code, ep.displayname 
FROM etc.e_netsuite_union e JOIN etc.e_product ep ON ep.product_id = e.product_id JOIN etc.vendor v ON v.vid = e.vid; 

UPDATE etc.netsuite_union SET item_type = 'sample' WHERE item_id LIKE '%-S%'
UPDATE etc.netsuite_union SET item_type = 'mfg' WHERE item_id LIKE '%mfg%'
UPDATE etc.netsuite_union SET item_type = 'real' WHERE item_type IS NULL;

INSERT INTO etc.netsuite_union (product_id, item_id, vendor_name, vid, item_name, item_size, item_color, vendor_item_code, display_name)
SELECT tm.product_id, tmp.itemid, v.name, tm.vid, tm.item_name, tm.item_size, tm.item_color, tm.vendor_item_code, tmp.displayname 
FROM etc.tm_netsuite_union tm JOIN etc.tm_product tmp ON tmp.product_id = tm.product_id JOIN etc.vendor v ON v.vid = tm.vid; 