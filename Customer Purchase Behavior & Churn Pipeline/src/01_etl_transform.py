import pandas as pd
from pathlib import Path

RAW = Path('data/raw')
OUT = Path('data/processed')
OUT.mkdir(parents=True, exist_ok=True)

# Load
customers = pd.read_csv(RAW/'customers.csv', parse_dates=['signup_date'])
products = pd.read_csv(RAW/'products.csv')
transactions = pd.read_csv(RAW/'transactions.csv', parse_dates=['purchase_date'])

# Basic cleaning
transactions['discount_pct'] = transactions['discount_pct'].fillna(0)
transactions['unit_price'] = transactions['unit_price'].clip(lower=0)
transactions['revenue'] = (transactions['unit_price'] * transactions['quantity']).round(2)

# Join for enriched view
tx_enriched = (transactions
    .merge(customers, on='customer_id', how='left', suffixes=('','_cust'))
    .merge(products, on='product_id', how='left', suffixes=('','_prod'))
)

# Feature engineering (customer-level)
snapshot = pd.Timestamp('2025-08-01')
agg = (tx_enriched
       .groupby('customer_id')
       .agg(
           last_purchase=('purchase_date', 'max'),
           frequency=('transaction_id', 'count'),
           monetary=('revenue', 'sum'),
           avg_basket=('revenue', 'mean')
       )
       .reset_index()
      )
agg['recency_days'] = (snapshot - agg['last_purchase']).dt.days

# Derived features
cust_features = customers.merge(agg, on='customer_id', how='left')
cust_features['days_since_signup'] = (snapshot - cust_features['signup_date']).dt.days
cust_features['recency_days'] = cust_features['recency_days'].fillna(9999).astype(int)
cust_features['frequency'] = cust_features['frequency'].fillna(0).astype(int)
cust_features['monetary'] = cust_features['monetary'].fillna(0.0)
cust_features['avg_basket'] = cust_features['avg_basket'].fillna(0.0)

# Save processed
tx_enriched.to_csv(OUT/'transactions_enriched.csv', index=False)
cust_features.to_csv(OUT/'customer_features.csv', index=False)

print('Saved:', OUT/'transactions_enriched.csv', 'and', OUT/'customer_features.csv')