create database org1;
use org1;

create table worker(
	worker_id int not null primary key,
    first_name char(20),
    last_name char(20),
    salary int,
    joining_date datetime,
    department char(20)
    );

insert into worker(worker_id,first_name,last_name,salary,joining_date,department)
values (001,"Hitesh","Kupare",80000,'14-2-20 09.00.00',"HR"),
	   (002,"Sanket","Sut",60000,'12-3-20 09.00.00',"Admin"),
       (003,"Hemraj","Jeetarwal",100000,'24-6-20 09.00.00',"HR"),
       (004,"Vijay","kupare",95000,'1-1-21 09.00.00',"Admin"),
       (005,"Sankalp","Surve",83000,'4-12-19 09.00.00',"Admin"),
       (006,"Jason","Banrandof",120000,'12-6-21 09.00.00',"Account"),
       (007,"Rakesh","Jatpat",45000,'23-4-20 09.00.00',"Account"),
       (008,"Suresh","kumble",60000,'11-8-20 09.00.00',"Admin");

create table bonus(
		worker_ref_id int,
        bonus_amount int,
        bonus_date datetime,
        foreign key (worker_ref_id)
			references worker(worker_id)
            on delete cascade
		);
        
insert into bonus(worker_ref_id,bonus_amount,bonus_date)
values 	(1,5000,'16-02-20'),
		(2,2000,'12-01-21'),
        (3,3000,'23-02-19'),
        (1,6000,'26-06-20'),
        (2,5000,'03-02-21');

create table title(
	worker_ref_id int,
    worker_title varchar(250),
    affected_from datetime,
    foreign key (worker_ref_id)
		references worker(worker_id)
        on delete cascade
        );
        
insert into title(worker_ref_id,worker_title,affected_from)
values  (001,"Manager",'2020-02-20 00:00:00'),
		(002,"Executive",'2016-04-21 00:00:00'),
        (008,"Executive",'2020-04-03 00:00:00'),
        (005,"Manager",'2015-11-20 00:00:00'),
        (004,"Asst.Manager",'2020-02-21 00:00:00'),
        (007,"Manager",'2019-12-20 00:00:00'),
        (006,"Lead",'2019-12-20 00:00:00'),
		(003,"Lead",'2019-12-20 00:00:00');
        
        
-- 1. INSTR() function  -- returns the position of the first occorance of the letter 
select instr(first_name, "a") from worker where first_name = 'hemraj';

-- 2. SUBSTRING() Function  -- return the 1st 3 letters of the name 
select substring(first_name,1,3) from worker;

-- 3. UPPER() Function   -- return the upper case of the givven string
select upper(first_name) from worker; 

-- 4. Distinct() Function   -- returns the non repeated values in a column
select distinct(department) from worker;

-- 5. Alias   -- temporary name for the column of a table
select first_name as NAME from worker  ;

-- 6. RTRIM() Function   -- remove the blankspaces from the right side
select rtrim(first_name) from worker; 

-- 7. LTRIM() Function   -- remove the blankspaces from the left side
select ltrim(first_name) from worker; 

-- 8. LENGTH() Function   -- returns the length of the string  
select distinct(department),length(department) from worker;

-- 9. REPLACE() Function   -- replaces the given charcater or string with the given string 
select replace(first_name, 'a' , 'A') from worker;

-- 10. CONCAT() Function   -- It joins the coluns in one column
select concat(first_name,' ',last_name) as Complete_Name from worker;

-- 11. ORDER BY    -- use to arrange the colun in assending or descending 
select * from worker order by first_name , department desc;

-- 12. IN     --it will checck the given value in the completet table
select * from worker where first_name in ('hemraj', 'rakesh');

-- 13. NOT IN    -- it will print all other names excluding given values
select * from worker where first_name not in  ('hemraj','rakesh');

-- 14. LIKE      -- it means take only this types of values in the table 
select * from worker where department like "admin";

-- 15.  % WILDCARD / PATTERN SEARCH          -- use to print the value which contain someting befor or after of the given value or it can be use to check the given value is there in the column 
select * from worker where first_name like '%h%';

select * from worker where first_name like "%h" and length(first_name) = 6;

-- 16. BETWEEN    --use to show the value between the given values including the value it self
select * from worker where salary between 60000 and  100000; 

