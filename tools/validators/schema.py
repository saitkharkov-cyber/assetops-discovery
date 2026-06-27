from parsers.schema import get_tables

def validate():
    tables = get_tables()

    print("Schema tables:")

    for table in sorted(tables):
        print(f"  - {table}")

    return True