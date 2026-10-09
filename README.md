# Olist E-commerce SQL Analytics

SQL analysis of a real Brazilian e-commerce marketplace (Olist): ~100k orders from 2016–2018 across 9 related tables — orders, items, customers, sellers, payments, reviews and products.

> 🚧 Work in progress

## Business questions

- How do revenue and the number of orders change month by month?
- Which product categories bring the most revenue?
- How often are deliveries late, and how does that affect review scores?
- Which sellers have the slowest deliveries?
- How many customers come back for a second order (retention)?

## Stack

- PostgreSQL 18
- SQL: joins, aggregations, subqueries, CTE, window functions

## Data

[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) on Kaggle.
The raw CSV files are not stored in this repo. Download them from Kaggle and put them into `data/`.

## How to run

1. Install PostgreSQL and download the dataset from Kaggle.
2. Unzip the 9 CSV files into `data/`.
3. From the project root run:
   ```bash
   psql -U postgres -f sql/setup.sql
   ```
   This creates the `olist` database, builds the tables with primary and foreign keys, loads the data and prints the row counts.

| Table | Rows |
|---|---|
| orders | 99,441 |
| order_items | 112,650 |
| order_payments | 103,886 |
| order_reviews | 99,224 |
| customers | 99,441 |
| products | 32,951 |
| sellers | 3,095 |
| category_translation | 71 |
| geolocation | 1,000,163 |

## Project structure

```
data/                 raw CSV files (not tracked by git)
sql/setup.sql         one-command setup: database + tables + data
sql/01_schema.sql     table definitions, primary and foreign keys
sql/02_load.sql       CSV loading with \copy
```

## Key findings

_Coming soon._
