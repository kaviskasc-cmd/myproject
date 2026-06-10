create schema PD;
use pd;
create table emp(
emp_id int,
emp_name varchar(30),
department varchar(30),
salary int
);
insert into emp values
(101,"john","HR",50000),
(102,"mary","IT",70000),
(103,"tom","IT",60000),
(104,"Alice","Sales",65000),
(105,"David","HR",55000);
select * from emp;
select * from emp where salary > 50000;
SELECT department, count(*) AS no_of_emp FROM emp GROUP BY department;
SELECT max(salary) AS highest_salary FROM emp;
SELECT department,avg(salary) AS Avg_salary FROM emp GROUP BY department;
SELECT max(salary) AS Second_highest_salary FROM emp WHERE salary > (SELECT max(salary) FROM emp);
SELECT * FROM emp WHERE salary > (SELECT avg(salary) FROM emp);
SELECT department,avg(salary) as highest_avg_salary FROM emp GROUP BY department ORDER BY highest_avg_salary desc LIMIT 1;
SELECT *, rank() OVER(ORDER BY salary desc) AS rnk FROM emp;
SELECT *, row_number() Over(partition by department ORDER BY salary) FROM emp;
WITH dep_salary AS (SELECT *, row_number() OVER(partition by department ORDER BY salary desc) AS rn FROM emp
)
SELECT * FROM dep_salary where rn=1;
SELECT *,
	ROW_NUMBER() OVER(partition by department
    ORDER BY salary DESC) AS rn
FROM emp;
SELECT emp_name,salary, SUM(salary) OVER(ORDER BY salary desc) as Running_total
FROM emp;
SELECT emp_name, salary, LAG(salary) OVER (ORDER BY salary) AS previous_salary
FROM emp;
SELECT emp_name, salary, LEAD(salary) OVER (ORDER BY salary) AS previous_salary
FROM emp;
-- 
create table sales(
Order_id int not null,
product varchar(20),
amount int);
insert into sales values 
(1,"Laptop",50000),
(2,"Mobile",25000),
(3,"Laptop",45000),
(4,"Tablet",15000),
(5,"Mobile",30000);
SELECT SUM(amount) as Total_revenue FROM sales;
SELECT product, sum(amount) AS Highest_contributing_product FROM sales GROUP BY product ORDER BY max(amount) desc LIMIT 1;
SELECT product,sum(amount) AS total_revenue,
ROUND( 
sum(amount) * 100 / (SELECT (sum(amount)) FROM sales),2 )AS cont_PCT
FROM sales GROUP BY product;
SELECT product, SUM(amount) as High_revenue FROM sales GROUP BY Product ORDER BY sum(amount) desc LIMIT 2;
SELECT product, sum(amount) AS total_revenue FROM sales GROUP BY product
HAVING sum(amount)>
(SELECT avg(product_revenue) FROM 
(SELECT sum(amount) AS product_revenue 
FROM sales
GROUP BY product
)x
);
