# Setup
```shell
pip install -r requirements.txt
```

# Execution
```shell
# Without params
python main.py

# Specifying a SQL filename.
python main.py dim_ssga_security.sql
```

# Notices
 - 'SORTKEY (asof_calendar_day)' might not work. > ValueError: Expected an Expression. Received <class 'list'>: [(IDENTIFIER this: asof_calendar_day, quoted: False)]
 - Cases, all lower cases in actual outputs.
 - Some columns are missing.

Expected results
```SQL
CREATE TABLE IF NOT EXISTS  dim_SSGA_product
(
   SSGA_Product_Hist_Id BIGINT NOT NULL ,
   SSGA_Product_Base_Id BIGINT NOT NULL ,
   -- ~ Omitted ~
   Tracking_3rd_Party_ESG_Index    STRING ,
```

Actual output
```SQL
CREATE TABLE IF NOT EXISTS dim_ssga_security (
  ssga_security_hist_id BIGINT NOT NULL, --'ssga_' is a lower case while original is upper case 'SSGA_'
  ssga_security_base_id BIGINT NOT NULL, -- Same above
  -- ~ Omitted ~
  -- Missing > Tracking_3rd_Party_ESG_Index    STRING /*NULL ,
  -- ~ Omitted ~
```

# Documents
[Trying out the SQLGlot](docs/trying_out_sqlglot.md)
