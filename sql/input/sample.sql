CREATE TABLE IF NOT EXISTS my_table (
   my_int     integer not null,
   my_num       numeric(18,8),
   my_char_var           character varying(28)
)
DISTSTYLE KEY
DISTKEY (SSGA_security_exchange_base_id);
;

--CREATE VIEW my_view AS
--  SELECT my_num, my_char_var
--  FROM my_table;
