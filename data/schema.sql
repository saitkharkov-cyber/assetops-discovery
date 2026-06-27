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
CREATE TABLE evidence (
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    observation_id INTEGER NOT NULL,

    type TEXT NOT NULL,
    source TEXT NOT NULL,

    description TEXT,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(observation_id) REFERENCES observations(id)
);
CREATE TABLE contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    company_id INTEGER NOT NULL,

    full_name TEXT,
    position TEXT,

    email TEXT,
    phone TEXT,
    linkedin TEXT,

    is_decision_maker INTEGER DEFAULT 0,

    notes TEXT,

    FOREIGN KEY(company_id) REFERENCES companies(id)
);
CREATE TABLE interviews (
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    company_id INTEGER NOT NULL,
    contact_id INTEGER,

    interview_date DATETIME,

    status TEXT NOT NULL,

    summary TEXT,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(company_id) REFERENCES companies(id),
    FOREIGN KEY(contact_id) REFERENCES contacts(id)
);
CREATE TABLE company_tags (
    company_id INTEGER NOT NULL,
    tag TEXT NOT NULL,

    PRIMARY KEY (company_id, tag),

    FOREIGN KEY(company_id) REFERENCES companies(id)
);
CREATE TABLE tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    company_id INTEGER NOT NULL,

    title TEXT NOT NULL,
    status TEXT NOT NULL,

    due_date DATETIME,

    notes TEXT,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(company_id) REFERENCES companies(id)
);
