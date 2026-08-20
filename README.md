# E-Commerce Supply Chain & RTO Optimization Analytics

📌 Project Overview
This project cleans, transforms, and analyzes messy e-commerce order records to identify critical operational bottlenecks and capital leaks. By building an end-to-end data pipeline spanning Python, SQL, and Power BI, I resolved significant data quality issues and isolated severe fulfillment delays in specific warehouses, as well as localized high Return-to-Origin (RTO) risks driven by Cash-on-Delivery (COD) transactions in Tier-2 regions.

🛠️ Tech Stack & Workflow
Data Cleaning & Preprocessing (Python/Pandas via Jupyter Notebook): Ingested raw operational data and engineered a robust cleaning pipeline to prepare it for analysis. Key operations included:

1. Identifying and dropping duplicate records to prevent skewed downstream aggregations.
2. Standardizing categorical inconsistencies using targeted list replacements (e.g., mapping messy aliases like 'C.O.D.', 'cod', and 'Cash' to a uniform 'COD', and unifying regional city spellings).
3. Fixing critical numerical errors, such as converting impossible negative dispatch times to absolute values and parsing string-formatted currency with commas into usable floats.
4. Handling missing data and massive numerical outliers by dynamically capping extremes with .mask() and applying median imputation to preserve data integrity.

Advanced Database Querying (MySQL): Stage-imported the cleaned dataset into a production schema to run multi-level aggregations (GROUP BY, CASE WHEN, HAVING) targeting financial vulnerabilities.

Business Intelligence (Power BI): Developed an interactive operational dashboard to present the validated metrics to executive stakeholders.

📈 Key Insights & Business Impact
1. First-Mile SLA Breaches (Warehouse Bottleneck)
The Leak: The business mandates a strict 24-hour target turnaround time from order placement to dispatch.
.The Root Cause: SQL profiling isolated WH-104 (Kolkata), which exhibits a catastrophic average dispatch delay exceeding 40 hours, triggering downstream logistic failures.

2. Last-Mile RTO Risk Clusters (Reverse Logistics Drain)
The Leak: High return rates drain margins due to double shipping costs without realized revenue.
.The Root Cause: Risk-factor cross-tabulation exposed that Cash-on-Delivery (COD) orders in Patna and Ranchi exhibit RTO rates climbing past 40%. Prepaid orders in the same regions remain entirely stable.

## 💻 Code Repository Directory

* `Ecommerce_Data_Cleaning.ipynb`: data cleaning engine 
* `DA1_sql.sql`: Includes the execution scripts for operational auditing.
* `DA1.pbit`: The native Power BI workbook.

---

## 📊 Dashboard Preview
![Operations Dashboard](DA1_dashboard.png)

## 💡 Strategic Recommendations
1. **Dynamic Fulfillment Allocation:** Throttle intake orders assigned to WH-104 (Kolkata) during peak log-jams, routing regional orders to neighboring active hubs to stabilize fulfillment timelines.
2. **Risk-Mitigation Payment Friction:** Introduce a minor prepaid incentive or enforce automated verification checks on high-value COD carts destined for Patna and Ranchi to compress RTO liabilities.
