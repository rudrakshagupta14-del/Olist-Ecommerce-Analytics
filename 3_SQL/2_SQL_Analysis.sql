
--calling tables
select * from customers;
select * from geolocation;
select * from sellers;
select * from products;
select * from product_category_translation;
select * from orders;
select * from order_items;
select * from order_payments;
select * from order_reviews;



--counting rows
select count(*) from customers;
select count(*) from geolocation;
select count(*) from sellers;
select count(*) from products;
select count(*) from product_category_translation;
select count(*) from orders;
select count(*) from order_items;
select count(*) from order_payments;
select count(*) from order_reviews;


--checking for duplicates
select customer_id,count(*) 
from customers
group by customer_id
having count(*)>1;

select seller_id,count(*) 
from sellers
group by seller_id
having count(*)>1;

select product_id,count(*) 
from products
group by product_id
having count(*)>1;

select order_id,count(*) 
from orders
group by order_id
having count(*)>1;

select review_id,count(*) 
from order_reviews
group by review_id
having count(*)>1;



--business kpis
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;

SELECT COUNT(distinct order_id) AS total_orderitems
FROM order_items;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_sellers
FROM sellers;

SELECT COUNT(*) AS total_products
FROM products;

SELECT SUM(price) AS total_sales
FROM order_items;

SELECT SUM(freight_value) AS total_freight
FROM order_items;

SELECT SUM(payment_value) AS total_payment
FROM order_payments;

SELECT 
    SUM(oi.price) / COUNT(DISTINCT o.order_id) AS aov
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id;



--order analysis
--order status analysis
select order_status,count(*) as total_orders
from orders
group by order_status
order by total_orders desc;

--sales analysis by state
select c.customer_state,sum(oi.price) as total_sales
from orders o
join customers c on o.customer_id = c.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_state
order by total_sales desc;

--sales analysis by product category
select pct.product_category_name_english,sum(oi.price) as total_sales
from products p
join product_category_translation pct on p.product_category_name = pct.product_category_name
join order_items oi on p.product_id = oi.product_id
group by pct.product_category_name_english
order by total_sales desc;

--payment type analysis
select payment_type,sum(payment_value) as total_payment
from order_payments
group by payment_type
order by total_payment desc;

--monthly sales analysis
select extract(month from o.order_purchase_timestamp) as month,
       sum(oi.price) as total_sales
from orders o
join order_items oi on o.order_id = oi.order_id
group by extract(month from o.order_purchase_timestamp)
order by month;

--Top product categories by sales
select pct.product_category_name_english,sum(oi.price) as total_sales,
       count(distinct p.product_id) as total_products
from products p
join product_category_translation pct on p.product_category_name = pct.product_category_name
join order_items oi on p.product_id = oi.product_id
group by pct.product_category_name_english
order by total_sales desc;
--top 10 sellers by sales
select s.seller_id ,sum(oi.price) as total_price
from sellers s
join order_items oi 
on s.seller_id = oi.seller_id
group by s.seller_id
order by total_price desc
limit 10;
--REVIEW ANALYSIS
select review_score,count(*) as total_reviews
from order_reviews
group by review_score
order by total_reviews desc;
--delivery analysis  divide by 86400 to convert seconds to days
select
    avg(
        extract(EPOCH from 
            (order_delivered_customer_date - order_purchase_timestamp)
        ) / 86400
    ) AS avg_delivery_days
from orders
where order_delivered_customer_date is not null;