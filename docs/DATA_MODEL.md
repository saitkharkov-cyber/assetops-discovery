# Сущности
- Company
- Contact
- Observation
- ObservationType
- Interview
- Evidence

# Связи между сущностями

Company
├── Observation (1:N)
├── Contact (1:N)
├── Interview (1:N)
└── Evidence (1:N)

Observation
└── ObservationType (N:1)