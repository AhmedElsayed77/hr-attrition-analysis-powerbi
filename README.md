# HR Employee Attrition Analysis — Power BI, DAX, SQL & Python

[![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=flat&logo=powerbi&logoColor=black)](#)
[![SQL](https://img.shields.io/badge/SQL-MySQL-blue?style=flat&logo=mysql&logoColor=white)](#)
[![Python](https://img.shields.io/badge/Python-Pandas-3776AB?style=flat&logo=python&logoColor=white)](#)

End-to-end HR analytics case study built on the **IBM HR Analytics Employee Attrition** dataset (1,470 employees). Completed as a Senior BI Developer interview case study, covering data modeling, DAX, dashboarding, narrative reporting, presentation, SQL, and Python — all 8 tasks of the original brief.

---

## Project Overview

| | |
|---|---|
| **Dataset** | IBM HR Analytics Employee Attrition (1,470 rows, 35 columns) |
| **Overall Attrition Rate** | 16.1% (237 employees) |
| **Tools Used** | Power BI, DAX, MySQL, Python (pandas), Excel |
| **Key Finding** | Sales Representatives attrite at 39.8% — 2.5× the company average |

---

## Repository Structure

```
hr-attrition-analysis-powerbi/
│
├── power-bi/
│   └── HR_Attrition_Dashboard.pbix          ← full Power BI file (all 4 model/visual tasks live here)
│
├── 01-star-schema/
│   ├── HR_Attrition_StarSchema.xlsx
│   └── screenshots/
│       └── model_view.png
│
├── 02-dax-measures/
│   ├── DAX Measures_README.pdf
│   └── screenshots/
│       └── measures_table.png
│
├── 03-outliers-trends/
│   └── screenshots/
│       └── outliers_trends_page.png
│
├── 04-dashboard/
│   └── screenshots/
│       └── dashboard_overview.png
│
├── 05-narrative-recommendations/
│   └── HR_Attrition_Narrative_Recommendations.pdf
│
├── 06-presentation/
│   └── HR_Attrition_Presentation.pptx
│
├── 07-sql-query/
│   ├── attrition_query.sql
│   └── screenshots/
│       └── query_result.png
│
├── 08-python-classification/
│   ├── experience_classification.py
│   ├── dataset.xlsx
│   └── screenshots/
│       └── classification_output.png
│
└── README.md   ← you are here
```

> **Note:** Tasks 1–4 all live inside the same Power BI file (`power-bi/HR_Attrition_Dashboard.pbix`) — the star schema model, DAX measures, Outliers & Trends page, and Dashboard Overview page are all part of one `.pbix`. Each task folder above contains the relevant supporting file and a screenshot of that specific part of the file.

---

## Task 1 — Star Schema Data Model

Power BI Star Schema: 1 fact table (`Fact_Employee`) + 13 dimension tables, connected with verified Many-to-One, single-direction, active relationships. Validated by confirming `Total Employees = 1,470` matches the source row count.

📂 [`01-star-schema/`](01-star-schema/)

---

## Task 2 — DAX Measures with Variables

10 DAX measures written using `VAR` / `RETURN`, covering attrition rate, income gap, overtime risk, tenure, and a dynamic variance-from-average measure used to flag outliers.

```dax
Attrition Rate % = 
VAR TotalEmp = COUNTROWS(Fact_Employee)
VAR LeaversCount = 
    CALCULATE(COUNTROWS(Fact_Employee), Fact_Employee[Attrition] = "Yes")
RETURN
    DIVIDE(LeaversCount, TotalEmp, 0)
```

📂 [`02-dax-measures/`](02-dax-measures/) — full measure list in `DAX Measures_README.pdf`

---

## Task 3 — Outliers & Trends

| Finding | Value | Type |
|---|---|---|
| Sales Representative attrition | 39.8% | Outlier (2.5× average) |
| Overtime = Yes attrition | 30.5% vs. 10.4% | Strongest predictor |
| Year 0–1 tenure attrition | 34.9% → 8.1% at 11+ yrs | Trend |
| Age 18–25 attrition | 35.8% | Outlier |

📂 [`03-outliers-trends/`](03-outliers-trends/)

---

## Task 4 — Executive Dashboard

Brand-aligned executive overview page: KPI cards, attrition split donut, department/overtime comparisons, and interactive slicers (Department, JobRole, Gender).

📂 [`04-dashboard/`](04-dashboard/)

---

## Task 5 — Narrative & Actionable Recommendations

Five data-backed findings translated into 4 prioritized recommendations, each tied to estimated business impact (~$6.8M annual attrition cost; ~$2M+ potential savings from a 5-point reduction).

| # | Recommendation | Target |
|---|---|---|
| 1 | Overtime cap & rotation policy | All employees |
| 2 | Sales Rep compensation review | Sales Representative role |
| 3 | Structured 90-day onboarding | New hires (0–2 yrs) |
| 4 | Fast-track career program | Ages 18–25 |

📂 [`05-narrative-recommendations/`](05-narrative-recommendations/)

---

## Task 6 — Stakeholder Presentation

6-slide executive presentation summarizing findings and recommendations for a 5-minute stakeholder readout, including speaker notes.

📂 [`06-presentation/`](06-presentation/)

---

## Task 7 — SQL Query

```sql
SELECT
    d.Department AS DepartmentName,
    jr.JobRole AS JobRoleName,
    COUNT(CASE WHEN f.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    ROUND(AVG(f.MonthlyIncome), 2) AS AvgMonthlyIncome
FROM Fact_Employee f
JOIN Dim_Department d ON f.DepartmentID = d.DepartmentID
JOIN Dim_JobRole jr ON f.JobRoleID = jr.JobRoleID
GROUP BY d.Department, jr.JobRole
ORDER BY AttritionCount DESC;
```
Tested and verified on MySQL Workbench — see `screenshots/query_result.png` for the actual Result Grid.

📂 [`07-sql-query/`](07-sql-query/)

---

## Task 8 — Python Classification

Classifies employees into experience tiers based on `TotalWorkingYears` (Junior < 5, Mid 5–9, Senior 10+):

```
ExperienceLevel  EmployeeCount
         Junior            228
            Mid            493
         Senior            749
```

📂 [`08-python-classification/`](08-python-classification/)

---

## Key Takeaways

- **Overtime is the strongest single predictor of attrition** (30.5% vs. 10.4%, a 2.9× risk multiplier) — stronger than salary or job satisfaction.
- **Sales Representative is the highest-risk role** (39.8% attrition), warranting immediate compensation review.
- **The first 1–3 years of tenure are the highest-risk window**, with attrition dropping steadily from 34.9% to 8.1% by year 11+.

---

## Author

**Ahmed Elsayed** — Data Analyst
[LinkedIn](https://linkedin.com/in/ahmed-elsayed) · [Portfolio](https://ahmedelsayed77-portfolio.netlify.app) · [GitHub](https://github.com/AhmedElsayed77)

---

## License

This project uses the publicly available IBM HR Analytics Employee Attrition dataset for educational/portfolio purposes.
