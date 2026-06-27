from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCHEMA = ROOT / "data" / "schema.sql"
'''
print(SCHEMA)
print(SCHEMA.exists())
print(SCHEMA.stat().st_size)
'''
def get_tables():
    with open(SCHEMA, "r", encoding="utf-8") as f:
        text = f.read()
        
    lines = text.splitlines()
    
    tables = set()
    
    for line in lines:
        if line.strip().startswith("CREATE TABLE"):
            table = line.split()[2]
            tables.add(table)

    return tables