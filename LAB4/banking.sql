create database BankingEnterprise;
show databases;
use BankingEnterprise;
show tables;
create table BRANCH(Branch_Name varchar(20), Branch_City varchar(20), Assets real, Primary key(Branch_Name));
create table ACCOUNTS(Accno int, Branch_Name varchar(20), Balance real, Primary key(Accno),
foreign key(Branch_Name) references BRANCH(Branch_Name) ON DELETE CASCADE);
create table CUSTOMER(Customer_Name varchar(20), Customer_Street varchar(25), Customer_City varchar(20),
 Primary key(Customer_Name));
create table DEPOSITOR(Customer_Name varchar(20), Accno int,
 foreign key(Customer_Name) references CUSTOMER(Customer_Name) ON DELETE CASCADE,
 foreign key(Accno) references ACCOUNTS(Accno) ON DELETE CASCADE);
create table LOAN(Loan_Number int, Branch_Name varchar(20), Amount real, Primary key(Loan_Number),
foreign key(Branch_Name) references BRANCH(Branch_Name) ON DELETE CASCADE);
create table BORROWER(Customer_Name varchar(20), Loan_Number int,
foreign key(Customer_Name) references CUSTOMER(Customer_Name) ON DELETE CASCADE,
 foreign key(Loan_Number) references LOAN(Loan_Number) ON DELETE CASCADE);
 
 insert into BRANCH values('SBI PD Nagar', 'Bangalore', 200000);
insert into BRANCH values('SBI Rajaji Nagar', 'Banagalore', 500000);
insert into BRANCH values('SBI Jayanagar', 'Bangalore', 660000);
insert into BRANCH values('SBI Vijaya Nagar', 'Bangalore', 870000);
insert into BRANCH values('SBI Hosakerehalli', 'Bangalore', 550000);
insert into BRANCH values('SBI RR Nagar', 'Hyderabad', 850000);
insert into BRANCH values('SBI XY Nagar', 'Hyderabad', 900000);
insert into BRANCH values('SBI Race Road', 'Kerela', 750000);
insert into BRANCH values('SBI AB Nagar', 'Kerela', 120000);
select * from BRANCH;
 
insert into ACCOUNTS values(1234602, 'SBI Hosakerehalli', 5000);
insert into ACCOUNTS values(1234603, 'SBI Vijaya Nagar', 5000);
insert into ACCOUNTS values(1234604, 'SBI Jayanagar', 5000);
insert into ACCOUNTS values(1234605, 'SBI Rajaji Nagar', 10000);
insert into ACCOUNTS values(1234503, 'SBI Vijaya Nagar', 40000);
insert into ACCOUNTS values(1234504, 'SBI PD Nagar', 4000);
insert into ACCOUNTS values(1234510, 'SBI Vijaya Nagar', 6000);
insert into ACCOUNTS values(1234701, 'SBI RR Nagar', 9000);
insert into ACCOUNTS values(1234702, 'SBI XY Nagar', 8000);
insert into ACCOUNTS values(1234801, 'SBI Race Road', 1200);
insert into ACCOUNTS values(1234802, 'SBI AB Nagar', 3000);
select * from ACCOUNTS;

insert into CUSTOMER values('Kezar', 'MG Road', 'Bangalore');
insert into CUSTOMER values('Lal Krishna', 'St Mks Road', 'Bangalore');
insert into CUSTOMER values('Rahul', 'Augsten Road', 'Bangalore');
insert into CUSTOMER values('Lallu', 'VS Road', 'Bangalore');
insert into CUSTOMER values('Faizal', 'Resedency Road', 'Bangalore');
insert into CUSTOMER values('Rajeev', 'Dicknsn Road', 'Bangalore');
insert into CUSTOMER values('Selena', 'XYZ Road', 'Hyderabad');
select * from CUSTOMER;

insert into DEPOSITOR values('Kezar', 1234602);
insert into DEPOSITOR values('Lal Krishna', 1234603);
insert into DEPOSITOR values('Rahul', 1234604);
insert into DEPOSITOR values('Lallu', 1234605);
insert into DEPOSITOR values('Faizal', 1234503);
insert into DEPOSITOR values('Rajeev', 1234504);
insert into DEPOSITOR values('Faizal', 1234510);
insert into DEPOSITOR values('Selena', 1234701);
insert into DEPOSITOR values('Selena', 1234702);
select * from DEPOSITOR;

insert into LOAN values(10011, 'SBI Jayanagar', 10000);
insert into LOAN values(10012, 'SBI Vijaya Nagar', 5000);
insert into LOAN values(10013, 'SBI Hosakerehalli', 20000);
insert into LOAN values(10014, 'SBI PD Nagar', 15000);
insert into LOAN values(10015, 'SBI Rajaji Nagar', 25000);
select * from LOAN;

insert into BORROWER values('Kezar', 10011);
insert into BORROWER values('Lal Krishna', 10012);
insert into BORROWER values('Rahul', 10013);
insert into BORROWER values('Lallu', 10014);
insert into BORROWER values('Lal Krishna', 10015);
select * from BORROWER;

select D.Customer_Name from DEPOSITOR D, ACCOUNTS A where D.Accno=A.Accno and A.Branch_Name='SBI Vijaya Nagar' 
group by D.Customer_Name having count(D.Customer_Name)>=2;

select Customer_Name from DEPOSITOR 
join ACCOUNTS on ACCOUNTS.Accno=DEPOSITOR.Accno 
join BRANCH on BRANCH.Branch_Name=ACCOUNTS.Branch_Name where BRANCH.Branch_City='Hyderabad'
group by DEPOSITOR.Customer_Name having count(DISTINCT BRANCH.Branch_Name)=(select count(Branch_Name) from BRANCH 
where BRANCH.Branch_City='Hyderabad');

delete from ACCOUNTS where Branch_Name in (select Branch_Name from BRANCH where Branch_City='Kerela');
select * from ACCOUNTS;
