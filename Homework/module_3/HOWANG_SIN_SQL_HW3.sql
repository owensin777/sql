-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

select vendor_id, count(vendor_id) from vendor_booth_assignments GROUP by vendor_id


/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */

select c.customer_last_name, c.customer_first_name,sum(cp.quantity* cp.cost_to_customer_per_qty) from customer_purchases as cp 
left join customer as c 
on cp.customer_id = c.customer_id 
group by cp.customer_id
having sum(cp.quantity* cp.cost_to_customer_per_qty) > 50
ORDER by c.customer_last_name, c.customer_first_name

--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/

create temp table if not EXISTS temp.new_vendor
(
"vendor_id" int(11) NOT NULL ,
 "vendor_name" varchar(45) NOT NULL,
 "vendor_type" varchar(45) NOT NULL,
 "vendor_owner_first_name" varchar(45) NOT NULL,
 "vendor_owner_last_name" varchar(45) NOT NULL,
 PRIMARY KEY ("vendor_id"),
 UNIQUE ("vendor_id"),
 UNIQUE ("vendor_name")
 );
 
 INSERT INTO temp.new_vendor VALUES ( "10", "Thomass Superfood Store", "Fresh Focused", "Thomas", "Rosenthal");
 

-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */

select customer_id,
strftime("%m", market_date) as month,
strftime("%Y", market_date) as year
 from customer_purchases

/* 2. Using the previous query as a base, determine how much money each customer spent in April 2019. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */

select  customer_id,
strftime("%m", market_date) as month,
strftime("%Y", market_date) as year,
quantity * cost_to_customer_per_qty as total_money_sent
from customer_purchases 
where month = "04" AND year = "2019"
group by customer_id

 
 