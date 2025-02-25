CREATE TABLE etc.cost (
	"id" SERIAL,
	cost_id VARCHAR PRIMARY KEY,
	product_id VARCHAR,
	subsidiary VARCHAR, 
	"cost" FLOAT, 
	purchase_price FLOAT,
	unit VARCHAR, 
	packaging VARCHAR,
	filename VARCHAR,
	load_id UUID,
	date_upload TIMESTAMP,
	uploaded_by TIMESTAMP
);

CREATE TABLE etc.products (
	"id" SERIAL,
	vendor_product_id VARCHAR PRIMARY KEY,
	item_number VARCHAR,
	item_number_la_nh VARCHAR,
	item_number_thd VARCHAR,
	item_number_tm VARCHAR,
	"name" VARCHAR,
	"size" VARCHAR,
	color VARCHAR,
	finish VARCHAR,
	filename VARCHAR,
	load_id UUID,
	date_upload TIMESTAMP,
	uploaded_by TIMESTAMP	
);