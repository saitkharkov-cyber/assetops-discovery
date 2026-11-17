"""Read explicit entity-to-table mappings from DOMAIN_MODEL.md."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
MODEL = ROOT / "docs" / "DOMAIN_MODEL.md"
HEADING = re.compile(r"^##\s+(?:Aggregate|Entity|Reference Data):\s+([A-Za-z][A-Za-z0-9]*)\s+\(table\s+([a-z][a-z0-9_]*)\)\s*$", re.M)

def get_entities():
    text = MODEL.read_text(encoding="utf-8")
    return HEADING.findall(text)
