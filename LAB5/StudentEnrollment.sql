create database StudentEnrollment;
show databases;
use StudentEnrollment;
show tables;
create table STUDENT(Reg_Number varchar(15), Sname varchar(20), Major varchar(20), Birth_Date date,
 Primary key(Reg_Number));
 create table COURSE(Course_Number int, Course_Name varchar(20), Department varchar(10),
 Primary key(Course_Number));
 create table ENROLL(Reg_Number varchar(15), Course_Number int, Sem int, Marks int,
 foreign key(Reg_Number) references STUDENT(Reg_Number) ON DELETE CASCADE, 
 foreign key(Course_Number) references COURSE(Course_Number) ON DELETE CASCADE);
 create table BOOK_ADOPTION(Course_Number int, Sem int, Book_ISBN int, 
 foreign key(Course_Number) references COURSE(Course_Number) ON DELETE CASCADE,
 foreign key(Book_ISBN) references BTEXT(Book_ISBN) ON DELETE CASCADE);
 create table BTEXT(Book_ISBN int, Book_Title varchar(20), Publisher varchar(20), Author varchar(20),
 Primary key(Book_ISBN));

insert into STUDENT values('CS01', 'Ram', 'DS', '1986-03-12' );
insert into STUDENT values('IS02', 'Smith', 'USP', '1987-12-23' );
insert into STUDENT values('EC03', 'Ahmed', 'SNS', '1985-04-17' );
insert into STUDENT values('CS03', 'Sneha', 'DBMS', '1987-01-01' );
insert into STUDENT values('TC05', 'Akhila', 'EC', '1986-10-06' );
select * from STUDENT;

insert into COURSE values(11, 'DS', 'CS');
insert into COURSE values(22, 'USP', 'IS');
insert into COURSE values(33, 'SNS', 'EC');
insert into COURSE values(44, 'DBMS', 'CS');
insert into COURSE values(55, 'EC', 'TC');
select * from COURSE;

insert into ENROLL values('CS01', 11, 4, 85);
insert into ENROLL values('IS02', 22, 6, 80);
insert into ENROLL values('EC03', 33, 2, 80);
insert into ENROLL values('CS03', 44, 6, 75);
insert into ENROLL values('TC05', 55, 2, 8);
select * from ENROLL;

insert into BTEXT values(1, 'DS and C', 'Princeton', 'Padma Reddy');
insert into BTEXT values(2, 'Fundamentals of DS', 'Princeton', 'Godse');
insert into BTEXT values(3, 'Fundamentals of DBMS', 'Princeton', 'Navathe');
insert into BTEXT values(4, 'SQL', 'Princeton', 'Foley');
insert into BTEXT values(5, 'Electronics Circuits', 'TMH', 'Elmasri');
insert into BTEXT values(6, 'Adv Unix Prog', 'TMH', 'Stevens');
select * from BTEXT;

insert into BOOK_ADOPTION values(11, 4, 1);
insert into BOOK_ADOPTION values(11, 4, 2);
insert into BOOK_ADOPTION values(44, 6, 3);
insert into BOOK_ADOPTION values(44, 6, 4);
insert into BOOK_ADOPTION values(55, 2, 5);
insert into BOOK_ADOPTION values(22, 6, 6);
insert into BOOK_ADOPTION values(55, 2, 1);
select * from BOOK_ADOPTION;

insert into BTEXT values(7,'Operating Systems', 'TMH', 'Abcd');
insert into BOOK_ADOPTION values(55, 4, 7);

select C.Course_Number,T.Book_ISBN,T.Book_Title from COURSE C, BTEXT T, BOOK_ADOPTION B where 
B.Course_Number=C.Course_Number and B.Book_ISBN=T.Book_ISBN and C.Department='CS' and
 (select count(B.Book_ISBN) from BOOK_ADOPTION B where C.Course_Number=B.Course_Number)>=2
 order by T.Book_Title;
 
 select distinct C.Department from COURSE C where C.Department in
 (select C.Department from COURSE C, BOOK_ADOPTION B, BTEXT T where C.Course_Number=B.Course_Number
 and T.Book_ISBN=B.Book_ISBN and T.Publisher='Princeton') and C.Department not in
 (select C.Department from COURSE C, BOOK_ADOPTION B, BTEXT T where B.Course_Number=C.Course_Number
 and T.Book_ISBN=B.Book_ISBN and T.Publisher='!Princeton'); 
