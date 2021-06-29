create database AirlineDB;
show databases;
use AirlineDB;
show tables;

create table FLIGHTS(Flight_Number int, From_P varchar(20), To_P varchar(20), Distance int, Departs time, Arrives time, Price int,
 Primary key(Flight_Number));
 create table AIRCRAFTS(Aircraft_ID int, Aircraft_Name varchar(20), Cruising_Range int, 
 Primary key(Aircraft_ID));
 create table EMPLOYEE(Employee_ID int, Employee_Name varchar(20), Salary int, 
 Primary key(Employee_ID));
 create table CERTIFIED(Employee_ID int, Aircraft_ID int, 
 foreign key(Employee_ID) references EMPLOYEE(Employee_ID) ON DELETE CASCADE,
 foreign key(Aircraft_ID) references AIRCRAFTS(Aircraft_ID) ON DELETE CASCADE);
 
 insert into FLIGHTS values(123, 'Bangalore', 'Chennai', 268, '13:00:00', '15:00:00', 5000);
 insert into FLIGHTS values(456, 'Chennai', 'Delhi', 2208, '10:05:00', '17:30:00', 10000);
 insert into FLIGHTS values(789, 'Bangalore', 'Abu Dhabi', 2750, '01:00:00', '04:00:00', 8000);
 insert into FLIGHTS values(101, 'Mangalore', 'Mumbai', 893, '14:00:00', '15:00:00', 1500 );
 insert into FLIGHTS values(131, 'Bangalore', 'LA', 14500, '15:00:00', '10:00:00', 50000);
 insert into FLIGHTS values(150, 'Bangalore', 'Frankfort', 7395, '14:00:00', '15:00:00', 50000 );
 insert into FLIGHTS values(151, 'Bangalore', 'Frankfort', 7395, '13:00:00', '13:30:00', 25000);
 insert into FLIGHTS values(155, 'Bangalore', 'Delhi', 7000, '13:00:00', '16:00:00', 15000);
 insert into FLIGHTS values(156, 'Madison', 'New York', 8000, '13:00:00', '16:00:00', 20000);
 insert into FLIGHTS values(157, 'Madison', 'LA', 5000, '13:00:00', '14:00:00', 15000);
 insert into FLIGHTS values(159, 'LA', 'New York', 2000, '14:30:00', '16:00:00', 8000);
 select * from FLIGHTS;
 
 insert into AIRCRAFTS values(1, 'Boeing 737', 5000);
 insert into AIRCRAFTS values(2, 'Boeing 738', 15000);
 insert into AIRCRAFTS values(3, 'Boeing 739', 2800);
 insert into AIRCRAFTS values(4, 'Boeing 740', 20000);
 insert into AIRCRAFTS values(5, 'Boeing 741', 25000);
 select * from AIRCRAFTS;
 
 insert into EMPLOYEE values(11, 'Jack', 50000);
 insert into EMPLOYEE values(22, 'Catherine', 25000);
 insert into EMPLOYEE values(33, 'Emma', 90000);
 insert into EMPLOYEE values(44, 'Jules', 85000);
 insert into EMPLOYEE values(55, 'Keith', 10000);
 insert into EMPLOYEE values(66, 'Luke', 60000);
 insert into EMPLOYEE values(77, 'Haley', 100000);
 select * from EMPLOYEE;
 
 insert into CERTIFIED values(11, 1);
 insert into CERTIFIED values(22, 2);
 insert into CERTIFIED values(33, 3);
 insert into CERTIFIED values(44, 4);
 insert into CERTIFIED values(55, 5);
 insert into CERTIFIED values(55, 1);
 insert into CERTIFIED values(55, 2);
 select * from CERTIFIED;
 
 select A.Aircraft_Name from AIRCRAFTS A, CERTIFIED C where A.Aircraft_ID=C.Aircraft_ID and Employee_ID in
 (select E.Employee_ID from EMPLOYEE E where E.Salary>80000);
 
 select E.Employee_ID, max(A.Cruising_Range) from EMPLOYEE E, AIRCRAFTS A where E.Employee_ID in
 (select E.Employee_ID from EMPLOYEE E, CERTIFIED C where 
 E.Employee_ID=C.Employee_ID group by E.Employee_ID having count(C.Employee_ID)>=3);
 
 select E.Employee_Name from EMPLOYEE E where E.Employee_ID in
 (select Employee_ID from Employee where Salary<(select min(F.Price) from FLIGHTS F where
 F.From_P='Bangalore' and F.To_P='Frankfort'));
 
 select A.Aircraft_Name, avg(E.Salary) from AIRCRAFTS A, EMPLOYEE E, CERTIFIED C where 
 C.Aircraft_ID=A.Aircraft_ID and C.Employee_ID=E.Employee_ID and A.Cruising_Range>1000;
 
 select E.Employee_Name from EMPLOYEE E, CERTIFIED C, AIRCRAFTS A where
 C.Aircraft_ID=A.Aircraft_ID and C.Employee_ID=E.Employee_ID and A.Aircraft_Name='Boeing 737';
 
 select Aircraft_ID from AIRCRAFTS where 
 Cruising_Range>(select Distance from FLIGHTS where From_P='Bangalore' and To_P='Delhi');
 
 select Departs,Flight_Number from FLIGHTS where Flight_Number in 
 ((select Flight_Number from FLIGHTS where From_P='Madison' and To_P='New York' and Arrives<='18:00:00') union
 (select F1.Flight_Number from FLIGHTS F1, FLIGHTS F2 where F1.From_P='Madison' and F1.To_P!='New York' and
 F1.To_P=F2.From_P and F2.To_P='New York' and F2.Departs>F1.Arrives and F2.Arrives<='18:00:00'));
 
 select Employee_Name from Employee where Employee_ID not in 
 (select distinct Employee_ID from CERTIFIED) and 
 Salary>=(select avg(Salary) from EMPLOYEE where Employee_ID not in (select distinct Employee_ID from CERTIFIED));
