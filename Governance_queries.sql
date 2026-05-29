create database governance_project;
use governance_project;
select * from customer_data;
select * from employee_data;
select * from product_data;
select * from sales_data;
SHOW TABLES;

#1) Duplicate Records from customer data
select * from customer_data
where email in(
	select 	email
	from customer_data
	group by email
	having count(*) > 1)
or phone in(
	select phone
	from customer_data
    group by phone
    having count(*) > 1) ;

#2) Missing values from cutomer data
select * from customer_data
where Name is null
or Email is null
or Phone is null;

#3) Missing Product Owners
select * from product_data
where owner_assigned is null;

#4) Invalid Employee Emails
select * from employee_data
where email not regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';

#5) Missing Manager
select * from employee_data
where manager_assigned is null;

#6) overnance by Department
select department, count(*) as Total_Employees
from employee_data
group by department
order by Total_Employees;

#7) Unknown Product IDs
select * from sales_data
where issue_flag = "Unknown Product ID";

#8) Duplicate Transactions
select * from sales_data
where validation_status = "Duplicate";
