-- INNER JOIN

/*
SELECT *
FROM product
INNER JOIN product_category
	ON product.product_category_id = product_category.product_category_id
	
ORDER BY product.product_category_id
*/

SELECT v.*, market_date, quantity, product_id, original_price
FROM vendor v
INNER JOIN vendor_inventory vi
	ON v.vendor_id = vi.vendor_id