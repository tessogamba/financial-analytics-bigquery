-- =============================================================
-- avg_profitability_margins.sql
-- Project: Financial Analytics BigQuery
-- Layer: Analysis
-- Source: financial_statements.profitability_margins
-- Description: Aggregates profitability margins per company across all years
--              producing one row per company for cleaner dashboard visualisation
--              Ordered by highest average net profit margin first
-- =============================================================

-- averages gross, net and ebitda margins across all years per company
-- more readable than year-by-year data for cross-company comparison

select
    company,
    category,
    round(avg(gross_profit_margin), 2) as avg_gross_margin,
    round(avg(net_profit_margin), 2) as avg_net_margin,
    round(avg(ebitda_margin), 2) as avg_ebitda_margin
from `financial_statements.profitability_margins`
group by company, category
order by avg_net_margin desc
