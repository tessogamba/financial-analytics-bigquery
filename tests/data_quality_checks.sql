-- =============================================================
-- data_quality_checks.sql
-- Project: Financial Analytics BigQuery
-- Layer: Tests
-- Source: financial_statements.stg_financials
-- Description: Data quality checks for critical columns.
--              Each query returns rows if the test fails.
--              Expected result for all tests: 0 rows returned.
-- =============================================================

-- TEST 1: No nulls in company column
select 'null_company' as test_name, count(*) as failing_rows
from `financial_statements.stg_financials`
where company is null;

-- TEST 2: No nulls in year column
select 'null_year' as test_name, count(*) as failing_rows
from `financial_statements.stg_financials`
where year is null;

-- TEST 3: No nulls in revenue column
select 'null_revenue' as test_name, count(*) as failing_rows
from `financial_statements.stg_financials`
where revenue is null;

-- TEST 4: No duplicate company/year combinations
select 'duplicate_company_year' as test_name, count(*) as failing_rows
from (
    select company, year, count(*) as row_count
    from `financial_statements.stg_financials`
    group by company, year
    having count(*) > 1
);

-- TEST 5: No negative revenue
select 'negative_revenue' as test_name, count(*) as failing_rows
from `financial_statements.stg_financials`
where revenue < 0;

-- TEST 6: Net profit margin within expected range (-100% to 100%)
select 'margin_out_of_range' as test_name, count(*) as failing_rows
from `financial_statements.stg_financials`
where net_profit_margin > 100 or net_profit_margin < -100;

-- TEST 7: All expected companies present
select 'missing_companies' as test_name, count(*) as failing_rows
from (
    select expected_company
    from unnest(['AAPL','MSFT','GOOG','AMZN','NVDA','INTC',
                 'PYPL','BCS','AIG','PCG','MCD','SHLDQ']) as expected_company
    where expected_company not in (
        select distinct company 
        from `financial_statements.stg_financials`
    )
);
