create database CustOrderProcessing;
show databases;
use CustOrderProcessing;
show tables;
create table CUSTOMER(Cust_Number int, Cname varchar(15), City varchar(15), Primary key(Cust_Number));
create table CORDER(Order_Number int, Odate date, Cust_Number int, Order_Amt int, primary key(Order_Number), 
foreign key(Cust_Number) references CUSTOMER(Cust_Number) ON DELETE CASCADE);
create table CITEM(Item_Number int, Unit_Price int, Primary key(Item_Number));
create table CORDER_ITEM(Order_Number int, Item_Number int, Qty int, 
foreign key(Order_Number) references CORDER(Order_Number), 
foreign key(Item_Number) references CITEM(Item_Number) ON DELETE SET NULL);
create table WAREHOUSE(Warehouse_Number int,  City varchar(15), Primary key(Warehouse_Number));
create table SHIPMENT(Order_Number int, Warehouse_Number int, Shipment_Date date, 
foreign key(Order_Number) references CORDER(Order_Number) ON DELETE CASCADE,
foreign key(Warehouse_Number) references WAREHOUSE(Warehouse_Number) ON DELETE CASCADE);

insert into CUSTOMER values(771, 'Pushpa K', 'Bangalore');
insert into CUSTOMER values(772, 'Suman', 'Mumbai');
insert into CUSTOMER values(773, 'Sourav', 'Calicut');
insert into CUSTOMER values(774, 'Laila', 'Hyderabad');
insert into CUSTOMER values(775, 'Faizal', 'Bangalore');
select * from CUSTOMER;

insert into CORDER values(111, '2002-01-22', 771, 18000);
insert into CORDER values(112, '2002-07-30', 774, 6000);
insert into CORDER values(113, '2003-04-03', 775, 9000);
insert into CORDER values(114, '2003-11-03', 775, 29000);
insert into CORDER values(115, '2003-12-10', 773, 29000);
insert into CORDER values(116, '2004-08-19', 772, 56000);
insert into CORDER values(117, '2004-09-10', 771, 20000);
insert into CORDER values(118, '2004-11-20', 775, 29000);
insert into CORDER values(119, '2005-02-13', 774, 29000);
insert into CORDER values(120, '2005-10-13', 775, 29000);
select * from CORDER;

insert into CITEM values(5001, 503);
insert into CITEM values(5002, 750);
insert into CITEM values(5003, 150);
insert into CITEM values(5004, 600);
insert into CITEM values(5005, 890);
select * from CITEM;

insert into CORDER_ITEM values(111, 5001, 50);
insert into CORDER_ITEM values(112, 5003, 20);
insert into CORDER_ITEM values(113, 5002, 50);
insert into CORDER_ITEM values(114, 5005, 60);
insert into CORDER_ITEM values(115, 5004, 90);
insert into CORDER_ITEM values(116, 5001, 10);
insert into CORDER_ITEM values(117, 5003, 80);
insert into CORDER_ITEM values(118, 5005, 50);
insert into CORDER_ITEM values(119, 5002, 10);
insert into CORDER_ITEM values(120, 5004, 45);
select * from CORDER_ITEM;

insert into WAREHOUSE values(1, 'Delhi');
insert into WAREHOUSE values(2, 'Bombay');
insert into WAREHOUSE values(3, 'Chennai');
insert into WAREHOUSE values(4, 'Bangalore');
insert into WAREHOUSE values(5, 'Bangalore');
insert into WAREHOUSE values(6, 'Delhi');
insert into WAREHOUSE values(7, 'Bombay');
insert into WAREHOUSE values(8, 'Chennai');
insert into WAREHOUSE values(9, 'Delhi');
insert into WAREHOUSE values(10, 'Bangalore');
select * from WAREHOUSE;

insert into SHIPMENT values(111, 1, '2002-02-10');
insert into SHIPMENT values(112, 5, '2002-09-10');
insert into SHIPMENT values(113, 8, '2003-02-10');
insert into SHIPMENT values(114, 3, '2003-12-10');
insert into SHIPMENT values(115, 9, '2004-01-19');
insert into SHIPMENT values(116, 1, '2004-09-20');
insert into SHIPMENT values(117, 5, '2004-09-10');
insert into SHIPMENT values(118, 7, '2004-11-30');
insert into SHIPMENT values(119, 7, '2005-04-30');
insert into SHIPMENT values(120, 6, '2005-12-21');
select * from SHIPMENT;

select C.Cname, count(O.Order_Number) as Number_Of_Orders, AVG(O.Order_Amt) as Avg_Amount
from CUSTOMER C, CORDER O where C.Cust_Number=O.Cust_Number group by O.Cust_Number;

select S.Order_Number from SHIPMENT S, WAREHOUSE W where S.Warehouse_Number=W.Warehouse_Number and W.city='Delhi';

delete from CITEM where Item_Number=5005;
select * from CITEM;
select * from CORDER_ITEM;
