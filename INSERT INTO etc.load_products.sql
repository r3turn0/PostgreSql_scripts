-- FROM etc.e_product
INSERT INTO etc.load_products (vendor, subsidiary, location, item_id, display_name, item_name, item_size, item_color, cost, netsuite_id)
SELECT e.vendor1_name, e.subsidiary, e.location, e.externalid, e.displayname, e.item_name, e.item_size, e.item_color, e.cost, e.internal_id FROM etc.e_product e WHERE e.pid IS NULL;

UPDATE etc.load_products SET product_id = e.product_id FROM etc.e_product e WHERE item_id = e.externalid; 

UPDATE etc.load_products p SET pid = (SELECT etc.uuid_generate_v3('00000000-0000-0000-0000-000000000000', e.item_name || ' ' || e.item_size || ' ' || e.item_color || ' ' || e.internal_id)) FROM etc.e_product e WHERE e.product_id = p.product_id;

-- FROM etc.e_shopify
INSERT INTO etc.load_products(vendor, item_id, display_name, item_size, item_color, cost, product_id)
SELECT e.vendor, e.variant_sku, e.title, e.option1_value, e.option2_value, e.variant_price, e.product_id FROM etc.e_shopify e WHERE e.pid IS NULL;

UPDATE etc.load_products p SET pid = (SELECT etc.uuid_generate_v3('00000000-0000-0000-0000-000000000000', title || ' ' || NULL)) FROM etc.e_shopify es WHERE es.product_id = p.product_id;

-- FROM etc.la_nh_product
INSERT INTO etc.load_products(vendor, subsidiary, location, item_id, display_name, item_name, item_size, item_color, cost, product_id, netsuite_id)
SELECT l.vendor1_name, l.subsidiary, l.location, l.externalid, l.displayname, l.item_name, l.item_size, l.item_color, l.cost, l.product_id, 
CASE WHEN l.internalid = '' THEN NULL ELSE l.internalid::numeric END FROM etc.la_nh_product l WHERE l.pid IS NULL;

UPDATE etc.load_products p SET pid = (SELECT etc.uuid_generate_v3('00000000-0000-0000-0000-000000000000', lanh.item_name || ' ' || lanh.item_size || ' ' || lanh.item_color || ' ' || lanh.internalid)) FROM etc.la_nh_product lanh WHERE lanh.product_id = p.product_id;

-- FROM etc.thd_product
INSERT INTO etc.load_products(vendor, subsidiary, location, item_id, display_name, item_name, item_size, item_color, cost, product_id, netsuite_id)
SELECT t.vendor, t.subsidiary, t.location, t.name, t.display_name, t.item_name, t.item_size, t.item_color, t.unit_price, t.product_id, t.internal_id FROM etc.thd_product t WHERE t.pid IS NULL;

UPDATE etc.load_products p SET pid = (SELECT etc.uuid_generate_v3('00000000-0000-0000-0000-000000000000', thd.display_name || ' ' || thd.internal_id)) FROM etc.thd_product thd WHERE thd.product_id = p.product_id;

-- FROM etc.tm_product
INSERT INTO etc.load_products(vendor, subsidiary, location, item_id, display_name, item_name, item_size, item_color, cost, product_id)
SELECT t.vendor1_name, t.subsdiary, t.location, t.externalid, t.displayname, t.item_name, t.item_size, t.item_color, t.cost, t.product_id FROM etc.tm_product t WHERE t.pid IS NULL;

UPDATE etc.load_products p SET pid = (SELECT etc.uuid_generate_v3('00000000-0000-0000-0000-000000000000', tm.item_name || ' ' || NULL)) FROM etc.tm_product tm WHERE tm.product_id = p.product_id;

-- FROM etc.tm_shopify
INSERT INTO etc.load_products(vendor, item_id, display_name, item_size, item_color, cost, product_id)
SELECT t.vendor, t.variant_sku, t.title, CASE WHEN t.option1_name LIKE '%Size%' THEN t.option1_value ELSE '' END, t.option2_value, t.variant_price, t.product_id 
FROM etc.tm_shopify t WHERE t.variant_price <> 0 AND t.pid IS NULL;

-- UPDATE load_products with pids
UPDATE etc.load_products p SET pid = (SELECT etc.uuid_generate_v3('00000000-0000-0000-0000-000000000000', tm.title || ' ' || NULL)) FROM etc.tm_shopify tm WHERE tm.product_id = p.product_id;

-- UPDATE product_old with pids
UPDATE etc.product_old po SET pid = p.pid FROM etc.load_products p WHERE po.display_name = p.display_name;
UPDATE etc.product_old po SET pid = (SELECT etc.uuid_generate_v3('00000000-0000-0000-0000-000000000000', po.display_name || ' ' || NULL))

-- UPDATE e_product, e_shopify, la_nh_product, thd_product, tm_product, tm_shopify
UPDATE etc.e_product e SET pid = p.pid FROM etc.load_products p WHERE e.product_id = p.product_id;
UPDATE etc.e_shopify e SET pid = p.pid FROM etc.load_products p WHERE e.product_id = p.product_id;
UPDATE etc.la_nh_product l SET pid = p.pid FROM etc.load_products p WHERE l.product_id = p.product_id;
UPDATE etc.thd_product t SET pid = p.pid FROM etc.load_products p WHERE t.product_id = p.product_id;
UPDATE etc.tm_product t SET pid = p.pid FROM etc.load_products p WHERE t.product_id = p.product_id;
UPDATE etc.tm_shopify t SET pid = p.pid FROM etc.load_products p WHERE t.product_id = p.product_id;