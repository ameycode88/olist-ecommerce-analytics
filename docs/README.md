Olist E-Commerce Sales & Customer Analytics
**1. Project Overview**

This project analyzes the Brazilian E-Commerce Public Dataset by Olist to uncover sales performance, customer behavior, seller performance, and logistics efficiency using SQL, Excel, and Power BI.

The project follows a complete analytics workflow—from data cleaning and transformation in PostgreSQL to dashboard development in Excel and Power BI—demonstrating practical business intelligence skills.

Objectives
Analyze revenue and order trends
Evaluate customer purchasing behavior
Identify top-performing and underperforming sellers
Measure delivery performance and logistics efficiency
Build interactive dashboards for business decision-making


**2. Dataset**

Dataset: Brazilian E-Commerce Public Dataset by Olist

The dataset contains information on:

Customers
Orders
Order Items
Products
Sellers
Payments
Reviews
Geolocation

It represents real Brazilian e-commerce transactions between 2016 and 2018.
Source: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/suggestions


**3. Business Questions**
This project answers questions such as:

Executive Analytics
1. What is the total revenue generated?
2. How many orders were placed?
3. What is the Average Order Value (AOV)?
4. Which product categories generate the highest revenue?
5. Which states contribute the most sales?
   
Customer Analytics
1. Which locations generate the highest revenue?
2. How does customer distribution vary across Brazil?
3. Which payment methods are preferred?

Operations & Logistics
1. What is the average delivery time?
2. What percentage of orders are delivered on time?
3. Which sellers are underperforming?
4. What is the average freight cost?
5. How efficient is the delivery process?


**4. Tech Stack**
Database
  - PostgreSQL

Data Analysis
  - SQL
  - Excel

Business Intelligence
  - Power BI

DAX
Examples include:

1. Total Revenue
2. Total Orders
3. Average Order Value
4. Average Delivery Days
5. On-Time Delivery %
6. Average Freight Cost
7. Dynamic Top N Analysis

Version Control
  - Git
  - GitHub

**5. Project Workflow**
Raw CSV Files
        │
        ▼
PostgreSQL
(Data Cleaning + SQL Analysis)
        │
        ▼
Star Schema Modeling
        │
        ▼
Processed Dataset
        │
        ├────────► Excel Dashboard
        │
        ▼
Power BI
(DAX + Interactive Dashboard)


**6. Dashboard Preview**
Excel Dashboard
![Excel Dashboard](screenshots/excel_dashboard.png)

Power BI Executive Dashboard
![Executive Dashboard](screenshots/powerbi_page1.png)

Power BI Operations Dashboard
![Operations Dashboard](screenshots/powerbi_page2.png)


**7. Key Insights**
Sales
  Revenue consistently increased during the analysis period.
  A small number of product categories contributed a significant share of total revenue.

Customer
  Sales were concentrated in a few major Brazilian states.
  Credit Card was the most frequently used payment method.

Operations
  More than 93% of deliveries were completed on time.
  Average delivery time remained around 12 days.
  Underperforming sellers were identified based on revenue contribution.

Logistics
  Freight costs varied considerably across regions.
  Delivery efficiency remained consistently high throughout the period.


**8. Folder Structure**
olist-ecommerce-analytics/

├── data/
│   ├── raw/
│   ├── processed/
│   └── exports/
│
|
├── excel/
│
├── powerbi/
│
├── screenshots/
│
├── sql/
│
├── docs/
│
└── README.md


**9. How to Run**
1. Clone Repository
git clone https://github.com/ameycode88/olist-ecommerce-analytics.git

2. Import Dataset
Download the Olist dataset from Kaggle and import the CSV files into PostgreSQL.

3. Execute SQL Scripts
Run the SQL scripts in the sql folder to clean, transform, and analyze the data.

4. Open Power BI
Open:
  powerbi/Olist_Ecommerce_Analytics.pbix

Refresh the data if prompted.


**Skills Demonstrated**
- SQL Data Cleaning
- Exploratory Data Analysis (EDA)
- Star Schema Modeling
- Data Transformation
- Excel Dashboard Development
- Power BI Dashboard Development
- DAX Measures
- Interactive Visualizations
- Business Intelligence Reporting
- Git & GitHub
