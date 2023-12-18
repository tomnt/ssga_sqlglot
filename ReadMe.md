# SQLGlot tryout

# Environments
```
python --version
Python 3.9.13
```

# Setup
Set proxy(If needed)
```shell
set https_proxy=http://pzenproxy.statestr.com:80 --trusted-host pypi.org --trusted -host files.pythonhosted.org
```
Install packages
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
  - ## SQLGlot related
  - 'SORTKEY (asof_calendar_day)' might not work. > ValueError: Expected an Expression. Received <class 'list'>: [(IDENTIFIER this: asof_calendar_day, quoted: False)]
  - SQL functions are not supported.
  - Meta commands are not supported.
  - 'VIEW' statement is not supported.
  - (Patched) 'STRING' type could be converted to 'VARCHAR(*)'.
  - ## Others
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

# SQLGlot Workflow
![Workflow](./docs/sqlglot_workflow.png)

## __init__.transpile() arguments
 - **sql** (str): the SQL code string to transpile.
 - **read** (DialectType): the source dialect used to parse the input string (eg. "spark", "hive", "presto", "mysql").
 - **write** (DialectType): the target dialect into which the input should be transformed (eg. "spark", "hive", "presto", "mysql").
 - **identity** (bool): if set to `True` and if the target dialect is not specified the source dialect will be used as both: the source and the target dialect.
 - **error_level** (ErrorLevel): the desired error level of the parser.
 - **opts: other `sqlglot.generator.Generator` options.

## sqlglot.generator.Generator options
    pretty: Whether or not to format the produced SQL string.
        Default: False.
    identify: Determines when an identifier should be quoted. Possible values are:
        False (default): Never quote, except in cases where it's mandatory by the dialect.
        True or 'always': Always quote.
        'safe': Only quote identifiers that are case insensitive.
    normalize: Whether or not to normalize identifiers to lowercase.
        Default: False.
    pad: Determines the pad size in a formatted string.
        Default: 2.
    indent: Determines the indentation size in a formatted string.
        Default: 2.
    normalize_functions: Whether or not to normalize all function names. Possible values are:
        "upper" or True (default): Convert names to uppercase.
        "lower": Convert names to lowercase.
        False: Disables function name normalization.
    unsupported_level: Determines the generator's behavior when it encounters unsupported expressions.
        Default ErrorLevel.WARN.
    max_unsupported: Maximum number of unsupported messages to include in a raised UnsupportedError.
        This is only relevant if unsupported_level is ErrorLevel.RAISE.
        Default: 3
    leading_comma: Determines whether or not the comma is leading or trailing in select expressions.
        This is only relevant when generating in pretty mode.
        Default: False
    max_text_width: The max number of characters in a segment before creating new lines in pretty mode.
        The default is on the smaller end because the length only represents a segment and not the true
        line length.
        Default: 80
    comments: Whether or not to preserve comments in the output SQL code.
        Default: True
