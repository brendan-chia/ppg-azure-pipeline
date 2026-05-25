*somehow this is one of the rare things LLMs can't get it right after multiple confirmations*

** is_mc_expired is an integer in Synapse, so logically we will use this formula to count the number of rows that is_mc_expired =1 **

# MC Expired Count = SUM(vw_fact_inventory_status[is_mc_expired]) 

but this does not reflect the correct number i have calculated using pyspark code in databricks notebook

The solution?

---------------------------------------------------------------------------

MC Expired Count = 
CALCULATE(
    SUM(vw_fact_inventory_status[is_mc_expired]),
    ALL(vw_fact_inventory_status)
)

---------------------------------------------------------------------------