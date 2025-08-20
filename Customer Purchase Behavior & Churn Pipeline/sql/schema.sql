CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  signup_date DATE,
  age INTEGER,
  gender TEXT,
  region TEXT,
  state TEXT,
  income_band TEXT,
  churn_label INTEGER
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  category TEXT,
  subcategory TEXT,
  brand TEXT,
  base_price REAL,
  cost REAL
);

CREATE TABLE transactions (
  transaction_id INTEGER PRIMARY KEY,
  customer_id INTEGER REFERENCES customers(customer_id),
  product_id INTEGER REFERENCES products(product_id),
  purchase_date DATE,
  quantity INTEGER,
  unit_price REAL,
  discount_pct REAL,
  revenue REAL,
  payment_method TEXT
);

CREATE INDEX idx_tx_customer ON transactions(customer_id);
CREATE INDEX idx_tx_date ON transactions(purchase_date);
CREATE INDEX idx_tx_product ON transactions(product_id);

# Monthly revenue & orders
SELECT
  strftime('%Y-%m', purchase_date) AS month,
  SUM(revenue) AS total_revenue,
  COUNT(*) AS orders
FROM transactions
GROUP BY 1
ORDER BY 1;

# Top 10 customers by revenue
SELECT c.customer_id, c.region, SUM(t.revenue) AS revenue
FROM transactions t
JOIN customers c ON c.customer_id = t.customer_id
GROUP BY 1,2
ORDER BY revenue DESC
LIMIT 10;

# Category revenue share
SELECT p.category, SUM(t.revenue) AS revenue
FROM transactions t
JOIN products p ON p.product_id = t.product_id
GROUP BY 1
ORDER BY revenue DESC;

# RFM-style metrics
WITH last_purchase AS (
  SELECT customer_id, MAX(purchase_date) AS last_date
  FROM transactions
  GROUP BY 1
),
freq_monetary AS (
  SELECT customer_id, COUNT(*) AS frequency, SUM(revenue) AS monetary
  FROM transactions
  GROUP BY 1
)
SELECT c.customer_id,
       CAST((julianday('2025-08-01') - julianday(lp.last_date)) AS INT) AS recency_days,
       fm.frequency,
       fm.monetary
FROM customers c
LEFT JOIN last_purchase lp ON lp.customer_id = c.customer_id
LEFT JOIN freq_monetary fm ON fm.customer_id = c.customer_id;