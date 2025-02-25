UPDATE etc.cost SET packaging_unit = sales_packaging_unit, unit = stockunit, sales_description = salesdescription 
FROM etc.product WHERE itemid = item_number;
SELECT * FROM etc.cost;