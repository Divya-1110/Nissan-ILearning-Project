use LibraryDB 

create table EMPLOYEE(
 EmployeeID int primary key,
 EmpName nvarchar(20),
 Phone nvarchar(12),
 Email nvarchar(30)
 )

 create table MANUFACTURER(
 MfName nvarchar(20) primary key,
 City nvarchar(20),
 State nvarchar(20)
 )

 create table COMPUTER(
 SerialNumber int primary key,
 MfName nvarchar(20) 
     foreign key references MANUFACTURER(MfName)
     on delete cascade,
 Model nvarchar(20),
 Weight Numeric(7,2),
 EmployeeID int 
       foreign key references EMPLOYEE(EmployeeID)
       on delete cascade
	   )

insert into EMPLOYEE values (1,'Tom','987654321','tom123@gmail.com'),
                            (2,'ram','987651234','ramcom@gmail.com'),
                            (3,'sam','956784321','samuel@gmail.com'),
                            (4,'jam','987635421','jimmy@gmail.com')
insert into EMPLOYEE values (5,'Kim','978654321','kim90@gmail.com')

insert into MANUFACTURER values('Lenovo','charity','South Dakota'),
                            ('IBM','Seattle','Washington'),
                            ('Acer','Pierre','South Dakota'),
                            ('Apple','Buffalo','New York'),
							('Dell','Dallas','Texas')

insert into COMPUTER values(101,'Lenovo','Le345',20,1),
                           (102,'IBM','I45',22,2),
						   (103,'Acer','AC09',10,3),
						   (104,'Apple','AI13',18,4),
						   (105,'Dell','DE89',17,5)
--q1
select MfName ,State from MANUFACTURER where State='South Dakota'
--q2
select avg(Weight) as [Average Weight] from COMPUTER

--Q3
select EmpName from EMPLOYEE where phone like '9%'

--q4
select SerialNumber from COMPUTER where Weight <
(select avg(Weight) from COMPUTER)
--Q5
select MfName from MANUFACTURER  where MfName IN
(SELECT MfName FROM COMPUTER WHERE MfName IS NULL)
--Q6
select e.EmpName,c.SerialNumber, m.City from EMPLOYEE e
join COMPUTER c
on e.EmployeeID=c.EmployeeID
join MANUFACTURER m
on c.MfName=m.MfName
--q7
create procedure spDetails
as
begin
select c.EmployeeId,c.SerialNumber,c.MfName,c.Model,c.Weight from
COMPUTER c
end

EXEC spDetails
