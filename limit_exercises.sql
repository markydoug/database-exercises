USE employees;

-- 2. List the first 10 distinct last name sorted in descending order.
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;
/* 'Zykh'
'Zyda'
'Zwicker'
'Zweizig'
'Zumaque'
'Zultner'
'Zucker'
'Zuberek'
'Zschoche'
'Zongker'*/

-- 3. Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records.
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%-12-25"
ORDER BY hire_date
LIMIT 5;
-- Write a comment in your code that lists the five names of the employees returned.
/* Alselm,Cappello
Utz,Mandell
Bouchung,Schreiter
Baocai,Kushner
Petter,Stroustrup*/ 

-- 4. Update the query to find the tenth page of results.
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%-12-25"
ORDER BY hire_date
LIMIT 5
OFFSET 45;
/*'463558','1963-12-25','Pranay','Narwekar','F','1990-07-18'
'444269','1963-12-25','Marjo','Farrow','F','1990-07-18'
'291662','1962-12-25','Ennio','Karcich','M','1990-08-05'
'413687','1954-12-25','Dines','Lubachevsky','F','1990-08-06'
'416525','1952-12-25','Ipke','Fontan','M','1990-08-06'*/

-- What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
-- OFFSET = (LIMIT * page number) - LIMIT