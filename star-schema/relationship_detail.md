# Based on relationship overview

From -> To
1. fact_inventory_status (date_id)         [Many to one]  dim_date     (date_id)
2. fact_inventory_status (material_id)     [Many to one]  dim_material (material_id)
3. impacted_orders       (material_id)     [Many to one]  dim_material (material_id)
4. impacted_orders       (sales_order_id)  [Many to one]  dim_sales    (sales_order_id)