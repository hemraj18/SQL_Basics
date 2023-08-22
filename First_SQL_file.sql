-- 	 create database 
create database Office;
--   Set database as default
USE Office;

-- create table employee    
create table employee(
	id int not null primary key,
    fname varchar(255),
    lname varchar(255),
    age int,
    emailID varchar(255),
    phoneNo int,
    city varchar(255)
    );

-- create table client 
create table client(
	id int not null primary key,
    first_name varchar(255),
    last_name varchar(255),
    age int,
    emailID varchar(255),
    phoneNo int,
    city varchar(255),
    empID int
    );   
    
-- create table PROJECT 
CREATE TABLE project(
	id int not null primary key,
    empID int,
    foreign key (empID) references employee(id)
    on update cascade
    on delete cascade,
    name varchar(255),
    startdate datetime,
    clientID int ,
    foreign key (clientID) references client(id)  
    on update cascade
    on delete cascade
    );
    
 -- Set the empID as foreign key for project table
alter table client add constraint empID foreign key (empID) references project(empID) 
    on update cascade
    on delete cascade;  
    
 -- Change the data type for startdate in project table
 alter table project modify startdate date ;
    
-- Insert data in project table
insert into project(id,empID,name,clientID)
value (1,1,"A",3),
	  (2,2,"B",1),
      (3,3,"C",5),
      (4,3,"D",2),
      (5,5,"E",4);
      
-- Insert data in employee table
insert into employee(id,fname,lname,age,emailID,phoneNo,city)
value (1,"Aman","Proton",32,"aman@gamil.com",898,"Delhi"),
	  (2,"Yagya","Narayan",44,"yagya@gamil.com",22,"Palam"),
      (3,"Rahul","BD",22,"rahul@gamil.com",444,"Kolkata"),
      (4,"Jatin","Hermit",31,"jatin@gamil.com",666,"Raipur"),
      (5,"PK","Pandey",21,"pk@gamil.com",555,"Jaipur");  
      
 -- Insert data in client table
insert into client(id,first_name,last_name,age,emailID,phoneNo,city)
value (1,"Mac","Rogers",47,"mac@gamil.com",333,"Kolkata"),
	  (2,"Max","Poirier",27,"max@gamil.com",222,"Kolkata"),
      (3,"Peter","Jain",24,"peter@gamil.com",111,"Delhi"),
      (4,"Sushant","Aggarwal",23,"sushant@gamil.com",45456,"Hyderabad"),
      (5,"Pratap","Singh",36,"pratap@gamil.com",12312,"Mumbai");  

-- Inserted the values of empID in the client table 
update client set empID = 
case id
when 1 then 3
when 2 then 3
when 3 then 1
when 4 then 5
when 5 then 2
end;

select * from project;
select * from employee;
select * from client;

-- Inner JOIN

-- Q1. Enlist employee id , name and project name
select e.id,e.fname,e.lname,p.id,p.name
from employee as e
inner join project as p
on e.id = p.empID   ; 

-- Q2 . Fetch all emp id and there contact details who have been workking 
-- from jaipur with hyderabad client
select e.id, e.emailID, e.phoneNO, c.first_name, c.last_name
from employee as e
inner join client as c
on e.id = c.empID
where e.city = "jaipur" and c.city = "hyderabad";  

-- LEFT JOIN
-- Q1. Fetch out each projecct allocated to each employee
select *
from employee as e
left join project as p
on e.id = p.empID;      

-- Right JOIN
-- Q1.  List out all the projects with employe name  ans there respected emailid
select p.id,p.name,e.fname,e.lname,e.emailID
from employee as e
right join project as p
on e.id = p.empID;    
               
-- CROSS JOIN
-- Q1.  List all the project name and employeee name possible
select p.id,e.fname,e.lname,p.name 
from employee as e
cross join project as p
             