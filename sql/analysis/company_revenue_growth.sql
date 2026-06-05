-- =============================================================
-- company_revenue_growth.sql
-- Project: Financial Analytics BigQuery
-- Layer: Analysis
-- Description: Calculates absolute revenue growth per company by comparing first and last year revenue.
--              Ordered by highest growth first.
-- =============================================================

-- create a table showing the first and last year of each company. One row per company
with first_last_year as(
SELECT company,
       MIN(year) as first_year,
       MAX (year) as last_year
    FROM `financial_statements.stg_financials`
    GROUP BY company
),

-- create a table with CTE 1 columns but include each companies first and last year's revenue
-- this CTE joins the first CTE (first_last_year) and stg_financials
bookends_revenue as (
   select 
   f.company,
   f.first_year,
   f.last_year,
   r1.revenue as first_year_revenue,
   r2.revenue as last_year_revenue,
from first_last_year f
join `financial_statements.stg_financials` r1 on f.company = r1.company and f.first_year = r1.year
join `financial_statements.stg_financials` r2 on f.company = r2.company and f.last_year = r2.year
),

-- final table calculating revenue growth by subtracting first year's revenue from last year's revenue
final as (
    select
    company,
    first_year,
    last_year,
    first_year_revenue,
    last_year_revenue,
    last_year_revenue - first_year_revenue as revenue_growth
from bookends_revenue
)

select * from final
order by revenue_growth desc
