USE Database dbs_appl_DataHub;
DROP TABLE IF EXISTS dim_SSGA_security_exchange;

USE Database dbs_appl_DataHub;


CREATE TABLE IF NOT EXISTS  dim_SSGA_security_exchange
(
   SSGA_Security_Exchange_Hist_Id BIGINT NOT NULL ,
   SSGA_Security_Exchange_Base_Id BIGINT NOT NULL ,
   SSGA_Security_Base_Id BIGINT NOT NULL ,
   SSGA_Batch_Base_Id   BIGINT NOT NULL ,
   Issue_Id             BIGINT /*NULL*/ ,
   Issue_Currency_Code  STRING /*NULL*/ ,
   SEDOL_Security_Id    STRING /*NULL*/ ,
   Trading_Country_Code STRING /*NULL*/ ,
   Primary_Exchange_Flag STRING /*NULL*/ ,
   MIC_Code             STRING /*NULL*/ ,
   RIC                  STRING /*NULL*/ ,
   Ticker_Code          STRING /*NULL*/ ,
   Bbg_Unique_Id        STRING /*NULL*/ ,
   Not_In_Source_Bool   BOOLEAN /*NULL*/ ,
  Exchange_Code        STRING /*NULL*/ ,
   Effective_Timestamp  TIMESTAMP /*DEFAULT  (SYSDATE AT TIME ZONE CURRENT_SETTING('TIMEZONE') AT TIME ZONE 'UTC')*/   /*NULL ,
CONSTRAINT  XPKDIM_SSGA_SECURITY_EXCHANGE PRIMARY KEY (SSGA_Security_Exchange_Hist_Id),
CONSTRAINT  XAK1DIM_SSGA_SECURITY_EXCHANGE UNIQUE (SSGA_Security_Exchange_Hist_Id,SSGA_Security_Exchange_Base_Id),
CONSTRAINT fk_batch_to_security_exchange FOREIGN KEY (SSGA_Batch_Base_Id) REFERENCES tbl_SSGA_batch (SSGA_Batch_Base_Id)*/
)
/*DISTSTYLE KEY DISTKEY(SSGA_Security_Base_Id) SORTKEY AUTO;*/
USING DELTA
TBLPROPERTIES('DELTA.FEATURE.ALLOWCOLUMNDEFAULTS' = 'SUPPORTED','delta.isolationLevel' = 'Serializable','delta.feature.timestampNtz' = 'supported');

ALTER TABLE dim_SSGA_security_exchange ALTER COLUMN Effective_Timestamp DROP DEFAULT;
ALTER TABLE dim_SSGA_security_exchange ALTER COLUMN Effective_Timestamp SET DEFAULT (TO_UTC_TIMESTAMP(CURRENT_TIMESTAMP(), CURRENT_TIMEZONE()));
