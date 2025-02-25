INSERT INTO etc.cost (cost_id, product_id, subsidiary, "cost", purchase_price, unit, filename, load_id, 
date_upload, uploaded_by)
	SELECT
		'c' || p.product_id,
		p.product_id,
		CASE WHEN p.vendor1_name IS NOT NULL OR p.vendor1_name <> '' 
			THEN split_part(p.vendor1_name, ' ', 1) ELSE 
		CASE WHEN p.vendor2_name IS NOT NULL OR p.vendor2_name <> '' 
			THEN split_part(p.vendor2_name, ' ' , 1) ELSE NULL END 
		END,
		p.cost,
		p.price_by_uom,
		p.unitstype,
		p.filename,
		p.load_id,
		CAST(p.date_upload AS timestamp),
		p.uploaded_by
	FROM etc.product p;

SELECT * FROM etc.product;
SELECT * FROM etc.cost;