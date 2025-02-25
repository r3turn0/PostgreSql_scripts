INSERT INTO etc.la_nh (item_number, cost_id, vendor_id, filename, load_id, 
date_upload, uploaded_by)
	SELECT 
		p.itemid,
		c.cost_id, 
		CASE WHEN p.vendor1_name IS NOT NULL OR p.vendor1_name <> '' 
			THEN split_part(p.vendor1_name, ' ', 1) ELSE 
		CASE WHEN p.vendor2_name IS NOT NULL OR p.vendor2_name <> '' 
			THEN split_part(p.vendor2_name, ' ' , 1) ELSE NULL END 
		END,
		p.filename,
		p.load_id,
		CAST(p.date_upload AS timestamp),
		p.uploaded_by
	FROM etc.product p JOIN etc.cost c ON c.cost_id = p.product_id;