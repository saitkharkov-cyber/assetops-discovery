CREATE TABLE observation_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    code TEXT NOT NULL UNIQUE,
    name_ru TEXT NOT NULL,

    category TEXT NOT NULL,
    priority TEXT NOT NULL,

    weight INTEGER NOT NULL DEFAULT 0,

    evidence_type TEXT NOT NULL,

    description TEXT,

    is_active INTEGER NOT NULL DEFAULT 1
);

INSERT INTO observation_types
(code, name_ru, category, priority, weight, evidence_type, description)
VALUES
(
    'expensive_assets',
    'Дорогостоящее оборудование',
    'equipment',
    'critical',
    20,
    'direct',
    'Компания использует дорогостоящее оборудование.'
),
(
    'electrical_lab',
    'Электротехническая лаборатория',
    'equipment',
    'critical',
    20,
    'direct',
    'Компания имеет собственную электролабораторию.'
),
(
    'own_employees',
    'Собственный штат',
    'staff',
    'critical',
    20,
    'direct',
    'Работы выполняются штатными сотрудниками.'
),
(
    'mobile_crews',
    'Мобильные бригады',
    'logistics',
    'high',
    15,
    'indirect',
    'Одновременно работают несколько выездных бригад.'
),
(
    'foremen',
    'Прорабы',
    'staff',
    'high',
    10,
    'direct',
    'В компании есть прорабы или руководители объектов.'
);

CREATE TABLE companies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    company_name TEXT,
    domain TEXT NOT NULL UNIQUE,
    website TEXT,

    status TEXT NOT NULL DEFAULT 'new',

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME
);

CREATE TABLE observations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    company_id INTEGER NOT NULL,
    observation_type_id INTEGER NOT NULL,

    value TEXT,
    source_url TEXT,
    notes TEXT,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(company_id) REFERENCES companies(id),
    FOREIGN KEY(observation_type_id) REFERENCES observation_types(id)
);