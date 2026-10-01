/* CREATING SCHEMA FOR 6 TABLES TO BE IMPORTED. Fact table is customers_summary table linked with 5 dimension table on customer_id */


CREATE OR REPLACE TABLE `datascience-507912.Customer_Churn.customers`
(
  customer_id INT64,
  first_name STRING,
  last_name INT64,
  age INT64,
  gender STRING,
  city STRING,
  state STRING,
  country STRING,
  signup_date DATE,
  tenure_months INT64,
  membership_tier STRING,
  occupation STRING,
  income_group STRING,
  marital_status STRING,
  education STRING,
  preferred_device STRING,
  referral_source STRING
);



CREATE OR REPLACE TABLE `datascience-507912.Customer_Churn.customers`
(
  customer_id INT64,
  first_name STRING,
  last_name INT64,
  age INT64,
  gender STRING,
  city STRING,
  state STRING,
  country STRING,
  signup_date DATE,
  tenure_months INT64,
  membership_tier STRING,
  occupation STRING,
  income_group STRING,
  marital_status STRING,
  education STRING,
  preferred_device STRING,
  referral_source STRING
);


CREATE OR REPLACE TABLE `datascience-507912.Customer_Churn.orders`(
  order_id INT64,
  customer_id INT64,
  order_date DATE,
  product_category STRING,
  product_name STRING,
  quantity INT64,
  unit_price FLOAT64,
  discount_percent INT64,
  order_amount FLOAT64,
  payment_method STRING,
  coupon_used BOOL,
  delivery_days INT64,
  order_status STRING,
  returned BOOL,
  return_reason STRING,
  seller_rating FLOAT64,
  customer_rating INT64
);

CREATE OR REPLACE TABLE`datascience-507912.Customer_Churn.engagement` (
  customer_id INT64,
  app_usage_minutes INT64,
  website_sessions INT64,
  avg_session_duration FLOAT64,
  search_frequency INT64,
  pages_viewed INT64,
  wishlist_items INT64,
  cart_abandon_rate FLOAT64,
  notification_click_rate FLOAT64,
  email_open_rate FLOAT64,
  days_since_last_login INT64
);

CREATE OR REPLACE TABLE`datascience-507912.Customer_Churn.payments`
(
  payment_id INT64,
  customer_id INT64,
  payment_method STRING,
  payment_status STRING,
  payment_failures INT64,
  refund_amount FLOAT64,
  subscription_active BOOL,
  subscription_fee INT64,
  last_payment_date DATE,
  average_monthly_spend FLOAT64
);

CREATE TABLE `datascience-507912.Customer_Churn.support_tickets`
(
  ticket_id INT64,
  customer_id INT64,
  tickets_last_year INT64,
  complaint_category STRING,
  average_resolution_hours INT64,
  satisfaction_score FLOAT64,
  escalated BOOL,
  issue_status STRING
);