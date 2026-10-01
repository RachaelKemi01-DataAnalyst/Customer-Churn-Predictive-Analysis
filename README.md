# Customer-Churn-Predictive-Analysis

Business Objective: The objective of this machine learning project is accurately predict customer churn of a fictional wholesale store. The prediction aims to identify customers that are likely to churn and propel strategic management practices to retain customers. 

Methodology:
Data Source: The datasets was sourced from Kaggle Customer Behavior & Churn Prediction Dataset V2
Data Highlights: 
- 500,000 Customers
- 1,000,000 Orders
- 150,000 Support Tickets
- 500,000 Engagement Records
- 500,000 Payment Records
- 500,000 Customer Summary Records
- 
 Files Included

 customers.csv

Customer demographic information

Contains:

- Customer Profile
- Membership Tier
- Income Group
- Education
- Occupation
- Preferred Device
- Referral Source

---

orders.csv

Customer purchase history

Includes:

- Product Categories
- Order Amount
- Discounts
- Payment Method
- Delivery Time
- Returns
- Ratings

---

 engagement.csv

Customer engagement metrics

Includes:

- App Usage
- Website Sessions
- Search Frequency
- Wishlist Activity
- Email Open Rate
- Notification Click Rate
- Cart Abandonment
- Days Since Last Login

---

payments.csv

Payment behavior

Includes:

- Payment Method
- Payment Status
- Refund Amount
- Subscription Status
- Monthly Spending

---

 support_tickets.csv

Customer support history

Contains

- Complaint Category
- Resolution Time
- Satisfaction Score
- Escalation Status

---

 customer_summary.csv

Includes

- Customer Lifetime Value (CLV)
- Loyalty Points
- Purchase Frequency
- Customer Segment
- Churn Risk Score
- Churn Label

   Tools and programming languages deployed
  1. Big Query: Data were imported into big query using GoogleSQL, tables were joined using left join and inner join, temporary tables and views were created
  2. Google Colab: Data from big query were imported into colab
     2a. Data Extraction and visualisation: Pandas, seaborn, matplotlib and plotly
     2b. Statistical analysis: T-test and Chi_square
     2c. Feature selection: Factor analyzer and chi_square
     2d. Model training: scikit-learn, logistic regression, random forest, decision tree  and xgboost 
