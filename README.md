# Y3S2 Project Reflection: PPG Recoverable Assets & Inventory Risk Management Pipeline

This document reflects on my experience building the end-to-end data engineering pipeline and Power BI dashboard for the PPG Industries Recoverable Assets (RA) and Inventory Risk Management (IRM) project, developed for SECP3843 (Special Topic in Data Engineering).

## What I Learned

- **The Gold layer as a zero-copy serving layer**: Using Azure Synapse Serverless SQL Pool with `OPENROWSET` over Parquet files showed me that a data warehouse layer does not always need a separate load step. Synapse reads directly from Parquet without importing the data, which is a different mental model from traditional ETL into a warehouse.
- **Schema design is not always textbook star schema**: I went into the project assuming a single fact table and dimension tables (star schema), but once `impacted_orders` emerged as a second fact table with its own grain, foreign keys, and additive measures, I learned that a galaxy schema (fact constellation) was the more accurate description of what I had actually built.

## Challenges I Faced & How I Solved Them

### 1. Discrepancy between the brief and the implementation (ADF)
**Challenge**: The original use case suggested Azure Data Factory (ADF) for orchestration, but our implementation used direct CSV upload to ADLS Gen2 instead.
**Solution**: Rather than forcing the report to describe a tool we did not use, I documented the trade-off explicitly: ADF adds enterprise credibility but is functionally overkill for six static CSV files. This was a useful lesson in justifying architectural decisions on their merits instead of matching a template for its own sake.

## What I Would Do Differently

- **Write schema documentation after the schema is finalized, not alongside development**: Documenting `dim_material`, `fact_inventory_status`, etc. while the Silver layer logic was still being refined led to some rework once additional flags and a second fact table emerged.
