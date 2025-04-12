
# 📊 Marketing Campaign SQL Analysis

This project analyzes a fictional marketing campaign database using SQL. It explores customer demographics, campaign responses, and earned loyalty points to uncover actionable marketing insights.

---

## 📁 Files Included

- `marketing_campaign_database.sql` – Creates the database and main table (`marketing_campaign`).
- `marketing_campaign_points.sql` – Adds a secondary table (`campaign_points`) with loyalty data.
- `marketing_campaign_inserts.sql` – Inserts sample data into both tables.

---

## 🧠 Key Business Questions Answered

- What is the overall campaign response rate?
- Which gender has the highest response rate?
- How does age or income affect campaign response?
- Which customers earned the most points?
- Are high-income customers more likely to respond?

---

## 📌 Example SQL Insights

```sql
-- Response rate by income level
SELECT 
  CASE 
    WHEN income < 50000 THEN 'Low Income'
    WHEN income BETWEEN 50000 AND 100000 THEN 'Mid Income'
    ELSE 'High Income'
  END AS income_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN response = 'Yes' THEN 1 ELSE 0 END) AS responded,
  ROUND(100.0 * SUM(CASE WHEN response = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS response_rate
FROM marketing_campaign
GROUP BY income_group;
```

---

## 📈 Possible Extensions

- Visualize insights using Power BI, Tableau, or Excel.
- Predict campaign responses with Python & ML.
- Normalize the schema and add indexes for optimization.

---

## 🚀 Skills Demonstrated

- SQL querying (JOINs, aggregation, conditional logic)
- Database design & data insertion
- Data storytelling & business analysis
