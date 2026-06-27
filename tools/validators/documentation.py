from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]

REQUIRED_FILES = [
    "README.md",
    "PROJECT_MASTER_SUMMARY.md",
    "docs/WORKFLOW.md",
    "docs/00_DOCUMENT_STRUCTURE.md",
    "docs/DOMAIN_MODEL.md",
    "docs/DATA_MODEL.md",
    "docs/ARCHITECTURE.md",
    "docs/COMPANY_LIFECYCLE.md",
    "docs/ICP.md",
    "docs/HYPOTHESES.md",
    "docs/DECISIONS.md",
    "docs/RESEARCH_LOG.md",
    "docs/QUESTIONS.md",
    "docs/GLOSSARY.md",
    "data/schema.sql",
]

def validate():
    missing = [f for f in REQUIRED_FILES if not (ROOT / f).exists()] 

    if missing:
        print("Missing files:")
        for f in missing:
            print(f"  - {f}")
        return False

    print("OK: all required files exist.")
    return True