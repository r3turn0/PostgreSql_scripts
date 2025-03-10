WITH cte AS (
	SELECT c.cost_id, p.product_id, p.itemid, p.vendor1_subsidiary, p.vendor2_subsidiary FROM etc.cost as c 
	JOIN etc.product p
	ON c.product_id = p.product_id
)
UPDATE etc.la_nh_product la_nh SET cost_id = cte.cost_id, product_id = cte.product_id, 
subsidiary1_id = cte.vendor1_subsidiary, subsidiary2_id = cte.vendor2_subsidiary FROM cte WHERE la_nh.itemid = cte.itemid;
SELECT * FROM etc.la_nh_product;
