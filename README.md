# 🏭 Manufacturing & Production Intelligence Dashboard

## 📌 Project Overview
This project features a comprehensive **7-page Power BI dashboard** designed to provide a 360-degree view of global manufacturing operations. By integrating production, financial, and supply chain data, the dashboard enables stakeholders to monitor **Overall Equipment Effectiveness (OEE)**, track cost variances, and optimize supplier performance.

---

## 🖼️ Dashboard Preview
<img width="1124" height="685" alt="Screenshot 2026-04-15 153813" src="https://github.com/user-attachments/assets/09b2bb27-8d4b-47b0-9201-7e1362b8e727" />
---

## 🛠️ Tech Stack & Skills
* **Power BI:** Advanced Visualization, UI/UX Design, and Page Navigation.
* **DAX:** Developed complex measures for OEE, Yield %, Scrap Rate %, and YoY Growth.
* **SQL:** Created underlying views using Joins and CTEs to aggregate raw manufacturing data.
* **Data Modeling:** Implementation of a Star Schema to ensure high-performance reporting.

---

## 📂 Report Pages Breakdown

### 1️⃣ Executive Summary
Provides a high-level overview of the manufacturing health.
* **Core Metrics:** Total Actual Cost ($77.92M), Total Produced Units (4.70M), and OEE (146.12%).
* **Visuals:** Monthly production trends and YoY KPI comparisons.

### 2️⃣ Factory Performance Leaderboard
A tactical view to compare efficiency across global plant locations.
<img width="1065" height="663" alt="Screenshot 2026-04-15 153909" src="https://github.com/user-attachments/assets/20eae1fa-1f2d-4a2c-96ed-ad26ae89dbc8" />

* **Feature:** A "Budget Status" indicator using conditional formatting to flag plants operating outside of cost tolerances.

### 3️⃣ Downtime Analysis
Quantifies the financial and operational impact of production halts.
<img width="1124" height="677" alt="Screenshot 2026-04-15 154003" src="https://github.com/user-attachments/assets/aff4a65a-bf58-4606-897d-1c5f48a32240" />

* **Metric Highlight:** Calculated a **Downtime Cost Impact** of $6.39M.

### 4️⃣ Quality & Scrap Analysis
Deep dive into product quality and material waste.
<img width="1152" height="739" alt="Screenshot 2026-04-15 154049" src="https://github.com/user-attachments/assets/a3ce6358-38c5-4bda-a29c-a727babe7a24" />

* **Top 10 Risk Products:** Lists products (e.g., Gaming Laptops) with the highest scrap rates.

### 5️⃣ Cost & Variance Analysis
Focuses on financial integrity by comparing budget vs. reality.
![Cost Analysis](./images/cost.png)
* **Unit Economics:** Tracks "Cost Per Unit" by factory to identify the most cost-efficient hubs.

### 6️⃣ Region & Channel Distribution
Analyzes how products flow through different markets and sales channels.
![Region and Channel](./images/region.png)
* **Geography:** APAC identified as the leading region with 3.25M good units.

### 7️⃣ Supplier Performance Matrix
Evaluates the reliability of raw material and component providers.
![Supplier Performance](./images/supplier.png)
* **Visual Indicators:** KPI icons for instant identification of underperforming suppliers.

---

## 📈 Key Business Insights
* **Operational Bottlenecks:** Tokyo and Osaka plants show the highest downtime hours, correlating with a higher cost per unit.
* **Quality Control:** The "Connectivity" product category requires immediate auditing due to a consistent 6.74% scrap rate.
* **Strategic Growth:** APAC is the most efficient region, maintaining high yield rates with the largest volumes.

---

## 🚀 How to Use
1. Download the `.pbix` file from this repository.
2. Open in **Power BI Desktop**.
3. Use the top navigation bar to toggle between the **7 specialized report pages**.
4. Interact with Slicers (Year, Region, Country) to filter data dynamically.

---
**Author:** Vrushabh Dhawade  
**Role:** Aspiring Data Analyst | Power BI & SQL Enthusiast
