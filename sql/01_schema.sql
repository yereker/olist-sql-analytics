-- Olist e-commerce: table definitions (PostgreSQL)
-- Re-runnable: drops the tables first, children before parents.

drop table if exists order_reviews;
drop table if exists order_payments;
drop table if exists order_items;
drop table if exists orders;
drop table if exists products;
drop table if exists sellers;
drop table if exists customers;
drop table if exists geolocation;
drop table if exists category_translation;

-- ---------- reference tables ----------

create table customers (
    customer_id              varchar(32) primary key,  -- id of the customer IN ONE ORDER
    customer_unique_id       varchar(32) not null,     -- the real person (use for retention)
    customer_zip_code_prefix varchar(5),               -- text, not int: zip codes keep leading zeros
    customer_city            text,
    customer_state           char(2)
);

create table sellers (
    seller_id              varchar(32) primary key,
    seller_zip_code_prefix varchar(5),
    seller_city            text,
    seller_state           char(2)
);

create table products (
    product_id                 varchar(32) primary key,
    product_category_name      text,               -- Portuguese; can be NULL
    product_name_length        int,                -- CSV header has a typo: "lenght"
    product_description_length int,
    product_photos_qty         int,
    product_weight_g           int,
    product_length_cm          int,
    product_height_cm          int,
    product_width_cm           int
);

create table category_translation (
    product_category_name         text primary key,
    product_category_name_english text
);

-- no primary key: one zip prefix has many coordinates
create table geolocation (
    geolocation_zip_code_prefix varchar(5),
    geolocation_lat             numeric(18, 14),
    geolocation_lng             numeric(18, 14),
    geolocation_city            text,
    geolocation_state           char(2)
);

-- ---------- fact tables ----------

create table orders (
    order_id                      varchar(32) primary key,
    customer_id                   varchar(32) not null references customers (customer_id),
    order_status                  text not null,   -- delivered, shipped, canceled, ...
    order_purchase_timestamp      timestamp not null,
    order_approved_at             timestamp,
    order_delivered_carrier_date  timestamp,
    order_delivered_customer_date timestamp,
    order_estimated_delivery_date timestamp
);

-- one row per item in an order
create table order_items (
    order_id            varchar(32) not null references orders (order_id),
    order_item_id       int not null,               -- 1, 2, 3... inside the order
    product_id          varchar(32) not null references products (product_id),
    seller_id           varchar(32) not null references sellers (seller_id),
    shipping_limit_date timestamp,
    price               numeric(10, 2),
    freight_value       numeric(10, 2),
    primary key (order_id, order_item_id)
);

-- one order can be paid in several parts (e.g. voucher + card)
create table order_payments (
    order_id             varchar(32) not null references orders (order_id),
    payment_sequential   int not null,
    payment_type         text,
    payment_installments int,
    payment_value        numeric(10, 2),
    primary key (order_id, payment_sequential)
);

-- review_id is NOT unique in the raw data, so the key is (review_id, order_id)
create table order_reviews (
    review_id               varchar(32) not null,
    order_id                varchar(32) not null references orders (order_id),
    review_score            int check (review_score between 1 and 5),
    review_comment_title    text,
    review_comment_message  text,
    review_creation_date    timestamp,
    review_answer_timestamp timestamp,
    primary key (review_id, order_id)
);
