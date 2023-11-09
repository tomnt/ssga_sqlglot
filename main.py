import os.path
import sqlglot
import sys

INPUT_PATH = 'sql/input/'
OUTPUT_PATH = 'sql/output/'


def translate(input_filename: str) -> None:
    f = open(INPUT_PATH + input_filename, 'r')
    s = f.read()
    out_list = sqlglot.transpile(s, read="redshift", write="databricks", pretty=True)  # SELECT COLLECT_LIST(a) FROM table
    out_str = ';\n\n'.join(out_list)
    if len(out_list) > 0 and len(out_str):
        out_str += ';'
    print(out_str)  # forDebug
    f = open(os.path.join(OUTPUT_PATH, 'out_' + input_filename), 'w')
    f.write(out_str)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        input_filename = sys.argv[1]
    else:
        input_filename = 'Redshift_DDL_3_Tables.sql'
    translate(input_filename)
