CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);


CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(10,7),
    geolocation_lng DECIMAL(10,7),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);


CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);


CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm DECIMAL(10,2)
);


CREATE TABLE product_category_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);


CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) ,
    order_status VARCHAR(30),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);


CREATE TABLE order_items (
    order_id VARCHAR(50) ,
    order_item_id INT ,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price DECIMAL(12,2),
    freight_value DECIMAL(12,2),
	PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id),
    FOREIGN KEY (seller_id)
        REFERENCES sellers(seller_id)
);


CREATE TABLE order_payments (
    order_id VARCHAR(50) ,
    payment_sequential INT ,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(12,2),
	PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);


CREATE TABLE order_reviews (
    review_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title VARCHAR(500),
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

TRUNCATE TABLE order_reviews;

SELECT *
FROM order_reviews
WHERE review_id = '3242cc306a9218d0377831e175d62fbf';







SELECT *
FROM customers
WHERE customer_id = '9ef432eb6251297304e76186b10a928d';

SELECT COUNT(*)
FROM customers;


SELECT COUNT(*)
FROM orders;

SELECT COUNT(DISTINCT customer_unique_id)
FROM customers;