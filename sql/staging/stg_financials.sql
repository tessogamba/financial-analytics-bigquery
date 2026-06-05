-- =============================================================
-- stg_financials.sql
-- Project: Financial Analytics BigQuery
-- Layer: Staging
-- Source: financial_statements.raw_financial_statements
-- Description: Standardises column names from the raw table.
--              All columns renamed to lowercase with underscores for consistency.
--              Backticks are used where original column names contain spaces. 
--              Note: 'Company' has a trailing space in the source data.
-- =============================================================
SELECT
 Year as year,
 `Company ` as company,
 Category as category,
 `Market Cap_in B USD_` as market_cap_billions,
 Revenue as revenue,
 `Gross Profit` as gross_profit,
 `Net Income` as net_income,
 `Earning Per Share` as earning_per_share,
 EBITDA as ebitda,
 `Share Holder Equity` as shareholder_equity,
 `Cash Flow from Operating` as cashflow_from_operating,
 `Cash Flow from Investing` as cashflow_from_investing,
 `Cash Flow from Financial Activities` as  cashflow_from_financial_activities,
 `Current Ratio` as current_ratio,
 `Debt_Equity Ratio` as debt_equity_ratio,
 ROE as roe,
 ROA as roa,
 ROI as roi,
 `Net Profit Margin` as net_profit_margin,
 `Free Cash Flow per Share` as free_cashflow_per_share,
 `Return on Tangible Equity` as return_on_tangible_equity,
 `Number of Employees` as number_of_employees,
 `Inflation Rate_in US_` as inflation_rate_us
 
 -- project.dataset.table
FROM `project-b3f6c3c5-c62a-4364-836.financial_statements.raw_financial_statements` 






