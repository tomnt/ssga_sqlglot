import argparse
import os.path
import re
import sqlglot
import sqlparse
import yaml


class Translator:
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

    @staticmethod
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

    def __tranlate_distribution_style_in_sql(self, sql: str) -> str:
        """
        Tranlate distribution styles statements in the Redshift style SQL such as 'DISTSTYLE' and 'DISTKEY'.
        :param sql: original SQL statements with the Redshift style SQL such as 'DISTSTYLE' and 'DISTKEY'.
        :type sql: str
        :return: Tranlated SQL
        :rtype: str
        """
        table_name = self.__get_table_name_from_sql_create_statment(sql)
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
  ALTER TABLE """ + table_name + """ ALTER COLUMN Effective_Timestamp SET DEFAULT (TO_UTC_TIMESTAMP(CURRENT_TIMESTAMP(), CURRENT_TIMEZONE()));
            """
                return sql_tranlated
            else:
                sql_tranlated += str(t.normalized)
        return sql_tranlated

    def __customize_databricks(self, sqls: list, map: dict) -> list:
        """
        Customize Databricks SQL statements' syntax.
        :param sqls: List of SQL statements to customize.
        :type sqls: list
        :param map:
        :type map:
        :return: Customized Databricks SQL statements
        :rtype: list
        """
        output_sqls = []
        for sql in sqls:
            if map['tranlate_distribution_style_in_sql']:
                sql = self.__tranlate_distribution_style_in_sql(sql)
            for v in map['sub'].values():
                sql = re.sub(v['from'], v['to'], sql)
            for v in map['replace'].values():
                sql = sql.replace(v['from'], v['to'])
            output_sqls.append(sql)
        return output_sqls

    def translate(self, input_filename: str, output_filename: str, read: str, write: str, config: dict) -> None:
        # Read input file
        f = open(config['input_path'] + input_filename, 'r')
        input_file_content = f.read()
        # Translate the SQL dialects syntax
        sqls = sqlglot.transpile(input_file_content, read=read, write=write, pretty=True)
        if write is 'databricks':
            sqls = self.__customize_databricks(sqls, config['databricks'])
        output_file_content = ';\n\n'.join(sqls)
        # Write output file
        f = open(os.path.join(config['output_path'], output_filename), 'w')
        # print(output_file_content)  # forDebug
        f.write(output_file_content)


if __name__ == "__main__":
    # Argument parsing
    parser = argparse.ArgumentParser(description='Translates a SQL dialect to another. Example: Redshift to Databricks')
    parser.add_argument('-i', '--input', type=str, default='Redshift_DDL_3_Tables.sql',
                        help='Input filename. Example: sample.sql')
    parser.add_argument('-o', '--output', type=str, help='Output filename. Example: out_sample.sql')
    parser.add_argument('-r', '--read', type=str, default='redshift',
                        help='The source dialect used to parse the input string'
                             ' (eg. "spark", "hive", "presto", "mysql")')
    parser.add_argument('-w', '--write', type=str, default='databricks',
                        help='The target dialect into which the input should be transformed'
                             ' (eg. "spark", "hive", "presto", "mysql").)')
    parser.add_argument('-c', '--config', type=str, default='config.yml',
                        help='Configuration Yaml filename. Examle: config.yml')
    args = parser.parse_args()
    if args.output:
        output_filename = 'out_' + args.output
    else:
        output_filename = 'out_' + args.input
    # Configuration file reading
    with open(args.config, 'r') as file:
        config = yaml.safe_load(file)
    # Translation
    t = Translator()
    t.translate(input_filename=args.input, output_filename=output_filename, read=args.read, write=args.write,
                config=config)
