# Сущности

- Company
- Observation
- ObservationType
- Evidence
- Contact
- Interview
- Task
- CompanyTag

---

# Связи между сущностями

Company
├── Observation (1:N)
├── Contact (1:N)
├── Interview (1:N)
├── Task (1:N)
└── CompanyTag (1:N)

Observation
├── ObservationType (N:1)
└── Evidence (1:N)

Contact
└── Interview (1:N)