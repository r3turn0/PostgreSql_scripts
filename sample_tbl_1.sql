CREATE TABLE etc.sample_tbl_1 (
	"id" SERIAL,
	filename VARCHAR NOT NULL,
	date_upload VARCHAR NOT NULL,
	uploaded_by VARCHAR NOT NULL,
	external_id VARCHAR NOT NULL,
	item_id VARCHAR PRIMARY KEY NOT NULL,
	display_name VARCHAR NOT NULL,
	item_name VARCHAR NOT NULL,
	item_number_name VARCHAR NOT NULL,
	vendor_name_code VARCHAR NOT NULL,
	sales_description VARCHAR NOT NULL,
	sales_packaging_unit VARCHAR NOT NULL,
	sale_qty_per_pack_unit VARCHAR NOT NULL,
	item_color VARCHAR NOT NULL,
	item_size VARCHAR NOT NULL,
	pcs_in_box VARCHAR NOT NULL,
	sqft_by_pcs_sheet VARCHAR NULL,
	sqft_by_box VARCHAR NOT NULL,
	price_by_UOM VARCHAR NOT NULL,
	units_type VARCHAR NOT NULL,
	stock_unit VARCHAR NOT NULL,
	purchase_unit VARCHAR NOT NULL,
	sales_units VARCHAR NOT NULL,
	parent VARCHAR NULL,
	subsidiary VARCHAR NOT NULL,
	include_children VARCHAR NULL,
	department VARCHAR NULL,
	"class" VARCHAR NOT NULL,
	"location" VARCHAR NULL,
	costing_method VARCHAR NULL,
	"cost" VARCHAR NOT NULL,
	purchase_description VARCHAR NULL,
	stock_description VARCHAR NULL,
	match_bill_to_receipt VARCHAR NULL,
	use_bins VARCHAR NULL,
	supply_replenishment_method VARCHAR NULL,
	alternate_demand_source_item VARCHAR NULL,
	auto_preferred_stock_level VARCHAR NULL,
	reorder_multiple VARCHAR NULL,
	is_special_order_item VARCHAR NULL,
	auto_reorder_point VARCHAR NULL,
	auto_lead_time VARCHAR NULL,
	lead_time VARCHAR NULL,
	safety_stock_level VARCHAR NULL,
	safety_stock_level_days VARCHAR NULL,
	transfer_price VARCHAR NULL,
	preferred_location VARCHAR NULL,
	item_bin_number1 VARCHAR NULL,
	preferred_per_location VARCHAR NULL,
	vendor1_name VARCHAR NOT NULL,
	vendor1_subsidiary VARCHAR NOT NULL,
	vendor1_preferred VARCHAR NOT NULL,
	vendor1_purchase_price VARCHAR NOT NULL,
	vendor1_schedule VARCHAR NULL,
	vendor1_code VARCHAR NOT NULL,
	vendor2_name VARCHAR NOT NULL,
	vendor2_subsidiary VARCHAR NOT NULL,
	vendor2_preferred VARCHAR NOT NULL,
	vendor2_purchase_price VARCHAR NOT NULL,
	vendor2_code VARCHAR NOT NULL,
	item_location_line1_location VARCHAR NULL,
	item_location_line1_default_return_cost VARCHAR NULL,
	item_location_line1_preferred_stock_level VARCHAR NULL,
	item_location_line1_reorder_print VARCHAR NULL,
	item_location_line1_lot_numbers VARCHAR NULL,
	item_location_line1_lot_sizing_numbers VARCHAR NULL,
	cost_estimate_type VARCHAR NULL,
	cost_estimate VARCHAR NULL,
	minimum_quantity VARCHAR NULL,
	enforce_qty_internally VARCHAR NULL,
	item_price_line1_item_price_type_ref VARCHAR NOT NULL,
	item_price_line1_item_price VARCHAR NOT NULL,
	item_price_line1_quantity_pricing VARCHAR NOT NULL,
	cogs_account VARCHAR NULL,
	income_account VARCHAR NULL,
	asset_account VARCHAR NULL,
	bill_price_variance_acct VARCHAR NULL,
	bill_qty_variance_acct VARCHAR NULL,
	bill_exch_variance_acct VARCHAR NULL,
	cust_return_variance_account VARCHAR NULL,
	vend_return_variance_account VARCHAR NULL,
	tax_schedule VARCHAR NOT NULL
);
SELECT * FROM etc.sample_tbl_1;