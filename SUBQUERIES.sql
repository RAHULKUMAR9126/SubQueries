create database company_db;

use company_db;

create table employee
(
Emp_id int,
Name char(50),
Department_id varchar(50),
Salary int
);

insert into employee(Emp_id,Name,Department_id,Salary)
value
(101,'Abhishek','D01',62000),
(102,'Shubham','D01',58000),
(103,'Priya','D02',67000),
(104,'Rohit','D02',64000),
(105,'Neha','D03',72000),
(106,'Aman','D03',55000),
(107,'Ravi','D04',60000),
(108,'Sneha','D04',75000),
(109,'Kiran','D05',70000),
(110,'Tanuja','D05',65000);

select * from employee;

drop table if exists department;

create table department
(
Department_id varchar(50),
Department_name char(100),
Location char(100)
);

insert into department (Department_id,Department_name,Location)
values
('D01','Sales','Mumbai'),
('D02','Marketing','Delhi'),
('D03','Finance','Pune'),
('D04','HR','Bengaluru'),
('D05','IT','Hyderabad');

select * from department;

drop table if exists sales;
create table sales
(
Sale_ID int,
Emp_ID int,
Sale_Amount int,
Sale_Date date
);

insert into sales(Sale_ID,Emp_ID,Sale_Amount,Sale_Date)
values
(201,101,4500,'2025-01-05'),
(202,102,7800,'2025-01-10'),
(203,103,6700,'2025-01-14'),
(204,104,12000,'2025-01-20'),
(205,105,9800,'2025-02-02'),
(206,106,10500,'2025-02-05'),
(207,107,3200,'2025-02-09'),
(208,108,5100,'2025-02-15'),
(209,109,3900,'2025-02-20'),
(210,110,7200,'2025-03-01');

select * from sales;

-- Basic Level
-- Q1. Retrieve the names of employees who earn more than the average salary of all employees.

select name from employee
where salary > (select avg(Salary) 
from employee);

-- Q2. Find the employees who belong to the department with the highest average salary.

select * from employee
where Department_ID= ( select Department_ID 
from employee
group by Department_ID
Order By AVG(salary) DESC
limit 1);

-- Q3. List all employees who have made at least one sale.

select name
from employee e
where exists 
(
select 1 from sales s
where s.emp_id=emp_id
);

-- Q4. Find the employee with the highest sale amount

SELECT e.Name, s.Sale_Amount
FROM employee e
JOIN sales s ON e.Emp_id = s.Emp_ID
WHERE s.Sale_Amount = (
SELECT MAX(Sale_Amount)
FROM sales
);

-- Q5. Retrieve the names of employees whose salaries are higher than Shubham’s salary.

select name
from employee
where salary > (select salary from employee where name= 'Shubham');

-- Intermediate Level

-- Q1. Find employees who work in the same department as Abhishek.

select name from employee
where Department_id=(select Department_id 
from employee 
where name= 'Abhishek');

-- Q2. List departments that have at least one employee earning more than ₹60,000.

select distinct Department_id
from employee
where salary > 60000;

-- Q3. Find the department name of the employee who made the highest sale.

select d.department_name
from employee e
Join department d
ON e.Department_id=d.Department_id
Join sales s
On e.Emp_id=s.Emp_id
where s.Sale_Amount=(select max(Sale_Amount)
from sales);
	
-- Q4. Retrieve employees who have made sales greater than the average sale amount.

select avg(sale_amount) from sales;
select distinct e.Emp_id,e.name,s.Sale_Amount
from employee e
Join sales s
on e.emp_id=s.Emp_id
where s.sale_Amount > (select AVG(Sale_Amount) 
from sales);

-- Q5. Find the total sales made by employees who earn more than the average salary.

select sum(s.sale_amount) as Total_Sales
from employee e
Join sales s
on E.Emp_id= s.Emp_id
where e.Salary > (select AVG(salary) 
from employee
);

-- Advanced Level
-- Q1. Find employees who have not made any sales.

select e.Emp_id,e.Name
from employee e
left join sales s
on e.Emp_id=s.Emp_ID
where s.Emp_id is NULL;

-- Q2 List departments where the average salary is above ₹55,000.

select d.Department_Name,avg(e.salary) as AVGERAGE_SALARY
from employee e
Join Department d
On e.Department_id=d.Department_id
group by d.Department_name
having avg(e.salary) > 55000;

-- Q3. Retrieve department names where the total sales exceed ₹10,000.

select d.Department_name,sum(s.sale_amount) AS TOTAL_SALES
from employee e
join sales s
ON e.Emp_id=s.Emp_id
Join Department d
on e.Department_id=d.Department_id
group by d.Department_Name
having sum(s.sale_amount) > 10000;

-- Q4. Find the employee who has made the second-highest sale.

select e.Emp_id,e.Name,s.sale_amount
from employee e
join sales s
on e.Emp_id=s.Emp_id
order by s.sale_amount desc
limit 1 offset 1;

-- Q5. Retrieve the names of employees whose salary is greater than the highest sale amount recorded.

select Name,Salary
from employee
where salary > (select max(sale_amount)
from sales
);




