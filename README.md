# Financial Analytics: BigQuery & Looker Studio

An end-to-end financial data analytics engineering project created with **BigQuery**, **Looker Studio**, and **SQL**, demonstrating staging layers, raw SQL transformations, data quality testing, and dashboard visualisation across 12 public companies from 2009 to 2023.

---

## Tech Stack

- **Google BigQuery** - cloud data warehouse and SQL transformation layer
- **Looker Studio** - dashboard and visualisation layer
- **SQL** - all transformation and analysis logic
- **GitHub** - version control

---

## Dataset

Financial statement data for 12 publicly listed companies across 6 sectors, covering 2009–2023.

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

---

## Project Structure

```
financial-analytics-bigquery/
├── data/
│   └── Financial_Statements.csv        # Raw source data
├── sql/
│   ├── staging/
│   │   └── stg_financials.sql          # Cleans and standardises raw column names
│   └── analysis/
│       ├── company_revenue_growth.sql  # Absolute revenue growth, first vs last year
│       ├── profitability_margins.sql   # Gross, net and EBITDA margins by company/year
│       ├── yoy_growth.sql              # Year-on-year revenue growth using LAG
│       ├── financial_risk.sql          # Liquidity and leverage risk categorisation
│       └── cagr_analysis.sql           # Compound annual growth rate per company
├── tests/
│   └── data_quality_checks.sql        # Null checks, duplicate checks, range validation
└── README.md
```

---

## Staging Layer

`sql/staging/stg_financials.sql`

The raw table loaded as a CSV had inconsistent column names with spaces, brackets, and mixed casing. The staging view cleans this into a consistent, lowercase, underscore-separated schema that all analysis queries build on.

- All 23 columns renamed to lowercase with underscores
- Backticks used to reference source columns with spaces
- Saved as a BigQuery view; `financial_statements.stg_financials`
- All downstream queries read from this view, not the raw table

---

## Analysis Layer

`sql/analysis/`

Five analysis queries answering investor-facing business questions:

**company_revenue_growth.sql**
Calculates absolute revenue growth per company by comparing the first and last year's revenue. Uses CTEs and self-joins to retrieve bookend values. Ordered by highest growth.

**profitability_margins.sql**
Calculates gross profit margin, net profit margin, and EBITDA margin as percentages for every company in every year. Enables cross-company profitability comparison regardless of company size.

**yoy_growth.sql**
Calculates year-on-year revenue growth percentage using the `LAG` window function with `PARTITION BY company ORDER BY year`. Returns null for each company's first year where no prior year exists.

**financial_risk.sql**
Categorises companies by financial risk each year using `CASE WHEN` across two primary risk indicators, current ratio (liquidity risk) and debt/equity ratio (leverage risk). Produces an overall risk flag combining both.

**cagr_analysis.sql**
Calculates compound annual growth rate (CAGR) as a percentage using BigQuery's `POWER` function. CAGR smooths year-to-year volatility to show the equivalent steady annual growth rate between a company's first and last year in the dataset.

---

## SQL Concepts Used

- Common Table Expressions (CTEs)
- Window functions: `LAG`, `PARTITION BY`, `ORDER BY`
- Aggregations: `MIN`, `MAX`, `ROUND`
- Mathematical functions: `POWER` for CAGR
- `CASE WHEN` for risk categorisation
- Multi-table self-joins within CTEs
- BigQuery views for reusable staging layer

---

## Data Quality Tests

`tests/data_quality_checks.sql`

SQL-based tests following the same principle as dbt tests; each query returns rows if the test fails and returns nothing if the test passes.

Tests cover:
- **Null checks**: critical columns (company, year, revenue) contain no nulls
- **Duplicate checks**: one row per company per year
- **Range validation**: no negative revenue, margins within expected bounds
- **Completeness**: all 12 expected companies are present in the dataset

---

## Dashboard

Looker Studio dashboard coming soon, connecting directly to BigQuery views to visualise revenue growth, CAGR rankings, profitability trends, and risk indicators.

---

## Related Projects

[retail-analytics-dbt](https://github.com/tessogamba/retail-analytics-dbt) - Analytics engineering pipeline built with dbt and Snowflake

[retail-analytics-tableau](https://github.com/tessogamba/retail-analytics-tableau) - Tableau dashboard built on top of the dbt pipeline

---

## Author

**Teresia Ogamba (Tess Ogamba)** — Analytics Engineer & Data Analyst

[LinkedIn](https://linkedin.com/in/tessogamba) | [Website](https://tessogamba.com) | [GitHub](https://github.com/tessogamba)