## Trace
```shell
__init__.transpile() t.List[str]
    __init__.parse(sql: str, read: DialectType) -> t.List[t.Optional[Expression]]
        Dialect.parse(sql: str) -> t.List[t.Optional[exp.Expression]]
            Dialect.tokenize(sql: str)
              Tokenizer.tokenize(sql: str) -> t.List[Token]
            Parser.parse(raw_tokens: t.List[Token], sql: t.Optional[str] = None
        ) -> t.List[t.Optional[exp.Expression]]:
    Dialect.get_or_raise(write: DialectType)() -> t.Type[Dialect]
        Dialect.generate(expression: t.Optional[exp.Expression]) -> str
        Generator.generate(...) -> str
            Generator.sql(...)
            Expression.transform(fun, *args, copy)
            Expression.replace_children(...)
```
## __init__.transpile
```python
def transpile(
    sql: str,
    read: DialectType = None,
    write: DialectType = None,
    identity: bool = True,
    error_level: t.Optional[ErrorLevel] = None,
    **opts,
) -> t.List[str]:
    """
    Parses the given SQL string in accordance with the source dialect and returns a list of SQL strings transformed
    to conform to the target dialect. Each string in the returned list represents a single transformed SQL statement.

    Args:
        sql: the SQL code string to transpile.
        read: the source dialect used to parse the input string (eg. "spark", "hive", "presto", "mysql").
        write: the target dialect into which the input should be transformed (eg. "spark", "hive", "presto", "mysql").
        identity: if set to `True` and if the target dialect is not specified the source dialect will be used as both:
            the source and the target dialect.
        error_level: the desired error level of the parser.
        **opts: other `sqlglot.generator.Generator` options.

    Returns:
        The list of transpiled SQL statements.
    """
    write = (read if write is None else write) if identity else write
    # return [
    #     Dialect.get_or_raise(write)().generate(expression, **opts)
    #     for expression in parse(sql, read, error_level=error_level)
    # ]

    #fordebug
    r = [
        Dialect.get_or_raise(write)().generate(expression, **opts)

        for expression in parse(sql, read, error_level=error_level)
    ]

    print('__init__.transpile: r: ',r) #forDebug

    return r
```

## Dialect
```python
    def parser(self, **opts) -> Parser:
        print('Dialect.parser') # forDebug
        return self.parser_class(**opts)

    # ~~ Omited ~~
    
    def tokenize(self, sql: str) -> t.List[Token]:
        print(f'Dialect.tokenize({sql}): self.tokenizer.tokenize(sql): ', self.tokenizer.tokenize(sql))  # forDebug
        return self.tokenizer.tokenize(sql)

    # ~~ Omited ~~
    
    def generate(self, expression: t.Optional[exp.Expression], **opts) -> str:
        r = self.generator(**opts).generate(expression) # forDebug
        print(f'Dialect.generate: ', r) # forDebug
        return r # forDebug
        # return self.generator(**opts).generate(expression) # forDebug
```

## Postgres
```python
    class Tokenizer(tokens.Tokenizer):
        QUOTES = ["'", "$$"]

        BIT_STRINGS = [("b'", "'"), ("B'", "'")]
        HEX_STRINGS = [("x'", "'"), ("X'", "'")]
        BYTE_STRINGS = [("e'", "'"), ("E'", "'")]

        KEYWORDS = {
            # ~~ Omitted ~~
            "CHARACTER VARYING": TokenType.TEXT, # "CHARACTER VARYING": TokenType.VARCHAR, #forDebug
            # ~~ Omitted ~~
        }

```

## Generator.generate
```python
        self.unsupported_messages = []
        sql = self.sql(expression).strip()
        sql += '[Generator.generate()]' #forDebug
        self._cache = None
```


## Parser
```python
    def parse(
        self, raw_tokens: t.List[Token], sql: t.Optional[str] = None
    ) -> t.List[t.Optional[exp.Expression]]:
    # ~~ Omitted ~~
        print('Parser.parse') # forDebug
        return self._parse(
            parse_method=self.__class__._parse_statement, raw_tokens=raw_tokens, sql=sql
        )
```
## Tokenizer
```python
    def __init__(
        # ~~ Omitted ~~
    ) -> None:
        """Token initializer.
            # ~~ Omitted ~~
        """
        print("Tokens.__init__(): text:",text) #forDebug
        # ~~ Omitted ~~
        
# ~~ Omitted ~~
    def tokenize(self, sql: str) -> t.List[Token]:
        """Returns a list of tokens corresponding to the SQL string `sql`."""
        self.reset()
        self.sql = sql
        self.size = len(sql)
        try:
            print(f'Tokenizer.tokenize(): before scan')  # forDebug
            self._scan()
            print(f'Tokenizer.tokenize(): after scan')  # forDebug
            # ~~ Omitted ~~
```