-- 17. YEAR , MONTH    -- use to search the year in datetime datatype 
select * from worker where year(joining_date) = '2012'and month(joining_date) = '06';

 -- 18. COUNT() Function    -- use to count the given values
 select count(department) from worker where department = 'admin';
 
 -- 19. GROUP BY           -- groups rows that have the same values into summary rows
select department,count(worker_id) from worker 
group by department
order by count(worker_id) desc;

-- 20. HAVING      --it is similar to where clause but it is used using group by
select worker_title,count(worker_ref_id) as count from title 
group by worker_title
having count > 1;

-- 21. INNER JOIN     --
select * from worker as w
inner join title as t
on w.worker_id = t.worker_ref_id
where worker_title = 'manager'; 

-- 22. MOD       -- to calculate the modules 
select * from worker where mod(worker_id, 2) <> 0;

-- 23. CLONE A TABLE      -- we can clone a table and its content 
	-- create 
create table worker_clone like worker; 
	-- clone data
insert into worker_clone select * from worker; 

-- 24. MINUS OPERATOR     -- there is no operator such this but we can emunerate this using left join
select w.* from worker as w
left join bonus as b
on w.worker_id = b.worker_ref_id
where b.worker_ref_id  is null;

-- 25. CURDATE() / CURTIME() and NOW()  Functions    -- this are use to print the current date and time
select now(), curtime() , curdate();

-- 26. LIMIT     -- use to limit the data we want to see 
select * from worker
order by salary desc limit 5;

-- 27. CO-RELATED SUBQUERIES             --Querie in querie which are dependent on each other
select * from worker w1 
where 4 = (
	select count(distinct(w2.salary)) 
    from worker w2 
    where w2.salary > w1.salary
    );
    
-- 28. JOIN WITHOUT USING JOINS                 -- can perform inner join without using join function
select w1.* from worker w1 , worker w2 
where w1.salary = w2.salary and w1.first_name <> w2.first_name;

-- 29. SUB-QUERIES                -- queries within queries
select max(salary) from worker 
where salary <  (
	select max(salary) from worker
    where salary not in (select max(salary) from worker)
    );

-- 30. UNION        --
select * from worker 
union all
select * from worker order by worker_id;

-- 31. SUB-QUERIES
select * from worker w 
where worker_id not in (select worker_ref_id from bonus );

-- 32. PRINT 50% DATA OF TABLE
select * from worker where worker_id <= (select count(worker_id)/2 from worker); 

-- 33. MAX () Function                  -- Find the maxinim 
select * from worker where worker_id = (select max(worker_id) from worker) ;  

-- 34. MIN () Function                 -- Find the minimum 
select * from worker where worker_id = (select min(worker_id) from worker) ;  

-- 35. LAST 5 DATA
(select * from worker order by worker_id desc limit 5 ) order by worker_id ;

-- 36. 
(select max(salary),department from worker group by department)  ;

-- 37. MAX SALARY BY NAME
Select first_name, department, salary from worker where (department, salary) in
(Select department, max(salary) from worker group by department );

-- 38. CORELATED SUB-QUERIES       --Max salary
select distinct(salary) from worker w1 where 3 >= (select count(distinct(salary)) from worker w2 where w1.salary <= w2.salary) order by w1.salary desc;

-- 39.  CORELATED SUB-QUERIES       --MIN salary
select distinct(salary) from worker w1 where 3 >= (select count(distinct(salary)) from worker w2 where w1.salary >= w2.salary) order by w1.salary desc;

-- 40. SUM () Function
select department,sum(salary) sum from worker group by department order by sum desc;

-- 41.  MAX SALARY WITH NAME
select first_name,salary from worker where salary = (select max(salary) from worker);

-- 42, REMOVE REVERSE PAIR 
	-- First create a table with reverse pairs
    create table pairs(
    a int,
    b int
    );
    
    -- Insert in the table the pairs
    insert into pairs values (2,1),(1,2),(3,4),(3,2),(1,5),(4,2),(4,3),(2,3),(5,1),(2,4),(6,3) ;
    
    -- METHOD 1   (Using JOINS)
    select p1.* from pairs p1 left join pairs p2
    on p1.a = p2.b and p1.b = p2.a
    where p1.a > p2.a ;
    
    -- METHOD 2  (Using CORELATED SUB-QURIES)
    select * from pairs p1 where not exists (select * from pairs p2 where p1.a = p2.b and p2.b = p2.a and p1.a > p2.a);  
 

