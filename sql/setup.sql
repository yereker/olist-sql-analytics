-- One-command setup. From the project root run:
--   psql -U postgres -f sql/setup.sql
-- Creates database "olist" (if missing), builds the tables and loads the CSV files.

\set ON_ERROR_STOP on
set client_encoding = 'UTF8';

select 'create database olist'
where not exists (select 1 from pg_database where datname = 'olist')
\gexec

\connect olist
set client_encoding = 'UTF8';

\echo '--- creating tables ---'
\i sql/01_schema.sql

\echo '--- loading data (geolocation has 1M rows, give it a minute) ---'
\i sql/02_load.sql

\echo '--- row counts ---'
select 'customers'            as table_name, count(*) as row_count from customers
union all select 'sellers',              count(*) from sellers
union all select 'products',             count(*) from products
union all select 'category_translation', count(*) from category_translation
union all select 'geolocation',          count(*) from geolocation
union all select 'orders',               count(*) from orders
union all select 'order_items',          count(*) from order_items
union all select 'order_payments',       count(*) from order_payments
union all select 'order_reviews',        count(*) from order_reviews;
