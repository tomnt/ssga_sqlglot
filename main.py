import os.path
import re
import sqlglot
import sqlparse
import sys

INPUT_PATH = 'sql/input/'
OUTPUT_PATH = 'sql/output/'

"""
[Original Redshift style SQL statements such as 'DISTSTYLE' and 'DISTKEY']
    DISTSTYLE KEY
    DISTKEY (SSGA_security_base_id);

[Output: Translated statements]
    USING DELTA
    TBLPROPERTIES('DELTA.FEATURE.ALLOWCOLUMNDEFAULTS' = 'SUPPORTED','delta.isolationLevel' = 'Serializable','delta.feature.timestampNtz' = 'supported');
    
    ALTER TABLE dim_SSGA_security ALTER COLUMN Effective_Timestamp DROP DEFAULT;
    ALTER TABLE dim_SSGA_security ALTER COLUMN Effective_Timestamp SET DEFAULT (TO_UTC_TIMESTAMP(CURRENT_TIMESTAMP(), CURRENT_TIMEZONE()));
"""


def __get_table_name_from_sql_create_statment(sql_create_statment: str) -> str:
    """
    Obtains table name from given CREATE SQL statement
    :param sql_create_statment: CREATE SQL statements
    :type sql_create_statment: str
    :return: table name
    :rtype: str
    """
    parsed = sqlparse.parse(sql_create_statment)[0]
    if parsed.tokens[0].value == 'CREATE':
        for t in parsed.tokens:
            if t.is_group is True and t.is_keyword is False and t.is_whitespace is False and t.ttype is None:
                return str(t.normalized)
        raise Exception(f'Given SQL statement does not contain table name. > {sql_create_statment}')
    else:
        raise Exception(f'Given SQL statement is not CREATE statement. > {sql_create_statment}')


def __tranlate_distribution_style_in_sql(sql: str) -> str:
    """
    Tranlate distribution styles statements in the Redshift style SQL such as 'DISTSTYLE' and 'DISTKEY'.
    :param sql: original SQL statements with the Redshift style SQL such as 'DISTSTYLE' and 'DISTKEY'.
    :type sql: str
    :return: Tranlated SQL
    :rtype: str
    """
    table_name = __get_table_name_from_sql_create_statment(sql)
    parsed = sqlparse.parse(sql)[0]
    sql_tranlated = ''
    for t in parsed.tokens:
        if 'DISTSTYLE' in str(t.normalized):

            sql_tmp = str(t.normalized)
            sql_tmp = sql_tmp.replace('DISTSTYLE', '')
            sql_tranlated += sql_tmp

            sql_tranlated += """  USING DELTA
  TBLPROPERTIES('DELTA.FEATURE.ALLOWCOLUMNDEFAULTS' = 'SUPPORTED','delta.isolationLevel' = 'Serializable','delta.feature.timestampNtz' = 'supported');
  
  ALTER TABLE """ + table_name + """ ALTER COLUMN Effective_Timestamp DROP DEFAULT;
  ALTER TABLE """ + table_name + """" ALTER COLUMN Effective_Timestamp SET DEFAULT (TO_UTC_TIMESTAMP(CURRENT_TIMESTAMP(), CURRENT_TIMEZONE()));
            """
            return sql_tranlated
        else:
            sql_tranlated += str(t.normalized)
    return sql_tranlated


def translate(input_filename: str) -> None:
    # Read file
    f = open(INPUT_PATH + input_filename, 'r')
    input_file_content = f.read()

    # Translate the SQL dialects syntax
    sqls = sqlglot.transpile(input_file_content, read="redshift", write="databricks", pretty=True)

    # Tranlate distribution styles statements in the Redshift style SQL such as 'DISTSTYLE' and 'DISTKEY'
    output_sqls = []
    for sql in sqls:
        output_sqls.append(__tranlate_distribution_style_in_sql(sql))
    output_file_content = ';\n\n'.join(output_sqls)

    # Replace 'VARCHAR\(*)' to 'STRING'.
    output_file_content = re.sub('VARCHAR\(+[0-9]+\)', 'STRING', output_file_content)

    # Replace 'CREATE VIEW ' to 'CREATE OR REPLACE VIEW'.
    output_file_content = output_file_content.replace('CREATE VIEW ', 'CREATE OR REPLACE VIEW ')

    # # Adding semicolon at the end of the file.
    # if len(sqls) > 0 and len(output_file_content):
    #     output_file_content += ';'

    # Write file
    f = open(os.path.join(OUTPUT_PATH, 'out_' + input_filename), 'w')
    print(output_file_content)  # forDebug
    f.write(output_file_content)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        input_filename = sys.argv[1]
    else:
        input_filename = 'Redshift_DDL_3_Tables.sql'
    translate(input_filename)
