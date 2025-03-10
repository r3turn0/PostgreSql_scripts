INSERT INTO etc.cost (product_id, "cost", purchase_price, itemid, packaging_unit, filename, load_id, date_upload, uploaded_by, unit, sales_description)
	SELECT
		p.product_id,
		p.cost,
		p.sales_qty_pack_unit,
		p.itemid,
		p.filename,
		p.load_id,
		CAST(p.date_upload AS timestamp),
		p.uploaded_by,
		p.sales_packaging_unit,
		p.salesdescription
	FROM etc.product p;

SELECT * FROM etc.product;
SELECT * FROM etc.cost;