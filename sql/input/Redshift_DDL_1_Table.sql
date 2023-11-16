CREATE TABLE IF NOT EXISTS dim_ssga_security_exchange (
   ssga_security_exchange_hist_id bigint                         not null,
   ssga_security_exchange_base_id bigint                         not null,
   ssga_batch_base_id   bigint                         not null,
   issue_id             bigint                         not null,
   ssga_security_id     integer,
   issue_currency_code character varying(4),
   sedol_Security_Id                character varying(40),
   Trading_Country_Code character varying(50),
   primary_exchange_flag character(1),
   mic_code             character varying(50),
   ric                  character varying(40),
   Ticker_Code               character varying(40),
   Bbg_Unique_Id         character varying(40),
   not_in_stage_bool    boolean,
   Exchange_Code            character varying(20),
   effective_timestamp  timestamp                      not null  DEFAULT CAST(SYSDATE AT TIME ZONE 'UTC' AS TIMESTAMP)
)
DISTSTYLE KEY
DISTKEY (SSGA_security_exchange_base_id);
