DROP TABLE IF EXISTS dim_SSGA_security;


CREATE TABLE IF NOT EXISTS  dim_SSGA_security
(
   SSGA_Security_Hist_Id BIGINT NOT NULL ,
   SSGA_Security_Base_Id BIGINT NOT NULL ,
   SSGA_Issuer_Base_Id  BIGINT NOT NULL ,
   SSGA_Batch_Base_Id   BIGINT NOT NULL ,
   SSGA_Security_Id     BIGINT NOT NULL ,
   Effective_Timestamp  TIMESTAMP_NTZ /*DEFAULT  (SYSDATE AT TIME ZONE CURRENT_SETTING('TIMEZONE') AT TIME ZONE 'UTC')*/  NOT NULL ,
   Accrued_Factor       NUMERIC(18,8) /*NULL*/ ,
   Asset_Type           STRING /*NULL*/ ,
   Amount_Issued        NUMERIC(30,12) /*NULL*/ ,
   Callable_Flag        STRING /*NULL*/ ,
   Convertible_Flag     STRING /*NULL*/ ,
   Collateral_Type      STRING /*NULL*/ ,
   Country_Of_Issuer_Code STRING /*NULL*/ ,
   Country_Of_Risk_Code STRING /*NULL*/ ,
   Coupon_Rate          NUMERIC(20,4) /*NULL*/ ,
   Coupon_Type          STRING /*NULL*/ ,
   CUSIP                STRING /*NULL*/ ,
   DBRS_LT_Rating_Code  STRING /*NULL*/ ,
   Expected_Maturity_Calendar_Day DATE /*NULL*/ ,
   Fitch_LT_MMkt_Rating_Code STRING /*NULL*/ ,
   Fitch_LT_Rating_Code STRING /*NULL*/ ,
   Fitch_LT_Rating_Calendar_Day DATE /*NULL*/ ,
   Fitch_LT_Rating_Source STRING /*NULL*/ ,
   Fitch_LT_Rating_Type STRING /*NULL*/ ,
   Fitch_Progressive_MMkt_Rating_Code STRING /*NULL*/ ,
   Fitch_ST_MMkt_Rating_Code STRING /*NULL*/ ,
   Fitch_ST_Rating_Code STRING /*NULL*/ ,
   Fitch_ST_Rating_Calendar_Day DATE /*NULL*/ ,
   Fitch_ST_Rating_Source STRING /*NULL*/ ,
   Fitch_ST_Rating_Type STRING /*NULL*/ ,
   Floater_Flag         STRING /*NULL*/ ,
   Fund_Type            STRING /*NULL*/ ,
   GICS_Industry_Group_Code STRING /*NULL*/ ,
   GICS_Industry_Group_Name STRING /*NULL*/ ,
   GICS_Sector_Code     STRING /*NULL*/ ,
   GICS_Sector_Name     STRING /*NULL*/ ,
   GICS_Industry_Code   STRING /*NULL*/ ,
   GICS_Industry_Name   STRING /*NULL*/ ,
   GICS_Sub_Industry_Code STRING /*NULL*/ ,
   GICS_Sub_Industry_Name STRING /*NULL*/ ,
   Immediate_Parent_Company_Id STRING /*NULL*/ ,
   Immediate_Parent_Company_Name STRING /*NULL*/ ,
   Bbg_Industry_Group   STRING /*NULL*/ ,
   Bbg_Industry_Sector  STRING /*NULL*/ ,
   Bbg_Industry_Subgroup STRING /*NULL*/ ,
   ISIN_Id              STRING /*NULL*/ ,
   Issue_Calendar_Day   DATE /*NULL*/ ,
   Issuer_Industry_Name STRING /*NULL*/ ,
   Issuer_Name          STRING /*NULL*/ ,
   Last_Refix_Calendar_Day DATE /*NULL*/ ,
   Market_Sector_Desc   STRING /*NULL*/ ,
   Maturity_Calendar_Day DATE /*NULL*/ ,
   Moodys_LT_MMkt_Rating_Code STRING /*NULL*/ ,
   Moodys_LT_Rating_Code STRING /*NULL*/ ,
   Moodys_LT_Rating_Calendar_Day DATE /*NULL*/ ,
   Moodys_LT_Rating_Source STRING /*NULL*/ ,
   Moodys_LT_Rating_Type STRING /*NULL*/ ,
   Moodys_Progressive_MMkt_Rating_Code STRING /*NULL*/ ,
   Moodys_ST_MMkt_Rating_Code STRING /*NULL*/ ,
   Moodys_ST_Rating_Code STRING /*NULL*/ ,
   Moodys_ST_Rating_Calendar_Day DATE /*NULL*/ ,
   Moodys_ST_Rating_Source STRING /*NULL*/ ,
   Moodys_ST_Rating_Type STRING /*NULL*/ ,
   Mortgage_Credit_Provider STRING /*NULL*/ ,
   Mortgage_Series      STRING /*NULL*/ ,
   Mortgage_Servicer    STRING /*NULL*/ ,
   Next_Call_Calendar_Day DATE /*NULL*/ ,
   Next_Payment_Calendar_Day DATE /*NULL*/ ,
   Next_Put_Calendar_Day DATE /*NULL*/ ,
   Next_Reset_Calendar_Day DATE /*NULL*/ ,
   Outstanding_Amount   NUMERIC(30,12) /*NULL*/ ,
   Par_Amount           NUMERIC(38,14) /*NULL*/ ,
   Putable_Flag         STRING /*NULL*/ ,
   Private_Asset_Class_Desc STRING /*NULL*/ ,
   Private_Sector_Desc  STRING /*NULL*/ ,
   Private_Sector_Detail STRING /*NULL*/ ,
   SP_LT_Watchlist_Direction STRING /*NULL*/ ,
   SP_LT_Watchlist_Date DATE /*NULL*/ ,
   SP_ST_Watchlist_Direction STRING /*NULL*/ ,
   SP_ST_Watchlist_Date DATE /*NULL*/ ,
   Fitch_LT_Watchlist_Direction STRING /*NULL*/ ,
   Fitch_LT_Watchlist_Date DATE /*NULL*/ ,
   Fitch_ST_Watchlist_Direction STRING /*NULL*/ ,
   Fitch_ST_Watchlist_Date DATE /*NULL*/ ,
   Moodys_LT_Watchlist_Direction STRING /*NULL*/ ,
   Moodys_LT_Watchlist_Date DATE /*NULL*/ ,
   Moodys_ST_Watchlist_Direction STRING /*NULL*/ ,
   Moodys_ST_Watchlist_Date DATE /*NULL*/ ,
   Refix_Frequency      STRING /*NULL*/ ,
   Remaining_Maturity   NUMERIC(30,12) /*NULL*/ ,
   REPO_Collateral_Name STRING /*NULL*/ ,
   REPO_Collateral_Type STRING /*NULL*/ ,
   REPO_Ext_Calendar_Day DATE /*NULL*/ ,
   REPO_Open_Flag       STRING /*NULL*/ ,
   Reset_Index          STRING /*NULL*/ ,
   Security_Days        STRING /*NULL*/ ,
   Security_Desc        STRING /*NULL*/ ,
   Security_Type        STRING /*NULL*/ ,
   Bbg_Sector           STRING /*NULL*/ ,
   Bbg_Subsector        STRING /*NULL*/ ,
   SP_LT_MMkt_Rating_Code STRING /*NULL*/ ,
   SP_LT_Rating_code    STRING /*NULL*/ ,
   SP_LT_Rating_Calendar_Day DATE /*NULL*/ ,
   SP_LT_Rating_Source  STRING /*NULL*/ ,
   SP_LT_Rating_Type    STRING /*NULL*/ ,
   SP_Progressive_MMkt_Rating_Code STRING /*NULL*/ ,
   SP_ST_MMkt_Rating_Code STRING /*NULL*/ ,
   SP_ST_Rating_Code    STRING /*NULL*/ ,
   SP_ST_Rating_Calendar_Day DATE /*NULL*/ ,
   SP_ST_Rating_Source  STRING /*NULL*/ ,
   SP_ST_Rating_Type    STRING /*NULL*/ ,
   Sponsor_Company_Name STRING /*NULL*/ ,
   Ultimate_Parent_Company_Name STRING /*NULL*/ ,
   Ultimate_Parent_Company_Id STRING /*NULL*/ ,
   Yield_To_Maturity    NUMERIC(18,7) /*NULL*/ ,
   Underlying_Type      STRING /*NULL*/ ,
   Underlying_SSGA_Security_Id STRING /*NULL*/ ,
   Report_Timestamp     TIMESTAMP_NTZ /*NULL*/ ,
   Swap_Type            STRING /*NULL*/ ,
   Paying_Leg_Currency_Code STRING /*NULL*/ ,
   Receiving_Leg_Currency_Code STRING /*NULL*/ ,
   Paying_Leg_Float_Rate_Ref STRING /*NULL*/ ,
   Receiving_Leg_Float_Rate_Ref STRING /*NULL*/ ,
   Receiving_Leg_Type   STRING /*NULL*/ ,
   Receiving_Leg_Fixed_Rate NUMERIC(38,16) /*NULL*/ ,
   Paying_Leg_Type      STRING /*NULL*/ ,
   Paying_Leg_Fixed_Rate NUMERIC(38,16) /*NULL*/ ,
   Product_Type         STRING /*NULL*/ ,
   OTC_Original_Counterparty STRING /*NULL*/ ,
   OTC_Start_Date       DATE /*NULL*/ ,
   OTC_End_Date         DATE /*NULL*/ ,
   Paying_Leg_Spread    NUMERIC(30,12) /*NULL*/ ,
   Paying_Leg_Rolling_Period_Count NUMERIC(16,0) /*NULL*/ ,
   Paying_Leg_Rolling_Period_Unit STRING /*NULL*/ ,
   Paying_Leg_Day_Count STRING /*NULL*/ ,
   Paying_Leg_Reset_Period_Count NUMERIC(16,0) /*NULL*/ ,
   Paying_Leg_Reset_Period_Unit STRING /*NULL*/ ,
   Paying_Leg_Reset_Type STRING /*NULL*/ ,
   Receiving_Leg_Spread NUMERIC(30,12) /*NULL*/ ,
   Receiving_Leg_Rolling_Period_Count NUMERIC(16,0) /*NULL*/ ,
   Receiving_Leg_Rolling_Period_Unit STRING /*NULL*/ ,
   Receiving_Leg_Day_Count STRING /*NULL*/ ,
   Receiving_Leg_Reset_Period_Count NUMERIC(16,0) /*NULL*/ ,
   Receiving_Leg_Reset_Period_Unit STRING /*NULL*/ ,
   Receiving_Leg_Reset_Type STRING /*NULL*/ ,
   Used_Price_End       NUMERIC(38,16) /*NULL*/ ,
   Base_Index           STRING /*NULL*/ ,
   Base_Index_Type      STRING /*NULL*/ ,
   Base_Index_Value     NUMERIC(30,12) /*NULL*/ ,
   Traded_Fixed_Rate    NUMERIC(30,12) /*NULL*/ ,
   OTC_Traded_Backend_Notional NUMERIC(30,12) /*NULL*/ ,
   OTC_Traded_Frontend_Notional NUMERIC(30,12) /*NULL*/ ,
   OTC_Contract_Size    NUMERIC(38,16) /*NULL*/ ,
   REPO_Notice_Period_Count NUMERIC(16,0) /*NULL*/ ,
   REPO_Notice_Period_Unit STRING /*NULL*/ ,
   Strike_Price         NUMERIC(30,12) /*NULL*/ ,
   Security_Id          STRING /*NULL*/ ,
   Private_Placement_Flag STRING /*NULL*/ ,
   Guarantor_Id         STRING /*NULL*/ ,
   Coupon_Currency_Code STRING /*NULL*/ ,
   Coupon_Payment_Frequency BIGINT /*NULL*/ ,
   Expiration_Timestamp TIMESTAMP_NTZ /*NULL*/ ,
   Options_Id           STRING /*NULL*/ ,
   Shares_Outstanding   NUMERIC(38,6) /*NULL*/ ,
   Bbg_Security_Id      STRING /*NULL*/ ,
   Not_In_Source_Bool   BOOLEAN /*NULL*/ ,
   Flag_144A            STRING /*NULL*/ ,
   Registration_S_Flag  STRING /*NULL*/ ,
   Inflation_Linked_Indicator STRING /*NULL*/ ,
   Type_Of_Bond         STRING /*NULL*/ ,
   Future_Category      STRING /*NULL*/ ,
   Final_Maturity_Date  DATE /*NULL*/ ,
   Bbg_Id               STRING /*NULL*/ ,
   Future_Securities_First_Trade_Date DATE /*NULL*/ ,
   Next_Call_Price      NUMERIC(22,6) /*NULL*/ ,
   Next_Put_Price       NUMERIC(22,6) /*NULL*/ ,
   Floater_Spread       NUMERIC(12,3) /*NULL*/ ,
   Future_Contract_Size NUMERIC(18,2) /*NULL*/ ,
   Future_First_Delivery_Date DATE /*NULL*/ ,
   Future_Last_Delivery_Date DATE /*NULL*/ ,
   Clearing_Exchange_Code STRING /*NULL*/ ,
   CINS_Security_Id     STRING /*NULL*/ ,
   RIC_Future_Securities_Code STRING /*NULL*/ ,
   Alt_Root_Alias_Id    STRING /*NULL*/ ,
   Executing_Broker     STRING /*NULL*/ ,
   Option_Currency_Code STRING /*NULL*/ ,
   Option_Exercise_Type STRING /*NULL*/ ,
   Option_Style         STRING /*NULL*/ ,
   Bbg_CDR_Settle_Code  STRING /*NULL*/ ,
   Bbg_Global_Company_Id STRING /*NULL*/ ,
   CRD_Source_Security_Type STRING /*NULL*/ ,
   CRD_Source_External_Security_Id STRING /*NULL*/ ,
   CRD_Source_OTC_Security_Id STRING /*NULL*/ ,
   Clearing_Broker_Code STRING /*NULL*/ ,
   Factset_Shares_Outstanding NUMERIC(38,6) /*NULL*/ ,
   Factset_Country_Of_Domicile_Code STRING /*NULL*/ ,
   Factset_Country_Of_Incorporation_Code STRING /*NULL*/ ,
   Factset_GICS_Industry_Code STRING /*NULL*/ ,
   Worldscope_Shares_Outstanding NUMERIC(38,6) /*NULL*/ ,
   Factset_Outstanding_Total_Votes BIGINT /*NULL*/ ,
   Country_Of_Issue_Code STRING /*NULL*/ ,
   Country_Of_Domicile_Code STRING /*NULL*/ ,
   Municipal_Bond_Tax_Code STRING /*NULL*/ ,
   Mortgage_Prepay_Type STRING /*NULL*/ ,
   Start_Acc_Date       DATE /*NULL*/ ,
   Flt_Int_Acc_Type     STRING /*NULL*/ ,
   First_Coupon_Date    DATE /*NULL*/ ,
   Mortgage_Pool_Number STRING /*NULL*/ ,
   Issuer_Id            BIGINT /*NULL*/ ,
   DBRS_LT_Rating_Calendar_Day DATE /*NULL*/ ,
   DBRS_LT_Rating_Source STRING /*NULL*/ ,
   DBRS_ST_Rating_Code  STRING /*NULL*/ ,
   DBRS_ST_Rating_Calendar_Day DATE /*NULL*/ ,
   DBRS_ST_Rating_Source STRING /*NULL*/ ,
   Underlying_ISIN      STRING /*NULL*/ ,
   Underlying_CUSIP     STRING /*NULL*/ ,
   Option_Type          STRING /*NULL*/ ,
   Point_Security_Type  STRING /*NULL*/ ,
   Subordinate_Type     STRING /*NULL*/ ,
   Trading_to_Flag      STRING /*NULL*/ ,
   Security_Type2       STRING /*NULL*/ ,
   Shell_Security_Flag  STRING /*NULL*/ ,
   Shell_Security_Arrival_Date DATE /*NULL*/ ,
   Bbg_Legacy_Barclays_Broad_Name STRING /*NULL*/ ,
   Bbg_Legacy_Barclays_Detail_Name STRING /*NULL*/ ,
   Benchmark_Security_Id BIGINT /*NULL*/ ,
   Sink_Bond_Flag       STRING /*NULL*/ ,
   Mortgage_Controlized_Obligation_Class_Name STRING /*NULL*/ ,
   Tradable_Minimum_Amount NUMERIC(22,6) /*NULL*/ ,
   Call_Date            DATE /*NULL*/ ,
   Calculation_Type_Code INTEGER /*NULL*/ ,
   Market_Price_Update_Timestamp TIMESTAMP_NTZ /*NULL*/ ,
   Private_Placement_144A_Registration_Rights_Flag STRING /*NULL*/ ,
   Mortgage_Factor_Date DATE /*NULL*/ ,
   Security_Class_Name  STRING /*NULL*/ ,
   Security_Group_Name  STRING /*NULL*/ ,
   Asset_Major_Code     STRING /*NULL*/ ,
   Asset_Minor_Code     STRING /*NULL*/ ,
   Issue_Short_Name     STRING /*NULL*/ ,
   Call_Type_Code       STRING /*NULL*/ ,
   Trading_System_Id    STRING /*NULL*/ ,
   Effective_Yield      NUMERIC(22,6) /*NULL*/ ,
   Mortgage_Deal_Name   STRING /*NULL*/ ,
   Classifying_Financial_Instrument_Code STRING /*NULL*/ ,
   Market_Sector_Code   STRING /*NULL*/ ,
   Primary_Security_Id  STRING /*NULL*/ ,
   Primary_Security_Id_Type STRING /*NULL*/ ,
   Increment_Minimum_Amount NUMERIC(22,6) /*NULL*/ ,
   Mortgage_Factor      NUMERIC(22,8) /*NULL*/ ,
   Internal_Security_Id_MDF BIGINT /*NULL*/ ,
   Internal_Security_Id_GCDF NUMERIC(38,0) /*NULL*/ ,
   Internal_Security_Id_IDR NUMERIC(38,0) /*NULL*/ ,
   Internal_Security_Id_FA STRING /*NULL*/ ,
   Underlying_Internal_Security_Id_MDF BIGINT /*NULL*/ ,
   RITS_Id              STRING /*NULL*/ ,
   Underlying_RITS_Id   STRING /*NULL*/ ,
   PRKS_Id              STRING /*NULL*/ ,
   Portia_Internal_Key  STRING /*NULL*/ ,
   GCDF_Application_Key STRING /*NULL*/ ,
   MCH_Id               STRING /*NULL*/ ,
   Crd_Source_Security_Id BIGINT /*NULL*/ ,
   GX_Source_Security_Id BIGINT /*NULL*/ ,
   Standard_Security_Type_Level1 STRING /*NULL*/ ,
   Standard_Security_Type_Level2 STRING /*NULL*/ ,
   Standard_Security_Type_Level3 STRING /*NULL*/ ,
   Standard_Issuer_Name STRING /*NULL*/ ,
   Capital_Contingent_Security STRING /*NULL*/ ,
   Internal_Underlying_Fund_Alias STRING /*NULL*/ ,
   Internal_Underlying_Fund_Base_Id BIGINT /*NULL*/ ,
   Internal_Underlying_Portfolio_Type_Sub_Class STRING /*NULL*/ ,
   Internal_Underlying_Parent_Fund_Alias STRING /*NULL*/ ,
   Internal_Underlying_Parent_Fund_Base_Id BIGINT /*NULL ,
CONSTRAINT  XPKDIM_SSGA_SECURITY PRIMARY KEY (SSGA_Security_Hist_Id),
CONSTRAINT  XAK2DIM_SSGA_SECURITY UNIQUE (SSGA_Security_Hist_Id,SSGA_Security_Base_Id),
CONSTRAINT fk_batch_to_security FOREIGN KEY (SSGA_Batch_Base_Id) REFERENCES tbl_SSGA_batch (SSGA_Batch_Base_Id)*/
)
/*DISTSTYLE KEY DISTKEY(SSGA_Security_Base_Id) SORTKEY AUTO;*/
USING DELTA
TBLPROPERTIES('DELTA.FEATURE.ALLOWCOLUMNDEFAULTS' = 'SUPPORTED','delta.isolationLevel' = 'Serializable','delta.feature.timestampNtz' = 'supported');

ALTER TABLE dim_SSGA_security ALTER COLUMN Effective_Timestamp DROP DEFAULT;
ALTER TABLE dim_SSGA_security ALTER COLUMN Effective_Timestamp SET DEFAULT (TO_UTC_TIMESTAMP(CURRENT_TIMESTAMP(), CURRENT_TIMEZONE()));
