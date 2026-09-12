# FY2025 VA Disability Compensation Recipients — County-Level Analysis

## Overview
A county-level analysis of FY2025 VA disability compensation recipients across 3,148 U.S. counties, exploring recipient concentration by geography and disability severity rating distribution nationally.

## Data Source
[FY 2025 Disability Compensation Recipients by County](https://catalog.data.gov/dataset/fy-2025-disability-compensation-recipients-by-county) — Data.gov

## Business Problem
Understanding where VA disability compensation recipients are concentrated, and how severity ratings are distributed, can inform VA resource planning and long-term compensation budget forecasting.

## Dataset
FY2025 county-level data including total recipients, disability severity rating (SCD) breakdowns, age group, and sex — sourced at the county level for all 50 states, DC, and U.S. territories.

## Tools Used
- **Excel** — data cleaning, PivotTables, PivotCharts, dashboard design
- **SQL (T-SQL / SQL Server)** — aggregation queries, CTEs, filtering

## Data Cleaning & Validation
- Identified 13 counties with suppressed "Total" values (correlated with very small populations, e.g. Loving County, TX) — retained as nulls rather than zero-filled or dropped
- Found the same suppression pattern at a finer level across severity/age/sex breakdown columns (up to 464 counties affected in some columns)
- Verified SCD rating columns sum exactly to Total; documented minor (1-3 person) discrepancies between Total and the Age/Sex breakdowns
- Built a reusable "real county" flag to consistently exclude non-jurisdiction catch-all rows from rankings

## Analysis
- Ranked total recipients by state and by county
- Calculated the national distribution of recipients across 5 severity rating bands
- Cross-validated every result between Excel and SQL

## Key Insights
- **Texas, Florida, and California** lead in total recipients — likely reflecting population size and military presence; the dataset lacks population data, so this reflects raw counts, not disability rates
- **San Diego County, CA** and **Bexar County, TX** are the top two counties nationally
- **58.7%** of recipients hold a 70% or higher severity rating, relevant to compensation budget forecasting

## Repository Contents
- `data/fy2025_disability_analysis_by_county_raw.csv` — original source dataset
- `data/fy2025_disability_analysis_by_county_cleaned.xlsx` — cleaned data, PivotTables/Charts, and final dashboard
- `sql/DisabilityAnalysis.sql` — SQL queries reproducing the core analysis (state/county ranking, severity distribution)

## Skills Demonstrated

**Excel:**
- Data cleaning and validation (handling suppressed/missing data appropriately)
- PivotTables and PivotCharts
- Formula-based calculations (percentages, flag columns)
- Dashboard design (KPIs, charts, insights layout)

**SQL:**
- Aggregation (`SUM`, `GROUP BY`)
- Common Table Expressions (CTEs)
- Filtering and data validation queries
- Cross-validating spreadsheet results against a relational database
