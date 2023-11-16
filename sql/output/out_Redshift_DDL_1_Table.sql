CREATE TABLE IF NOT EXISTS dim_ssga_security_exchange (
  ssga_security_exchange_hist_id BIGINT NOT NULL,
  ssga_security_exchange_base_id BIGINT NOT NULL,
  ssga_batch_base_id BIGINT NOT NULL,
  issue_id BIGINT NOT NULL,
  ssga_security_id INT,
  issue_currency_code VARCHAR(4),
  sedol_Security_Id VARCHAR(40),
  Trading_Country_Code VARCHAR(50),
  primary_exchange_flag CHAR(1),
  mic_code VARCHAR(50),
  ric VARCHAR(40),
  Ticker_Code VARCHAR(40),
  Bbg_Unique_Id VARCHAR(40),
  not_in_stage_bool BOOLEAN,
  Exchange_Code VARCHAR(20),
  effective_timestamp TIMESTAMP NOT NULL DEFAULT CAST(FROM_UTC_TIMESTAMP(CURRENT_TIMESTAMP(), 'UTC') AS TIMESTAMP)
)
  USING DELTA
  TBLPROPERTIES('DELTA.FEATURE.ALLOWCOLUMNDEFAULTS' = 'SUPPORTED','delta.isolationLevel' = 'Serializable','delta.feature.timestampNtz' = 'supported');
  
  ALTER TABLE dim_ssga_security_exchange ALTER COLUMN Effective_Timestamp DROP DEFAULT;
  ALTER TABLE dim_ssga_security_exchange" ALTER COLUMN Effective_Timestamp SET DEFAULT (TO_UTC_TIMESTAMP(CURRENT_TIMESTAMP(), CURRENT_TIMEZONE()));
            ;