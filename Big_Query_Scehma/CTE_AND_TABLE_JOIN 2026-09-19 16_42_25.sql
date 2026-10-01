
CREATE OR REPLACE TABLE `datascience-507912.Customer_Churn.customer_Data` AS
--Data Transformation, null handing and deduplication of customer summary table
WITH cleaned_Customer_Summary AS
(
SELECT
customer_id,
total_orders,
total_spent,
total_returns,
last_purchase_days,
lifetime_value,
customer_segment,
churn_risk_score,
churn

FROM `Customer_Churn.customers_summary`
WHERE customer_id IS NOT NULL
GROUP BY
customer_id,
total_orders,
total_spent,
total_returns,
last_purchase_days,
lifetime_value,
customer_segment,
churn_risk_score,
churn

HAVING COUNT(customer_id) < 2
ORDER BY last_purchase_days
),



--Data Transformation, null handing and deduplication of orders table
cleaned_Orders AS 
(
  SELECT
  order_id,
  customer_id,
  order_date,
  product_category,
  product_name,
  order_amount AS sales,
  delivery_days,
  order_status,
  COALESCE(return_reason, "Unknown") AS return_reason,
  customer_rating

  FROM `Customer_Churn.orders`
  WHERE order_id IS NOT NULL
  GROUP BY  order_id,
  customer_id,
  order_date,
  product_category,
  product_name,
  order_amount,
  delivery_days,
  order_status,
  return_reason,
  customer_rating

  HAVING COUNT(order_id) <2
  ORDER BY order_date DESC, delivery_days
),


--Data cleaning per table
--deduplication and handling missing values from customer's table
cleaned_Customers AS
(
  SELECT
  customer_id,
  age,
  CONCAT(first_name,' ', last_name) AS full_name,
  CASE 
  WHEN age BETWEEN 18 AND 25 THEN  '18-25'
   WHEN age BETWEEN 26 AND 35 THEN '26-35'
   WHEN age BETWEEN 35 AND 50 THEN '35-50'
  ELSE '50+'
  END AS age_group,
  gender,
  state,
  signup_date,
  tenure_months,
  CASE WHEN tenure_months BETWEEN 1 AND 12 THEN '1 year'
  WHEN tenure_months BETWEEN 13 AND 24 THEN '2 years'
  WHEN tenure_months BETWEEN 25 AND 36 THEN '3 years'
  ELSE 'Over 3 years'
  END AS tenure_group,
  membership_tier,
  income_group,
  preferred_device,
  referral_source
  FROM `Customer_Churn.customers`
  WHERE last_name IS NOT NULL
  AND customer_id IS NOT NULL
  GROUP BY customer_id, first_name, last_name, age, gender,tenure_months, 
  membership_tier, income_group, preferred_device, referral_source,state,signup_date
  HAVING COUNT(customer_id) < 2
  ORDER BY signup_date DESC, tenure_months


),


--Data Transformation, null handing and deduplication of payment tables
cleaned_Payments AS 
(
  SELECT
  payment_id,
  customer_id,
  payment_method,
  payment_status,
  payment_failures,
  subscription_active,
  subscription_fee,
  average_monthly_spend,
  last_payment_date
  FROM `Customer_Churn.payments`
  WHERE customer_id IS NOT NULL
  GROUP BY  payment_id,
  customer_id,
  payment_method,
  payment_status,
  payment_failures,
  subscription_active,
  subscription_fee,
  average_monthly_spend,
  last_payment_date
  HAVING COUNT(payment_id) < 2
  ORDER BY last_payment_date DESC
),

--Data transformation, deduplication of Engagements table
cleaned_Engagements AS (
  SELECT 
  customer_id,
  wishlist_items,
  cart_abandon_rate,
  days_since_last_login,
  CASE 
   WHEN days_since_last_login BETWEEN 1 AND 90 THEN '3 months'
  WHEN days_since_last_login BETWEEN 91 AND 180 THEN '6 months'
  WHEN days_since_last_login BETWEEN 181 and 270 THEN '9 months'
  WHEN days_since_last_login BETWEEN 270 and 366 THEN '12 months'
  ELSE 'Over 1year'
  END AS days_since_last_login_group,
  email_open_rate

  FROM `Customer_Churn.engagement`
  WHERE customer_id IS NOT NULL
  ORDER BY days_since_last_login
),

--data cleaning of support tickets table
cleaned_SuportTickets AS (
  SELECT
  ticket_id,
  customer_id,
  tickets_last_year,
  CASE 
  WHEN tickets_last_year BETWEEN 1 AND 3 THEN 'Low'
  WHEN tickets_last_year BETWEEN 4 AND 5 THEN 'Moderate'
  ELSE 'High'
  END AS ticket_group,
  complaint_category,
  avg_resolution_hours,
  CASE
  WHEN avg_resolution_hours BETWEEN 0 AND 24 THEN '1 day'
  WHEN avg_resolution_hours BETWEEN 25 AND 72 THEN '2 days'
  WHEN avg_resolution_hours BETWEEN 73 AND 168 THEN ' 7 days'
  ELSE 'Over 7days'
  END AS avg_resolution_group,
  escalated,
  issue_status

  FROM `Customer_Churn.support_tickets`
  WHERE ticket_id IS NOT NULL
  ORDER BY avg_resolution_hours 
  ),

  --tables joining

  customer_Data AS (
    SELECT
      cs.customer_id,
      c.full_name,
      c.age,
  c.age_group,
  c.gender,
  c.state,
  c.signup_date,
  c.tenure_months,
  c.tenure_group,
  c.membership_tier,
  c.income_group,
  c.preferred_device,
  c.referral_source,
      cs.total_orders,
      cs.total_spent,
      cs.total_returns,
     cs.last_purchase_days,
    cs.lifetime_value,
    cs.customer_segment,
   cs. churn_risk_score,
    cs.churn,
    o.order_date,
    o.product_category,
  o.product_name,
  o.sales,
  o. delivery_days,
  o.order_status,
  o.return_reason,
  o.customer_rating,
  p.payment_method,
  p.payment_status,
  p.payment_failures,
  p.subscription_active,
  p.subscription_fee,
  p.average_monthly_spend,
  p.last_payment_date,
  e.wishlist_items,
  e.cart_abandon_rate,
  e.days_since_last_login,
  e.days_since_last_login_group,
  e.email_open_rate,
  st.tickets_last_year,
  st.ticket_group,
  st.complaint_category,
  st.avg_resolution_hours,
  st.avg_resolution_group,
  st.escalated,
  st.issue_status

    FROM  cleaned_Orders AS o
    INNER JOIN  cleaned_Customer_Summary AS cs
    ON o.customer_id = cs.customer_id
    INNER JOIN cleaned_Customers AS c
    ON cs.customer_id = c.customer_id
    INNER JOIN cleaned_Payments AS p
    ON cs.customer_id = p.customer_id
    INNER JOIN cleaned_Engagements AS e
    ON cs.customer_id = e.customer_id
    INNER JOIN cleaned_SuportTickets AS st
    ON cs.customer_id = st.customer_id


  ) 
  SELECT 
  *
  FROM customer_Data;

  




