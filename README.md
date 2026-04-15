Manufacturing Operations & Production Intelligence Dashboard
📌 Project Overview
This project features a comprehensive 7-page Power BI dashboard designed to provide a 360-degree view of global manufacturing operations. By integrating production, financial, and supply chain data, the dashboard enables stakeholders to monitor Overall Equipment Effectiveness (OEE), track cost variances, and optimize supplier performance.

🛠️ Tech Stack & Skills
Power BI: Advanced Data Visualization, UI/UX Design, and Page Navigation.

DAX (Data Analysis Expressions): Created complex measures for OEE, Yield %, Scrap Rate %, and Year-over-Year (YoY) growth.

SQL: Developed the underlying views (leveraging Joins, CTEs, and Window Functions) to aggregate raw manufacturing data into a Star Schema.

Data Modeling: Implementation of a Star Schema with Fact and Dimension tables to ensure high-performance reporting.

📂 Report Pages Breakdown
1. Executive Summary
Provides a high-level overview of the manufacturing health.

Core Metrics: Total Actual Cost ($77.92M), Total Produced Units (4.70M), and OEE (146.12%).

Insights: YoY comparisons of Yield vs. Scrap to identify long-term efficiency trends.

2. Factory Performance Leaderboard
A tactical view to compare efficiency across different global plant locations.

Key Visuals: Clustered bar charts for Yield and Scrap rates.

Functionality: A "Budget Status" indicator using conditional formatting to flag plants operating outside of cost tolerances.

3. Downtime Analysis
Quantifies the financial and operational impact of production halts.

Metric Highlight: Calculated a Downtime Cost Impact of $6.39M.

Trend Tracking: Area charts comparing 2020 vs. 2021 downtime percentages to identify seasonal disruptions.

4. Quality & Scrap Analysis
Deep dive into product quality and material waste.

Quality Rating: Categorizes production into Excellent, Good, Average, and Poor.

Top 10 Risk Products: Lists specific products (e.g., Gaming Laptops, Monitor Risers) with the highest scrap rates for targeted QC intervention.

5. Cost & Variance Analysis
Focuses on financial integrity by comparing budget vs. reality.

Variance Tracking: Visualizes the $1.19M gap between Standard and Actual costs.

Unit Economics: Tracks "Cost Per Unit" by factory to identify cost-efficient manufacturing hubs.

6. Region & Channel Distribution
Analyzes how products flow through different markets and sales channels.

Channel Mix: Breakdown of production volume across B2B, Retail, OEM, and Online channels.

Geographic Performance: APAC identified as the leading region with 3.25M good units.

7. Supplier Performance Matrix
Evaluates the reliability of raw material and component providers.

Supplier KPIs: Detailed matrix showing Yield and Scrap % by individual supplier.

Visual Indicators: Uses KPI icons (arrows and colored circles) for instant identification of underperforming vendors.

📈 Key Business Insights
Operational Bottlenecks: Tokyo and Osaka plants show the highest downtime hours, directly correlating with a higher cost per unit.

Quality Control: The "Connectivity" product category requires immediate process auditing due to a consistent 6.74% scrap rate.

Strategic Growth: APAC is the most efficient region, maintaining high yield rates while managing the largest production volumes.

🚀 How to Use
Download the .pbix file.

Open in Power BI Desktop.

Use the top navigation bar to toggle between the 7 specialized report pages.

Interact with Slicers (Year, Region, Country) to filter data dynamically.

Author: Ritik Dhawade
Role: Aspiring Data Analyst | Power BI & SQL Enthusiast
