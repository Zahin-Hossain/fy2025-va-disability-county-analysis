-- FY2025 VA Disability Compensation Recipients — County-Level Analysis
-- Table: county_disability_data

-- Preview raw data
SELECT *
FROM county_disability_data;

-- Row count check
SELECT COUNT(*) AS row_count
FROM county_disability_data;

-- Total recipients by state (excludes non-state catch-all rows)
SELECT State, SUM([Total: Disability Compensation Recipients]) AS total_recipients
FROM county_disability_data
WHERE [State] NOT IN ('US Territories (excluding Puerto Rico)', 'Other Foreign Countries', 'Unknown')
GROUP BY State
ORDER BY total_recipients DESC;

-- Total recipients by county ([Real County?] excludes catch-all rows)
SELECT [State,County], [Total: Disability Compensation Recipients] AS total_recipients
FROM county_disability_data
WHERE [Real County?] = 1
ORDER BY total_recipients DESC;

-- National totals by severity (SCD) rating
SELECT
    SUM([SCD rating: 0% to 20%])  AS rating_0_20,
    SUM([SCD rating: 30% to 40%]) AS rating_30_40,
    SUM([SCD rating: 50% to 60%]) AS rating_50_60,
    SUM([SCD rating: 70% to 90%]) AS rating_70_90,
    SUM([SCD rating: 100%])       AS rating_100
FROM county_disability_data;

-- Severity rating distribution as % of total
WITH severity_totals AS (
    SELECT
        SUM([SCD rating: 0% to 20%])  AS rating_0_20,
        SUM([SCD rating: 30% to 40%]) AS rating_30_40,
        SUM([SCD rating: 50% to 60%]) AS rating_50_60,
        SUM([SCD rating: 70% to 90%]) AS rating_70_90,
        SUM([SCD rating: 100%])       AS rating_100
    FROM county_disability_data
)
SELECT
    rating_0_20,
    rating_30_40,
    rating_50_60,
    rating_70_90,
    rating_100,
    
    (rating_0_20  * 100.0) / (rating_0_20 + rating_30_40 + rating_50_60 + rating_70_90 + rating_100) AS pct_0_20,
    (rating_30_40 * 100.0) / (rating_0_20 + rating_30_40 + rating_50_60 + rating_70_90 + rating_100) AS pct_30_40,
    (rating_50_60 * 100.0) / (rating_0_20 + rating_30_40 + rating_50_60 + rating_70_90 + rating_100) AS pct_50_60,
    (rating_70_90 * 100.0) / (rating_0_20 + rating_30_40 + rating_50_60 + rating_70_90 + rating_100) AS pct_70_90,
    (rating_100   * 100.0) / (rating_0_20 + rating_30_40 + rating_50_60 + rating_70_90 + rating_100) AS pct_100
FROM severity_totals;