## Redshift
```python
            # exp.DistKeyProperty: lambda self, e: f"DISTKEY({e.name})", # forDebug # No impact on the output
            # exp.DistStyleProperty: lambda self, e: self.naked_property(e), # forDebug # No impact on the output
```

## sql/input/sample.sql
```sql
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
```

## Output
```shell
(venv) user@MBP-2021 ssga_sqlglot% python main.py sample.sql
Dialect.parser
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: CREATE
Tokens.__init__(): text: TABLE
Tokens.__init__(): text: IF
Tokens.__init__(): text: NOT
Tokens.__init__(): text: EXISTS
Tokens.__init__(): text: my_table
Tokens.__init__(): text: (
Tokens.__init__(): text: my_int
Tokens.__init__(): text: integer
Tokens.__init__(): text: not
Tokens.__init__(): text: null
Tokens.__init__(): text: ,
Tokens.__init__(): text: my_num
Tokens.__init__(): text: numeric
Tokens.__init__(): text: (
Tokens.__init__(): text: 18
Tokens.__init__(): text: ,
Tokens.__init__(): text: 8
Tokens.__init__(): text: )
Tokens.__init__(): text: ,
Tokens.__init__(): text: my_char_var
Tokens.__init__(): text: CHARACTER VARYING
Tokens.__init__(): text: (
Tokens.__init__(): text: 28
Tokens.__init__(): text: )
Tokens.__init__(): text: )
Tokens.__init__(): text: DISTSTYLE
Tokens.__init__(): text: KEY
Tokens.__init__(): text: DISTKEY
Tokens.__init__(): text: (
Tokens.__init__(): text: SSGA_security_exchange_base_id
Tokens.__init__(): text: )
Tokens.__init__(): text: ;
Tokenizer.tokenize(): after scan
Dialect.tokenize(CREATE TABLE IF NOT EXISTS my_table (
   my_int     integer not null,
   my_num       numeric(18,8),
   my_char_var           character varying(28)
)
DISTSTYLE KEY
DISTKEY (SSGA_security_exchange_base_id)
;

--CREATE VIEW my_view AS
--  SELECT my_num, my_char_var
--  FROM my_table;
): self.tokenizer.tokenize(sql):  [<Token token_type: TokenType.CREATE, text: CREATE, line: 1, col: 6, start: 0, end: 5, comments: []>, <Token token_type: TokenType.TABLE, text: TABLE, line: 1, col: 12, start: 7, end: 11, comments: []>, <Token token_type: TokenType.IF, text: IF, line: 1, col: 15, start: 13, end: 14, comments: []>, <Token token_type: TokenType.NOT, text: NOT, line: 1, col: 19, start: 16, end: 18, comments: []>, <Token token_type: TokenType.EXISTS, text: EXISTS, line: 1, col: 26, start: 20, end: 25, comments: []>, <Token token_type: TokenType.VAR, text: my_table, line: 1, col: 35, start: 27, end: 34, comments: []>, <Token token_type: TokenType.L_PAREN, text: (, line: 1, col: 37, start: 36, end: 36, comments: []>, <Token token_type: TokenType.VAR, text: my_int, line: 2, col: 9, start: 41, end: 46, comments: []>, <Token token_type: TokenType.INT, text: integer, line: 2, col: 21, start: 52, end: 58, comments: []>, <Token token_type: TokenType.NOT, text: not, line: 2, col: 25, start: 60, end: 62, comments: []>, <Token token_type: TokenType.NULL, text: null, line: 2, col: 30, start: 64, end: 67, comments: []>, <Token token_type: TokenType.COMMA, text: ,, line: 2, col: 31, start: 68, end: 68, comments: []>, <Token token_type: TokenType.VAR, text: my_num, line: 3, col: 9, start: 73, end: 78, comments: []>, <Token token_type: TokenType.DECIMAL, text: numeric, line: 3, col: 23, start: 86, end: 92, comments: []>, <Token token_type: TokenType.L_PAREN, text: (, line: 3, col: 24, start: 93, end: 93, comments: []>, <Token token_type: TokenType.NUMBER, text: 18, line: 3, col: 26, start: 94, end: 95, comments: []>, <Token token_type: TokenType.COMMA, text: ,, line: 3, col: 27, start: 96, end: 96, comments: []>, <Token token_type: TokenType.NUMBER, text: 8, line: 3, col: 28, start: 97, end: 97, comments: []>, <Token token_type: TokenType.R_PAREN, text: ), line: 3, col: 29, start: 98, end: 98, comments: []>, <Token token_type: TokenType.COMMA, text: ,, line: 3, col: 30, start: 99, end: 99, comments: []>, <Token token_type: TokenType.VAR, text: my_char_var, line: 4, col: 14, start: 104, end: 114, comments: []>, <Token token_type: TokenType.TEXT, text: CHARACTER VARYING, line: 4, col: 42, start: 126, end: 142, comments: []>, <Token token_type: TokenType.L_PAREN, text: (, line: 4, col: 43, start: 143, end: 143, comments: []>, <Token token_type: TokenType.NUMBER, text: 28, line: 4, col: 45, start: 144, end: 145, comments: []>, <Token token_type: TokenType.R_PAREN, text: ), line: 4, col: 46, start: 146, end: 146, comments: []>, <Token token_type: TokenType.R_PAREN, text: ), line: 5, col: 1, start: 148, end: 148, comments: []>, <Token token_type: TokenType.VAR, text: DISTSTYLE, line: 6, col: 9, start: 150, end: 158, comments: []>, <Token token_type: TokenType.VAR, text: KEY, line: 6, col: 13, start: 160, end: 162, comments: []>, <Token token_type: TokenType.VAR, text: DISTKEY, line: 7, col: 7, start: 164, end: 170, comments: []>, <Token token_type: TokenType.L_PAREN, text: (, line: 7, col: 9, start: 172, end: 172, comments: []>, <Token token_type: TokenType.VAR, text: SSGA_security_exchange_base_id, line: 7, col: 39, start: 173, end: 202, comments: []>, <Token token_type: TokenType.R_PAREN, text: ), line: 7, col: 40, start: 203, end: 203, comments: []>, <Token token_type: TokenType.SEMICOLON, text: ;, line: 8, col: 1, start: 205, end: 205, comments: ['CREATE VIEW my_view AS', '  SELECT my_num, my_char_var', '  FROM my_table;']>]
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: CREATE
Tokens.__init__(): text: TABLE
Tokens.__init__(): text: IF
Tokens.__init__(): text: NOT
Tokens.__init__(): text: EXISTS
Tokens.__init__(): text: my_table
Tokens.__init__(): text: (
Tokens.__init__(): text: my_int
Tokens.__init__(): text: integer
Tokens.__init__(): text: not
Tokens.__init__(): text: null
Tokens.__init__(): text: ,
Tokens.__init__(): text: my_num
Tokens.__init__(): text: numeric
Tokens.__init__(): text: (
Tokens.__init__(): text: 18
Tokens.__init__(): text: ,
Tokens.__init__(): text: 8
Tokens.__init__(): text: )
Tokens.__init__(): text: ,
Tokens.__init__(): text: my_char_var
Tokens.__init__(): text: CHARACTER VARYING
Tokens.__init__(): text: (
Tokens.__init__(): text: 28
Tokens.__init__(): text: )
Tokens.__init__(): text: )
Tokens.__init__(): text: DISTSTYLE
Tokens.__init__(): text: KEY
Tokens.__init__(): text: DISTKEY
Tokens.__init__(): text: (
Tokens.__init__(): text: SSGA_security_exchange_base_id
Tokens.__init__(): text: )
Tokens.__init__(): text: ;
Tokenizer.tokenize(): after scan
Parser.parse
Dialect.parser
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: varchar
Tokenizer.tokenize(): after scan
Dialect.tokenize(varchar): self.tokenizer.tokenize(sql):  [<Token token_type: TokenType.VARCHAR, text: varchar, line: 1, col: 7, start: 0, end: 6, comments: []>]
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: varchar
Tokenizer.tokenize(): after scan
Dialect.parser
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: varchar
Tokenizer.tokenize(): after scan
Dialect.tokenize(varchar): self.tokenizer.tokenize(sql):  [<Token token_type: TokenType.VARCHAR, text: varchar, line: 1, col: 7, start: 0, end: 6, comments: []>]
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: varchar
Tokenizer.tokenize(): after scan
Dialect.parser
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: varchar
Tokenizer.tokenize(): after scan
Dialect.tokenize(varchar): self.tokenizer.tokenize(sql):  [<Token token_type: TokenType.VARCHAR, text: varchar, line: 1, col: 7, start: 0, end: 6, comments: []>]
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: varchar
Tokenizer.tokenize(): after scan
Dialect.parser
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: float
Tokenizer.tokenize(): after scan
Dialect.tokenize(float): self.tokenizer.tokenize(sql):  [<Token token_type: TokenType.FLOAT, text: float, line: 1, col: 5, start: 0, end: 4, comments: []>]
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: float
Tokenizer.tokenize(): after scan
Dialect.parser
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: float
Tokenizer.tokenize(): after scan
Dialect.tokenize(float): self.tokenizer.tokenize(sql):  [<Token token_type: TokenType.FLOAT, text: float, line: 1, col: 5, start: 0, end: 4, comments: []>]
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: float
Tokenizer.tokenize(): after scan
Dialect.parser
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: float
Tokenizer.tokenize(): after scan
Dialect.tokenize(float): self.tokenizer.tokenize(sql):  [<Token token_type: TokenType.FLOAT, text: float, line: 1, col: 5, start: 0, end: 4, comments: []>]
Tokenizer.tokenize(): before scan
Tokens.__init__(): text: float
Tokenizer.tokenize(): after scan
Dialect.generate:  CREATE TABLE IF NOT EXISTS my_table (
  my_int INT NOT NULL,
  my_num DECIMAL(18, 8),
  my_char_var STRING(28)
)
DISTSTYLE=KEY
DISTKEY=SSGA_security_exchange_base_id[Generator.generate()]
__init__.transpile: r:  ['CREATE TABLE IF NOT EXISTS my_table (\n  my_int INT NOT NULL,\n  my_num DECIMAL(18, 8),\n  my_char_var STRING(28)\n)\nDISTSTYLE=KEY\nDISTKEY=SSGA_security_exchange_base_id[Generator.generate()]']
CREATE TABLE IF NOT EXISTS my_table (
  my_int INT NOT NULL,
  my_num DECIMAL(18, 8),
  my_char_var STRING(28)
)
  USING DELTA
  TBLPROPERTIES('DELTA.FEATURE.ALLOWCOLUMNDEFAULTS' = 'SUPPORTED','delta.isolationLevel' = 'Serializable','delta.feature.timestampNtz' = 'supported');
  
  ALTER TABLE my_table ALTER COLUMN Effective_Timestamp DROP DEFAULT;
  ALTER TABLE my_table" ALTER COLUMN Effective_Timestamp SET DEFAULT (TO_UTC_TIMESTAMP(CURRENT_TIMESTAMP(), CURRENT_TIMEZONE()));
```

## Alternatives

1. **sqlparse**: This package can parse SQL statements and generate syntax trees. You can use this tree to transform SQL statements².
2. **sqlalchemy**: This Python library is used to construct SQL statements. With SQLAlchemy, you can build SQL statements using Python objects³.

1: [sqlparse](https://pypi.org/project/sqlparse/)
2: [sqlalchemy](https://www.sqlalchemy.org/)
