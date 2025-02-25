CREATE VIEW etc.la_nh_product_view AS 
SELECT lanh.running_id, lanh.item_number, lanh.subsidiary1_id as vendor1, lanh.subsidiary2_id as vendor2, 
lanh.vendor_id as subsidiary, c.cost as cost, c.purchase_price as purchase_price FROM etc.la_nh_product lanh
JOIN etc.cost c ON lanh.item_number = c.item_number;
SELECT * FROM etc.la_nh_product_view;


CREATE VIEW etc.e_product_view AS 
SELECT e.running_id, e.item_number, e.subsidiary1_id as vendor1, e.subsidiary2_id as vendor2, 
e.vendor_id as subsidiary, c.cost as cost, c.purchase_price as purchase_price FROM etc.e_product e
JOIN etc.cost c ON e.item_number = c.item_number;
SELECT * FROM etc.e_product_view;

CREATE VIEW etc.thd_product_view AS 
SELECT thd.running_id, thd.item_number, thd.subsidiary1_id as vendor1, thd.subsidiary2_id as vendor2, 
thd.vendor_id as subsidiary, c.cost as cost, c.purchase_price as purchase_price FROM etc.thd_product thd
JOIN etc.cost c ON thd.item_number = c.item_number;
SELECT * FROM etc.thd_product_view;