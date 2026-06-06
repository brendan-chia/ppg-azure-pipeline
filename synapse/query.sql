CREATE SCHEMA gold;
GO

-- 1. dim_material
CREATE VIEW gold.dim_material AS
SELECT *
FROM OPENROWSET(
    BULK 'https://storageppg.dfs.core.windows.net/gold/dim_material/**',
    FORMAT = 'PARQUET'
) WITH (
    material_id         VARCHAR(20),
    material_name       VARCHAR(100),
    category            VARCHAR(50),
    unit_of_measure     VARCHAR(20),
    reorder_level       FLOAT,
    lead_time_days      FLOAT,
    unit_cost           FLOAT
) AS [result];
GO

-- 2. dim_supplier
CREATE VIEW gold.dim_supplier AS
SELECT *
FROM OPENROWSET(
    BULK 'https://storageppg.dfs.core.windows.net/gold/dim_supplier/**',
    FORMAT = 'PARQUET'
) WITH (
    supplier_id         VARCHAR(20),
    supplier_name       VARCHAR(100),
    country             VARCHAR(50),
    reliability_rating  VARCHAR(20)
) AS [result];
GO

-- 3. dim_sales_order
CREATE VIEW gold.dim_sales_order AS
SELECT *
FROM OPENROWSET(
    BULK 'https://storageppg.dfs.core.windows.net/gold/dim_sales_order/**',
    FORMAT = 'PARQUET'
) WITH (
    sales_order_id          VARCHAR(20),
    order_date              DATE,
    customer_name           VARCHAR(100),
    finished_product        VARCHAR(100),
    quantity_ordered        FLOAT,
    required_delivery_date  DATE,
    status                  VARCHAR(20)
) AS [result];
GO

-- 4. dim_production
CREATE VIEW gold.dim_production AS
SELECT *
FROM OPENROWSET(
    BULK 'https://storageppg.dfs.core.windows.net/gold/dim_production/**',
    FORMAT = 'PARQUET'
) WITH (
    production_order_id     VARCHAR(20),
    production_date         DATE,
    finished_product        VARCHAR(100),
    material_id             VARCHAR(20),
    quantity_consumed       FLOAT
) AS [result];
GO

-- 5. dim_date
CREATE VIEW gold.dim_date AS
SELECT *
FROM OPENROWSET(
    BULK 'https://storageppg.dfs.core.windows.net/gold/dim_date/**',
    FORMAT = 'PARQUET'
) WITH (
    snapshot_date   DATE,
    date_id         INT,
    year            INT,
    quarter         INT,
    month_name      VARCHAR(20)
) AS [result];
GO

-- 6. fact_inventory_status
CREATE VIEW gold.fact_inventory_status AS
SELECT *
FROM OPENROWSET(
    BULK 'https://storageppg.dfs.core.windows.net/gold/fact_inventory_status/**',
    FORMAT = 'PARQUET'
) WITH (
    fact_id                 INT,
    material_id             VARCHAR(20),
    date_id                 INT,
    supplier_id             VARCHAR(20),
    production_order_id     VARCHAR(20),
    sales_order_id          VARCHAR(20),
    quantity_on_hand        FLOAT,
    consumption_12m         FLOAT,
    consumption_9m          FLOAT,
    reorder_level           FLOAT,
    unit_cost               FLOAT,
    mc_provision_amount     FLOAT,
    avg_daily_consumption   FLOAT,
    safety_stock_needed     FLOAT,
    lot_expiry_date         DATE,
    is_recoverable_asset    INT,
    is_mc_dead_stock        INT,
    is_mc_expired           INT,
    is_magna_carta          INT,
    is_below_reorder        INT,
    is_stockout_risk        INT
) AS [result];
GO

-- 7. impacted_orders
CREATE VIEW gold.impacted_orders AS
SELECT *
FROM OPENROWSET(
    BULK 'https://storageppg.dfs.core.windows.net/silver/impacted_sales_orders/**',
    FORMAT = 'PARQUET'
) WITH (
    sales_order_id          VARCHAR(20),
    customer_name           VARCHAR(100),
    finished_product        VARCHAR(100),
    material_id             VARCHAR(20),
    material_name           VARCHAR(100),
    quantity_ordered        FLOAT,
    required_delivery_date  DATE,
    status                  VARCHAR(20),
    quantity_on_hand        FLOAT
) AS [result];
GO