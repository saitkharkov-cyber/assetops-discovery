from validators.documentation import validate as validate_documentation
from validators.schema import validate as validate_schema
from validators.domain_model import validate as validate_domain_model
import sys

def main():
    results = [
        validate_documentation(),
        validate_schema(),
        validate_domain_model(),
    ]
    if not all(results):
        print("\nValidation failed.")
        sys.exit(1)
    print("\nValidation passed.")

if __name__ == "__main__":
    main()
