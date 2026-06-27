# VALIDATION

## Цель

Автоматическая проверка целостности проекта.

---

## Принципы

- Validation First
- Fail Fast
- Один валидатор — одна ответственность
- Валидаторы не изменяют проект
- Валидаторы только читают данные

---

## Архитектура

validate.py
    ↓
Repository Validator
Documentation Validator
Glossary Validator
Domain Validator
Data Model Validator
Schema Validator
Reference Data Validator
Links Validator

---

## Статусы

PASS

WARNING

ERROR

SKIPPED

---

## Правила

- Каждый валидатор независим.
- Валидатор возвращает результат, но не завершает программу.
- validate.py агрегирует результаты.
- Все ошибки выводятся в конце выполнения.

---

## Roadmap

Repository Validator        ✅
Documentation Validator     ✅
Glossary Validator          ⏳
Domain Validator            ⏳
Data Model Validator        ⏳
Schema Validator            ⏳
Reference Data Validator    ⏳
Links Validator             ⏳
Architecture Validator      ⏳
Research Validator          ⏳

## Архитектура Validation

```text
validate.py
      │
      ▼
Validators
      │
      ▼
Parsers
      │
      ▼
Readers
      │
      ▼
Repository Files
```

### Ответственность слоев

* **Readers** — читают файлы и не интерпретируют их содержимое.
* **Parsers** — преобразуют содержимое файлов в структурированные объекты.
* **Validators** — сравнивают структурированные объекты и формируют результаты проверки.
* **validate.py** — управляет выполнением валидаторов и формирует итоговый отчет.
