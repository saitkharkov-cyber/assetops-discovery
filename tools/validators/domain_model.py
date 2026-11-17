"""Check declared domain tables and their company/observation relationships."""
import sqlite3
from pathlib import Path
from parsers.domain_model import get_entities

ROOT = Path(__file__).resolve().parents[2]
SCHEMA = ROOT / "data" / "schema.sql"
EXPECTED_FKS = {
    "observations": {("company_id", "companies"), ("observation_type_id", "observation_types")},
    "evidence": {("observation_id", "observations")},
    "contacts": {("company_id", "companies")},
    "interviews": {("company_id", "companies"), ("contact_id", "contacts")},
    "tasks": {("company_id", "companies")},
    "company_tags": {("company_id", "companies")},
}

def validate():
    errors, warnings = [], []
    entities = get_entities()
    if not entities:
        errors.append("No entity/table mappings found in DOMAIN_MODEL.md")
    names = [name for name, _ in entities]
    declared = [table for _, table in entities]
    if len(names) != len(set(names)) or len(declared) != len(set(declared)):
        errors.append("Duplicate entity or table mapping")

    con = sqlite3.connect(":memory:")
    try:
        con.executescript(SCHEMA.read_text(encoding="utf-8"))
        actual = {row[0] for row in con.execute(
            "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"
        )}
        for table in sorted(set(declared) - actual):
            errors.append(f"Missing table: {table}")
        for table in sorted(actual - set(declared)):
            errors.append(f"Undocumented table: {table}")
        for table, required in EXPECTED_FKS.items():
            if table not in actual:
                continue
            found = {(r[3], r[2]) for r in con.execute(f'PRAGMA foreign_key_list("{table}")')}
            for column, target in sorted(required - found):
                errors.append(f"Missing foreign key: {table}.{column} -> {target}")

        if "contacts" in actual:
            sql = con.execute("SELECT sql FROM sqlite_master WHERE name='contacts'").fetchone()[0]
            if "CHECK" not in sql.upper():
                warnings.append("contacts: no CHECK ensuring at least one contact method")
        for table in ("observations", "contacts", "interviews", "tasks", "company_tags"):
            if table not in actual:
                continue
            for row in con.execute(f'PRAGMA foreign_key_list("{table}")'):
                if row[2] == "companies" and row[6] == "NO ACTION":
                    warnings.append(f"{table}: company deletion policy is implicit (NO ACTION)")
    except (OSError, sqlite3.Error) as exc:
        errors.append(f"Unable to inspect schema: {exc}")
    finally:
        con.close()

    for item in errors:
        print(f"ERROR: {item}")
    for item in warnings:
        print(f"WARNING: {item}")
    if not errors:
        print(f"PASS: {len(entities)} domain mappings and required foreign keys checked")
    return not errors
