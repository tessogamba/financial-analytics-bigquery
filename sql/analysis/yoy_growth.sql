-- =============================================================
-- yoy_growth.sql
-- Project: Financial Analytics BigQuery
-- Layer: Analysis
-- Source: financial_statements.stg_financials
-- Description: Calculates year-on-year revenue growth for each company
--              Uses the LAG window function to compare each year's revenue
--              to the previous year. Null for each company's first year.          
-- =============================================================

select company,
       year,
       revenue,
--     round the calculated column to 2 decimal places
       round (
       (revenue - lag (revenue) over (partition by company order by year)) 
       / lag (revenue) over (partition by company order by year) * 100,2)
       as yoy_revenue_growth
from `financial_statements.stg_financials`
order by company, year
