-- Load the Kaggle CSV files from data/ into the tables.
-- psql meta-command \copy reads files on YOUR computer (unlike COPY, which reads on the server).
-- Run from the project root (see setup.sql). Parents first, so foreign keys are satisfied.

\copy customers            from 'data/olist_customers_dataset.csv'           with (format csv, header true)
\copy sellers              from 'data/olist_sellers_dataset.csv'             with (format csv, header true)
\copy products             from 'data/olist_products_dataset.csv'            with (format csv, header true)
\copy category_translation from 'data/product_category_name_translation.csv' with (format csv, header true)
\copy geolocation          from 'data/olist_geolocation_dataset.csv'         with (format csv, header true)
\copy orders               from 'data/olist_orders_dataset.csv'              with (format csv, header true)
\copy order_items          from 'data/olist_order_items_dataset.csv'         with (format csv, header true)
\copy order_payments       from 'data/olist_order_payments_dataset.csv'      with (format csv, header true)
\copy order_reviews        from 'data/olist_order_reviews_dataset.csv'       with (format csv, header true)
