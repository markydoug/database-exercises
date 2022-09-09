/**********Join Example Database************/

-- Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;

SELECT *
FROM users;

SELECT *
FROM roles;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name,
	COUNT(users.name)
FROM roles
LEFT JOIN users ON roles.id = users.role_id
GROUP BY roles.name;



