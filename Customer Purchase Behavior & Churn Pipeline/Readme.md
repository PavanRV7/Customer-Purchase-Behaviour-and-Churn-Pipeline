# 📊 Customer Purchase Behavior & Churn Pipeline

An end-to-end **data analytics project** simulating a retail dataset to analyze **customer behavior, churn, and product performance**.  
This project demonstrates skills in **ETL, feature engineering, machine learning, SQL, and Power BI dashboarding**, making it ideal for a Data Analyst / Data Scientist portfolio.

---

## 🚀 Project Overview
This pipeline processes raw transactional data, engineers customer-level features (RFM), builds a churn prediction model, and visualizes insights in **Power BI**.  
Key objectives:
- Understand customer purchase behavior and retention patterns
- Identify churn drivers (recency, frequency, discounts, demographics)
- Evaluate product/category performance
- Provide actionable business recommendations

---

## 📂 Project Structure
customer_churn_pipeline/
│
├── data/
│ ├── raw/ # Synthetic customers, products, transactions
│ └── processed/ # ETL outputs (enriched transactions, customer features)
│
├── src/
│ ├── 01_etl_transform.py # Cleans & transforms raw data → enriched datasets
│ ├── 02_model_train.py # Baseline churn model (Logistic Regression)
│
├── sql/
│ └── schema.sql # SQL schema & example queries
│
├── dashboard/
│ └── dashboard_spec.md # Power BI visuals & measures
│
├── reports/
│ └── churn_report_outline.md # Churn analysis report structure
│
├── README.md # Project documentation
└── requirements.txt # Python dependencies

---

## 🔧 Tech Stack
- **Languages & Libraries:** Python (Pandas, NumPy, Scikit-learn, Matplotlib, Seaborn)
- **Database:** SQLite / MySQL
- **Visualization:** Power BI, Excel
- **Other Tools:** SQL, Git

---

## 🛠️ Workflow

### 1. Data Engineering (ETL)
- Load raw customer, product, and transaction data  
- Clean discount/revenue columns  
- Aggregate customer-level features:  
  - **Recency (days since last purchase)**  
  - **Frequency (total orders)**  
  - **Monetary (lifetime revenue)**  
- Export processed CSVs for analysis

### 2. Feature Engineering
- **RFM Segmentation**  
- Average basket size  
- CLV proxy (monetary × expected orders)

### 3. Modeling
- **Logistic Regression** baseline churn model  
- Labels defined by **Recency > 180 days = churned**  
- Evaluate using AUC, precision/recall

### 4. Dashboard (Power BI)
- **Executive KPIs** → Revenue, Churn Rate, Active Customers  
- **Customer Segments (RFM)** → Scatterplot (Recency vs Frequency, size=Monetary)  
- **Churn Analysis** → Churn vs Recency, Frequency, Region, Income Band  
- **Product Performance** → Category share, Top 20 products, Discount impact scatter  

---

## 📊 Key Insights
- Customers with **high recency (inactive >180 days)** and **low frequency (≤2 orders)** are most likely to churn  
- **Moderate discounts (5–10%)** drive more orders, but heavy discounts cut average order value  
- **Revenue is concentrated in a small group** of champions and loyal customers  
- Certain **regions and income bands** show higher churn and stronger discount sensitivity  

---

## ✅ Recommendations
- Launch **90–180 day win-back campaigns**  
- Nudge first-time buyers to make a **second purchase quickly**  
- Apply **targeted discounts by category**, not blanket promotions  
- Build cross-sell journeys using category affinity (e.g., Mobiles → Accessories)  
- Expand dataset with **marketing touchpoints and service data** for richer models  

---

## 📌 Next Steps
- Deploy pipeline to cloud (AWS/GCP) for automation  
- Add **advanced churn models** (XGBoost, LightGBM)  
- Integrate with real-time dashboards (Tableau/Streamlit)  
- Track **margin impact** alongside revenue in future iterations  

---

## 📜 Disclaimer
This dataset is **synthetic** and created for **educational/portfolio purposes only**.  
The methodology and insights are realistic, but not based on actual business data.

---

## 👤 Author
**Pavan R V**
B.Tech Artificial Intelligence & Data Science | Aspiring Data Analyst  
📍 Coimbatore, India  
🔗 [LinkedIn](https://www.linkedin.com/in/pavan-r-v) | [GitHub](https://github.com/PavanRV7)
