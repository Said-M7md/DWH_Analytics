# Data Warehouse Analytics

A SQL-based data warehouse and analytics project. It loads flat-file source data into a relational database and runs a series of exploratory, analytical, and reporting SQL scripts on top of a customer / product / sales dimensional model.

## Project Structure

```
DataWarehouseAnalytic/
│
├── datasets/
│   └── flat-files/
│       ├── dim_customers.csv      # Customer dimension data
│       ├── dim_products.csv       # Product dimension data
│       └── fact_sales.csv         # Sales fact data
│
└── scripts/
    ├── 01_init_database.sql              # Creates database/schema and tables
    ├── 02_date_range_exploration.sql     # Explores date ranges in the data
    ├── 03_measures_exploration.sql       # Explores key measures/metrics
    ├── 04_magnitude_analysis.sql         # Magnitude analysis (totals, sums by category)
    ├── 05_ranking_analysis.sql           # Ranking analysis (top/bottom N)
    ├── 06_change_over_time_analysis.sql  # Trend analysis over time
    ├── 07_cumulative_analysis.sql        # Running totals / cumulative metrics
    ├── 08_customers_segmentation.sql     # Customer segmentation
    ├── 09_products_segmentation.sql      # Product segmentation
    ├── 10_performance_analysis.sql       # Performance analysis (YoY, MoM, etc.)
    ├── 11_part_to_whole_analysis.sql     # Part-to-whole / proportion analysis
    ├── 12_report_customer.sql            # Final customer report
    └── 13_report_product.sql             # Final product report
```

> **Note:** A few script filenames in the current repo contain spaces, inconsistent casing, or a typo (e.g. `8_customers segmention.sql`, `07_Cumulative Analysis.sql`). It's recommended to rename them to match the convention above (lowercase, underscores, zero-padded numbers, corrected spelling) for consistency and to avoid shell quoting issues.

## Data Model

The project follows a simple star-schema style model:

- **dim_customers** – customer attributes (id, name, demographics, etc.)
- **dim_products** – product attributes (id, category, cost, etc.)
- **fact_sales** – sales transactions linking customers and products, with measures such as quantity, price, and sales amount

## How to Use

1. **Initialize the database**
   Run `scripts/01_init_database.sql` to create the database schema and tables.

2. **Load the data**
   Import the CSV files from `datasets/flat-files/` into their corresponding tables (`dim_customers`, `dim_products`, `fact_sales`).

3. **Run the analysis scripts**
   Execute the numbered scripts in `scripts/` in order (02 → 13) to explore the data and generate insights, from basic exploration through to final customer and product reports.

## Analysis Covered

- Date range & measures exploration
- Magnitude and ranking analysis
- Change-over-time (trend) analysis
- Cumulative analysis
- Customer and product segmentation
- Performance analysis
- Part-to-whole analysis
- Final consolidated customer and product reports

## Requirements

- Any standard SQL engine (e.g. SQL Server, PostgreSQL, or MySQL) capable of running the provided `.sql` scripts. Adjust syntax as needed for your specific database engine.

## Author

Said Mohamed
