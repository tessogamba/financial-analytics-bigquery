# Financial Analytics Platform (BigQuery & SQL)
An enterprise-aligned financial intelligence repository using Google BigQuery and raw SQL to orchestrate reusable analytical models, advanced macro-financial risk frameworks, and programmatic data-quality constraints.

<img width="2548" height="1316" alt="Screenshot 2026-06-05 at 18 28 29" src="https://github.com/user-attachments/assets/c15e8076-fb0b-4748-b915-0d8c5121cd37" />

## Live Dashboard

[View Dashboard on Data Studio](https://datastudio.google.com/s/iOk5aX6aaVQ)

## Tech Stack

- **Google BigQuery**: cloud data warehouse and SQL transformation layer
- **Looker Studio**: dashboard and visualisation layer
- **SQL**: all transformation and analysis logic
- **GitHub**: version control

## Data Source

Raw dataset: [Financial Statements of Major Companies (2009–2023)](https://www.kaggle.com/datasets/rish59/financial-statements-of-major-companies2009-2023), sourced from Kaggle. Loaded into Google BigQuery, cleaned via a staging layer, and transformed using raw SQL analytical models.

## Dataset

12 publicly listed companies across 6 sectors, from 2009–2023.

| Sector | Companies |
|--------|-----------|
| Technology | AAPL, MSFT, GOOG, AMZN, NVDA, INTC |
| FinTech | PYPL |
| Banking | BCS |
| Insurance | AIG |
| Energy | PCG |
| Food & Beverage | MCD |
| Retail | SHLDQ |

**23 metrics** including Revenue, Gross Profit, Net Income, EBITDA, EPS, ROE, ROA, Market Cap, Cash Flow, Current Ratio, Debt/Equity Ratio, and US Inflation Rate.

## Project Structure
```
financial-analytics-bigquery/
├── data/
│   └── Financial_Statements.csv              # Raw source data
├── sql/
│   ├── staging/
│   │   └── stg_financials.sql                # Cleans and standardises raw column names
│   └── analysis/
│       ├── company_revenue_growth.sql        # Absolute revenue growth, first vs last year
│       ├── profitability_margins.sql         # Gross, net and EBITDA margins by company/year
│       ├── avg_profitability_margins.sql     # Average net profit margin per company across all years
│       ├── yoy_growth.sql                    # Year-on-year revenue growth using LAG
│       ├── financial_risk.sql                # Liquidity and leverage risk categorisation
│       └── cagr_analysis.sql                 # Compound annual growth rate per company
├── tests/
│   └── data_quality_checks.sql              # Null checks, duplicate checks, range validation
└── README.md
```
## Staging Layer

`sql/staging/stg_financials.sql`

The raw table loaded from CSV had inconsistent column names, spaces, brackets, and mixed casing. The staging view cleans this into a consistent, lowercase, underscore-separated schema that all analysis queries build on.

- All 23 columns renamed to lowercase with underscores
- Backticks used to reference source columns with spaces
- Saved as a BigQuery view, `financial_statements.stg_financials`
- All downstream queries read from this view, not the raw table

## Analysis Layer

`sql/analysis/`

Six analysis queries answering investor-facing business questions:

**company_revenue_growth.sql**
Calculates absolute revenue growth per company by comparing the first and last year's revenue. Uses CTEs and self-joins to retrieve bookend values. Ordered by highest growth.

**profitability_margins.sql**
Calculates gross profit margin, net profit margin, and EBITDA margin as percentages for every company across every year. Enables cross-company profitability comparison regardless of company size.

**avg_profitability_margins.sql**
Calculates each company's average net profit margin across all available years, supporting consistent cross-company profitability comparison.

**yoy_growth.sql**
Calculates year-on-year revenue growth percentage using the `LAG` window function with `PARTITION BY company ORDER BY year`. Returns null for each company's first year where no prior year exists.

**financial_risk.sql**
Categorises companies by financial risk each year using `CASE WHEN` across two primary risk indicators, current ratio (liquidity risk) and debt/equity ratio (leverage risk). Produces an overall risk flag combining both.

**cagr_analysis.sql**
Calculates compound annual growth rate (CAGR) as a percentage using BigQuery's `POWER` function. CAGR smooths year-to-year volatility to show the equivalent steady annual growth rate between a company's first and last year in the dataset.

## SQL Concepts Used

- Common Table Expressions (CTEs)
- Window functions, `LAG`, `PARTITION BY`, `ORDER BY`
- Aggregations, `MIN`, `MAX`, `ROUND`
- Mathematical functions, `POWER` for CAGR
- `CASE WHEN` for risk categorisation
- Multi-table self-joins within CTEs
- BigQuery views for reusable staging layer

## Data Quality Tests

`tests/data_quality_checks.sql`

SQL-based tests following the same principle as dbt tests, each query returns rows if the test **fails** and returns nothing if the test **passes**.

Tests cover:
- **Null checks**: critical columns (company, year, revenue) contain no nulls
- **Duplicate checks**: one row per company per year
- **Range validation**: no negative revenue, margins within expected bounds
- **Completeness**: all 12 expected companies are present in the dataset

All 7 tests passing.

## Related Projects

- [case-management-analytics-platform](https://github.com/tessogamba/case-management-analytics-platform) - Production SQL Server-to-Power BI analytics platform with dimensional modelling, DAX and governed data-quality controls
- [financial-analytics-looker-studio](https://github.com/tessogamba/financial-analytics-looker-studio) - Looker Studio dashboard created from these BigQuery analysis models
- [retail-analytics-dbt](https://github.com/tessogamba/retail-analytics-dbt) - Retail analytics project using dbt and Snowflake to create tested dimensional models
- [retail-analytics-tableau](https://github.com/tessogamba/retail-analytics-tableau) - Tableau dashboard for customer, sales and revenue analysis

---
*Built by Tess Ogamba · [github.com/tessogamba](https://github.com/tessogamba) · [LinkedIn](https://linkedin.com/in/tessogamba)*
