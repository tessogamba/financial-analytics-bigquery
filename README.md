# Financial Analytics: BigQuery & Looker Studio

Analysis of financial statement data for 12 public companies in multiple sectors (Tech, FinTech, Banking, Energy, Retail) from 2009 to 2023. Created to answer real investor questions using BigQuery SQL and Looker Studio.

---

## Business Questions Answered

- Which companies grew revenue the fastest over the full period?
- What is the compound annual growth rate (CAGR) for each company?
- How have profit margins changed over time, and who is most efficient?
- Which companies show signs of financial distress based on liquidity and leverage indicators?
- How does year-on-year revenue growth vary across sectors?

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| Google BigQuery | Cloud data warehouse, SQL transformations |
| Looker Studio | Dashboard and visualisation layer |
| GitHub | Version control |

---

## Project Structure

```
financial-analytics-bigquery/
├── data/
│   └── Financial_Statements.csv        # Raw source data (12 companies, 2009–2023)
├── sql/
│   ├── staging/
│   │   └── stg_financials.sql          # Cleans and standardises raw column names
│   └── analysis/
│       ├── company_revenue_growth.sql  # Absolute revenue growth, first vs last year
│       ├── profitability_margins.sql   # Gross, net and EBITDA margins by company/year
│       ├── yoy_growth.sql              # Year-on-year revenue growth using LAG window function
│       ├── financial_risk.sql          # Liquidity and leverage risk indicators using CASE WHEN
│       └── cagr_analysis.sql           # Compound annual growth rate per company
└── README.md
```

---

## Dataset

12 publicly listed companies across 5 sectors:

| Sector | Companies |
|--------|-----------|
| Technology | AAPL, MSFT, GOOG, AMZN, NVDA, INTC |
| FinTech | PYPL |
| Banking | BCS |
| Insurance | AIG |
| Energy | PCG |
| Food & Beverage | MCD |
| Retail | SHLDQ |

**23 financial metrics** including Revenue, Gross Profit, Net Income, EBITDA, EPS, ROE, ROA, Market Cap, Cash Flow, Current Ratio, Debt/Equity Ratio, and Inflation Rate.

---

## Key Findings

**Revenue Growth (2009–2023)**
- Amazon recorded the highest absolute revenue growth at ~$489B, growing from $24.5B to $514B
- Sears (SHLDQ) lost ~$30B in revenue over the period and filed for bankruptcy in 2018
- Traditional sectors (retail, insurance) declined while tech compounded aggressively

**CAGR**
- Amazon led with a 26% compound annual growth rate
- Google followed at 21%, Apple at 18.6%
- AIG and Sears posted negative CAGRs of -2.2% and -10.8%, respectively

**Profitability**
- Tech companies consistently outperformed on net profit margin
- Apple maintained ~21–25% net profit margins throughout the period
- McDonald's showed stable margins despite modest revenue growth; high efficiency in a low-growth sector

**Financial Risk**
- Apple flagged as a liquidity risk in recent years (current ratio below 1) despite being the world's most valuable company, probably intentional
- Sears showed compounding risk signals in both liquidity and leverage indicators before bankruptcy

---

## SQL Concepts Used

- Common Table Expressions (CTEs)
- Window functions: `LAG`, `PARTITION BY`, `ORDER BY`
- Aggregations: `MIN`, `MAX`, `SUM`, `ROUND`
- Mathematical functions: `POWER` for CAGR calculation
- `CASE WHEN` for risk categorisation
- Multi-table joins within CTEs

---

## Dashboard

Looker Studio dashboard coming soon, connecting directly to BigQuery views.
