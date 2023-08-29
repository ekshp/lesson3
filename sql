# Показать работников у которых нет почты или почта не в корпоративном домене (домен dualbootpartners.com)

SELECT name, last_name FROM Employees
WHERE email IS NULL OR email NOT LIKE '%dualbootpartners.com';

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

SELECT department_id, COUNT(employees.id) AS count
FROM employees
LEFT JOIN departments ON employees.department_id = departments.id
GROUP BY employees.department_id;

# Показать сотрудников у которых фамилия длиннее 10 символов

SELECT name, last_name FROM employees
WHERE LENGTH(last_name) > 10;

# Показать сотрудников с зарплатой выше средней по всей компании

SELECT name, last_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);