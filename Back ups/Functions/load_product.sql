-- FUNCTION: etc.load_product()

-- DROP FUNCTION IF EXISTS etc.load_product();

CREATE OR REPLACE FUNCTION etc.load_product(
	)
    RETURNS void
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
-- INSERT INTO etc.load_product (
-- 	vendor_name_code,
-- 	subsidiary,
-- 	location,
-- 	item_id,
-- 	display_name,
-- 	item_color,
-- 	item_size,
-- 	cost,
-- 	product_id,
-- 	netsuite_id,
-- 	pid)
-- SELECT vendor_code, subsdiary, location, itemid, displayname, item_color,
-- item_size, cost, product_id, internalid::numeric, pid FROM etc.tm_product
-- UNION
-- SELECT vendor, 'Tilemart Shopify', null, variant_sku, title, 
-- option2_value, option1_value, variant_cost, product_id, null, pid FROM etc.tm_shopify
-- UNION
-- SELECT vendor_name_code, subsidiary, location, name, display_name, item_color, item_size, unit_price, product_id, 
-- CASE WHEN internal_id::numeric, pid FROM etc.thd_product
-- UNION
-- SELECT vendor_name_code, subsidiary, location, itemid, displayname, item_color, item_size, cost, 
-- product_id, internalid::numeric, pid FROM etc.la_nh_product
-- UNION
-- SELECT vendor, 'Elit Tile Shopify', null, variant_sku, title, option2_value, option1_value,  
-- variant_cost, product_id, id::numeric, pid FROM etc.e_shopify
-- UNION
-- SELECT vendor_name_code, subsidiary, location, externalid, item_number_and_name, item_color, 
-- item_size, cost, product_id, internal_id::numeric, pid FROM etc.e_product         
$BODY$;

ALTER FUNCTION etc.load_product()
    OWNER TO "DUser";
