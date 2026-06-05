-- =============================================================
-- profitability_margins.sql
-- Project: Financial Analytics BigQuery
-- Layer: Analysis
-- Source: financial_statements.stg_financials
-- Description: Calculates profitability margins for all companies through the years
--              Margins show profitability as a percentage of revenue, allowing fair comparison for companies of all sizes
--              Ordered by latest year first        
-- =============================================================

select 
       company,
       category,
       year,
       revenue,
       gross_profit,
       gross_profit / revenue * 100 as gross_profit_margin,
       net_income,
       net_profit_margin,
       ebitda,
       ebitda / revenue * 100 as ebitda_margin
from `financial_statements.stg_financials`
order by year desc
