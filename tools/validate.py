from validators.documentation import validate as validate_documentation
import sys
from validators.schema import validate as validate_schema

def main():
    ok = True

    ok &= validate_documentation()
    ok &= validate_schema()

    if not ok:
        print("\nValidation failed.")
        sys.exit(1)

    print("\nValidation passed.")


if __name__ == "__main__":
    main()