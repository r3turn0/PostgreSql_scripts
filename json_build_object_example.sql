SELECT json_build_object(
	'internalid', internal_id, 
	'ITEM NUMBER', json_build_object('Label', 'ITEM NUMBER','Field ID', 'itemid','Value', externalid),  
	'PRICE BY UOM', json_build_object('Label', 'PRICE BY UOM', 'Field ID', 'custitem_bit_sales_pack_unit', 'Value', price_by_uom),
	'PURCHASE PRICE', json_build_object('Label', 'PURCHASE PRICE', 'Field ID', 'cost', 'Value', cost)
) as inventory_item FROM etc.e_product;


SELECT * FROM staging.e_shopify;

SELECT etc.copy_table_with_types('staging.e_shopify', 'staging.e_shopify_typed');