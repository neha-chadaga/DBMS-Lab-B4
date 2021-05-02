create database bookDealer;
show databases;
use bookDealer;
show tables;
create table AUTHOR(Author_ID int, Name varchar(20), City varchar(10), Country varchar(10), Primary key(Author_ID));
create table PUBLISHER(Publisher_ID int, Name varchar(20), City varchar(10), Country varchar(10), Primary key(Publisher_ID));
create table CATEGORY(Category_ID int, Description varchar(30), Primary key(Category_ID));
create table CATALOG(Book_ID int, Title varchar(15), Author_ID int, Publisher_ID int, Category_ID int, Year int, Price int, 
foreign key(Publisher_ID) references PUBLISHER(Publisher_ID) on delete cascade,
foreign key(Category_ID) references CATEGORY(Category_ID) on delete cascade);
create table ORDERDETAILS(Order_No int, Book_ID int, Quantity int , primary key(Order_No,Book_ID));

insert into AUTHOR values(1001, 'TERAS CHAN', 'CA', 'USA');
insert into AUTHOR values(1002, 'STEVENS', 'ZOMBI', 'UGANDA');
insert into AUTHOR values(1003, 'M MANO', 'CAIR', 'CANADA');
insert into AUTHOR values(1004, 'KARTHIK B P', 'NEW YORK', 'USA');
insert into AUTHOR values(1005, 'WILLIAM STALLINGS', 'LAS VEGAS', 'USA');
select * from AUTHOR;

insert into PUBLISHER values(1, 'PEARSON', 'NEW YORK', 'USA' );
insert into PUBLISHER values(2, 'EEE', 'NSW', 'USA' );
insert into PUBLISHER values(3, 'PHI', 'DELHI', 'INDIA');
insert into PUBLISHER values(4, 'WILLEY', 'BERLIN', 'GERMANY' );
insert into PUBLISHER values(5, 'MGH', 'NEW YORK', 'USA');
select * from PUBLISHER;

insert into CATEGORY values( 1001, 'COMPUTER SCIENCE' );
insert into CATEGORY values( 1002, 'ALGORITHM DESIGN');
insert into CATEGORY values( 1003, 'ELECTRONICS');
insert into CATEGORY values( 1004, 'PROGRAMMING');
insert into CATEGORY values( 1005, 'OPERATING SYSTEMS');
select * from CATEGORY;

insert into CATALOG values(11, 'UNIX SYSTEM PRG', 1001, 1, 1001, 2000, 251);
insert into CATALOG values(12, 'DIGITAL SIGNALS', 1002, 2, 1003, 2001, 425);
insert into CATALOG values(13, 'LOGIC DESIGN', 1003, 3, 1002, 1999, 225);
insert into CATALOG values(14, 'SERVER PRG', 1004, 4, 1004, 2001, 333);
insert into CATALOG values(15, 'LINUX OS', 1005, 5, 1005, 2003, 326);
insert into CATALOG values(16, 'C++ BIBLE', 1005, 5, 1001, 2000, 526);
insert into CATALOG values(17, 'COBOL HANDBOOK', 1005, 4, 1001, 2000, 658);
select * from CATALOG;

insert into ORDERDETAILS values(1, 11, 5);
insert into ORDERDETAILS values(2, 12, 8);
insert into ORDERDETAILS values(3, 13, 15);
insert into ORDERDETAILS values(4, 14, 22);
insert into ORDERDETAILS values(5, 15, 3);
insert into ORDERDETAILS values(2, 17, 10);
select * from ORDERDETAILS;
commit;

select A.Name,C.Title,C.Price from AUTHOR A,CATALOG C where C.Author_ID=A.Author_ID and C.Year>=2000 and 
A.Name=(select A.Name from AUTHOR A,CATALOG C where A.Author_ID=C.Author_ID group by C.Author_ID having count(*)>=2);

select A.Name from AUTHOR A, CATALOG C, ORDERDETAILS O where O.Book_ID=C.Book_ID and A.Author_ID=C.Author_ID
 and O.Book_ID=(select Book_ID from ORDERDETAILS where quantity=(select max(quantity) from ORDERDETAILS));
 
update CATALOG set price=price+(10*price/100)  where Publisher_ID=3 ;
select * from CATALOG;
