-- dim_material
CREATE TABLE dim_material (
  material_id       VARCHAR(20)    NOT NULL,
  material_name     VARCHAR(100),
  category          VARCHAR(50),
  unit_of_measure   VARCHAR(20),
  reorder_level     DECIMAL(18,2),
  lead_time_days    INT,
  unit_cost         DECIMAL(18,4)
)
WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX);
ALTER TABLE dim_material
ADD CONSTRAINT pk_dim_material PRIMARY KEY NONCLUSTERED (material_id) NOT ENFORCED;

-- dim_date
CREATE TABLE dim_date (
  date_id           INT            NOT NULL,
  snapshot_date     DATE,
  year              INT,
  quarter           INT,
  month_name        VARCHAR(20)
)
WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX);
ALTER TABLE dim_date
ADD CONSTRAINT pk_dim_date PRIMARY KEY NONCLUSTERED (date_id) NOT ENFORCED;

-- dim_supplier
CREATE TABLE dim_supplier (
  supplier_id         VARCHAR(20)  NOT NULL,
  supplier_name       VARCHAR(100),
  country             VARCHAR(50),
  reliability_rating  DECIMAL(3,2)
)
WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX);
ALTER TABLE dim_supplier
ADD CONSTRAINT pk_dim_supplier PRIMARY KEY NONCLUSTERED (supplier_id) NOT ENFORCED;

-- dim_sales_order
CREATE TABLE dim_sales_order (
  sales_order_id          VARCHAR(20)  NOT NULL,
  order_date              DATE,
  customer_name           VARCHAR(100),
  finished_product        VARCHAR(100),
  quantity_ordered        DECIMAL(18,2),
  required_delivery_date  DATE,
  status                  VARCHAR(20)
)
WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX);
ALTER TABLE dim_sales_order
ADD CONSTRAINT pk_dim_sales_order PRIMARY KEY NONCLUSTERED (sales_order_id) NOT ENFORCED;

-- dim_production
CREATE TABLE dim_production (
  production_order_id  VARCHAR(20)  NOT NULL,
  production_date      DATE,
  finished_product     VARCHAR(100),
  material_id          VARCHAR(20),
  quantity_consumed    DECIMAL(18,2)
)
WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX);
ALTER TABLE dim_production
ADD CONSTRAINT pk_dim_production PRIMARY KEY NONCLUSTERED (production_order_id) NOT ENFORCED;

-- fact_inventory_status
CREATE TABLE fact_inventory_status (
  fact_id                INT          NOT NULL,
  material_id            VARCHAR(20),
  date_id                INT,
  quantity_on_hand       DECIMAL(18,2),
  consumption_12m        DECIMAL(18,2),
  consumption_9m         DECIMAL(18,2),
  reorder_level          DECIMAL(18,2),
  unit_cost              DECIMAL(18,4),
  mc_provision_amount    DECIMAL(18,2),
  avg_daily_consumption  DECIMAL(18,4),
  safety_stock_needed    DECIMAL(18,2),
  lot_expiry_date        DATE,
  is_recoverable_asset   TINYINT,
  is_mc_dead_stock       TINYINT,
  is_mc_expired          TINYINT,
  is_magna_carta         TINYINT,
  is_below_reorder       TINYINT,
  is_stockout_risk       TINYINT
)
WITH (DISTRIBUTION = HASH(material_id), CLUSTERED COLUMNSTORE INDEX);
ALTER TABLE fact_inventory_status
ADD CONSTRAINT pk_fact_inventory PRIMARY KEY NONCLUSTERED (fact_id) NOT ENFORCED;