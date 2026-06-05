-- =============================================================
-- financial_risk.sql
-- Project: Financial Analytics BigQuery
-- Layer: Analysis
-- Source: financial_statements.stg_financials
-- Description: Create debt and liquidity risk indicators to identify companies showing signs of financial distress
--              Uses case when to categorise two primary risk indicators; current_ratio and debt_equity_ratio  
-- =============================================================

select company,
       year,
       category,
       current_ratio,
       case
       when current_ratio < 1 then 'High risk'
       when current_ratio between 1 and 1.5 then 'Moderate'
       else 'Healthy'
       end as liquidity_risk,
       debt_equity_ratio,
       case
       when debt_equity_ratio > 2 then 'High leverage'
       when debt_equity_ratio between 1 and 2 then 'Moderate'
       else 'Low leverage'
       end as leverage_risk,
       case
       when current_ratio < 1 or debt_equity_ratio > 2 then 'At risk'
       else 'Stable'
       end as overall_risk

from `financial_statements.stg_financials`
order by company, year, category
