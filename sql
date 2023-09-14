CREATE TABLE employees (
    id serial PRIMARY KEY,
    name varchar,
    last_name varchar,
    hire_date date,
    salary int,
    email varchar,
    manager_id int,
    department_id int
);
CREATE TABLE Regions (
    id serial PRIMARY KEY,
    name varchar
);
CREATE TABLE Locations (
    id serial PRIMARY KEY,
    address varchar,
    region_id int,
    FOREIGN KEY (region_id) REFERENCES Regions(id)
);
CRCREATE TABLE Departments (
    id serial PRIMARY KEY,
    name varchar,
    location_id int REFERENCES Locations(id),
    manager_id int REFERENCES Employees(id)
);

ALTER TABLE Employees
ADD CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES Employees(id);
ALTER TABLE Employees
ADD CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES Departments(id);


INSERT INTO Regions (name)
VALUES
    ('North America'),
    ('Europe'),
    ('Asia'),
    ('South America');

INSERT INTO Locations (address, region_id)
VALUES
    ('123 Main St, New York', 1),
    ('456 Park Ave, London', 2),
    ('789 Sakura St, Tokyo', 3),
    ('987 Copacabana Ave, Sao Paulo', 4);

INSERT INTO Departments (name, location_id, manager_id)
VALUES ('HR', 1, NULL),
       ('Sales', 2, NULL),
       ('IT', 3, NULL);

INSERT INTO Employees (name, last_name, hire_date, salary, email, manager_id, department_id) VALUES
    ('John', 'Doe', '2022-01-15', 50000, 'john.doe@dualbootpartners.com', NULL, 1),
    ('Jane', 'Smith', '2022-02-20', 55000, 'jane.smith@example.com', NULL, 2),
    ('Michael', 'Johnson', '2022-03-10', 60000, 'michael.johnson@example.com', NULL, 3);


INSERT INTO Employees (name, last_name, hire_date, salary, email, manager_id, department_id) VALUES
    ('John', 'Doe', '2022-01-15', 50000, 'john.doe@dualbootpartners.com', 1, 1),
    ('Jane', 'Smith', '2022-02-20', 55000, 'jane.smith@example.com', 1, 2),
    ('Michael', 'Johnson', '2022-03-10', 60000, 'michael.johnson@example.com', 1, 3),
    ('Emily', 'Williams', '2023-08-01', 52000, 'emily.williams@example.com', 2, 3),
    ('David', 'Brown', '2022-05-08', 58000, 'david.brown@ dualbootpartners.com', 2, 3),
    ('Sarah', 'Jones', '2023-06-12', 53000, 'sarah.jones@example.com', 3, 1),
    ('Kevin', 'Miller', '2023-07-20', 57000, 'kevin.miller@example.com', 3, 1),
    ('Anna', 'Davis', '2023-08-25', 54000, 'anna.davis@example.com', 2, 2),
    ('Robert', 'Wilson', '2022-09-30', 59000, 'robert.wilson@ dualbootpartners.com', 3, 2),
    ('Olivia', 'Martinez', '2022-10-05', 51000, 'olivia.martinez@example.com', 1, 3);

# Показать работников у которых нет почты или почта не в корпоративном домене (домен dualbootpartners.com)

SELECT name, last_name FROM Employees
WHERE email IS NULL OR email NOT LIKE '%@dualbootpartners.com';

# Получить список работников нанятых в последние 30 дней

SELECT * FROM employees
WHERE hire_date >= CURRENT_DATE - INTERVAL '30 days';

# Найти максимальную и минимальную зарплату по каждому департаменту

SELECT department_id,
       MIN(salary) AS min,
       MAX(salary) AS max
FROM employees
GROUP BY department_id;


# Посчитать количество работников в каждом регионе

SELECT regions.name, COUNT(employees.id) AS count
FROM employees
LEFT JOIN departments ON employees.department_id = departments.id
LEFT JOIN locations ON departments.location_id = locations.id
LEFT JOIN regions ON locations.region_id = regions.id
GROUP BY regions.name;

# Показать сотрудников у которых фамилия длиннее 10 символов

SELECT name, last_name FROM employees
WHERE LENGTH(last_name) > 10;

# Показать сотрудников с зарплатой выше средней по всей компании

SELECT name, last_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
