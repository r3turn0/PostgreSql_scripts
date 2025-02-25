ALTER TABLE etc.cost DROP CONSTRAINT id;
ALTER TABLE etc.cost 
	ADD PRIMARY KEY (cost_id);

ALTER TABLE etc.product 
	ADD PRIMARY KEY (product_id);