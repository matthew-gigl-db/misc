-- Databricks notebook source
-- MAGIC %md
-- MAGIC Check current priveleges on table 'sample_databricks_data'. I have added a tag 'phi_pii' on this table

-- COMMAND ----------

SELECT *
FROM system.information_schema.table_privileges
WHERE table_name = 'sample_databricks_data'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 1. Used system tables to retieve table name that has the 'phi_pii' tag. This example showcases a single table solution however, you may need to iterate through
-- MAGIC
-- MAGIC 2. Declared a string variable with grant command and executed it to give Select permission to user group sc_test_group

-- COMMAND ----------

DROP TEMPORARY VARIABLE if exists session.abc;
DROP TEMPORARY VARIABLE if exists session.str;
DECLARE abc string;
SET VARIABLE abc = (SELECT table_name FROM system.information_schema.table_tags WHERE tag_name = 'phi_pii' LIMIT 1);
select abc;

DECLARE str STRING = 'Grant select on ' || abc || ' to sc_test_group;';
SELECT str;
USE catalog bd_test_catalog;
USE schema isc;
EXECUTE IMMEDIATE str;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Check updated permissions on table

-- COMMAND ----------

SELECT *
FROM system.information_schema.table_privileges
WHERE table_name = 'sample_databricks_data'
