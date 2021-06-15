create database movieDatabase;
use movieDatabase;
show tables;
create table ACTOR(Actor_ID int, Actor_Name varchar(20), Gender varchar(10), Primary key(Actor_ID));
create table DIRECTOR(Director_ID int, Director_Name varchar(15), Director_Phone varchar(10), Primary key(Director_ID));
create table MOVIES(Movie_ID int, Movie_Title varchar(25), Movie_Year int, Movie_Language varchar(15), Director_ID int,
Primary key(Movie_ID),
Foreign key(Director_ID) references DIRECTOR(Director_ID) ON UPDATE CASCADE);
create table MOVIE_CAST(Actor_ID int, Movie_ID int, Role varchar(10),
Foreign key(Actor_ID) references ACTOR(Actor_ID) ON DELETE CASCADE, Foreign key(Movie_ID) references MOVIES(Movie_ID) ON DELETE CASCADE);
create table RATING(Movie_ID int, Rev_Stars int, 
Foreign key(Movie_ID) references MOVIES(Movie_ID) ON UPDATE CASCADE);

insert into ACTOR values(1, 'Sam Neill', 'male');
insert into ACTOR values(2, 'Kim Novac', 'female');
insert into ACTOR values(3, 'Robert Shaw', 'male');
insert into ACTOR values(4, 'Janet Leigh', 'female');
insert into ACTOR values(5, 'Diane Keaton', 'female');
insert into ACTOR values(6, 'Christian B', 'male');
select * from ACTOR;

insert into DIRECTOR values(111, 'Hitchcock', '1234567899');
insert into DIRECTOR values(222, 'Steven Spielberg', '1234567888');
insert into DIRECTOR values(333, 'Christopher N', '1234567898');
insert into DIRECTOR values(444, 'Woody Allen', '1234561234');
insert into DIRECTOR values(555, 'Quentin T', '1234512345');
select * from DIRECTOR;

insert into MOVIES values(561, 'Jurassic Park', 1993, 'English', 222);
insert into MOVIES values(562, 'Vertigo', 1958, 'English', 111);
insert into MOVIES values(563, 'Jaws', 1975, 'English', 222);
insert into MOVIES values(564, 'Psycho', 1960, 'English', 111);
insert into MOVIES values(565, 'Manhatten', 1979, 'English', 444);
insert into MOVIES values(566, 'The Dark Knight', 2008, 'English', 333);
insert into MOVIES values(567, 'The Dark Knight Rises', 2009, 'English', 333);
insert into MOVIES values(568, 'Thor', 2022, 'English', 444);
select * from MOVIES;

insert into MOVIE_CAST values(1, 561, 'abc');
insert into MOVIE_CAST values(2, 562, 'bcd');
insert into MOVIE_CAST values(3, 563, 'hij');
insert into MOVIE_CAST values(4, 564, 'klm');
insert into MOVIE_CAST values(5, 565, 'nop');
insert into MOVIE_CAST values(6, 566, 'xyz');
insert into MOVIE_CAST values(6, 567, 'xyz1');
insert into MOVIE_CAST values(1, 568, 'abcd');
select * from MOVIE_CAST;

insert into RATING values(561, 2);
insert into RATING values(561, 3);
insert into RATING values(561, 4);
insert into RATING values(562, 3);
insert into RATING values(563, 4);
insert into RATING values(564, 2);
insert into RATING values(565, 1);
insert into RATING values(566, 4);
select * from RATING;

select M.Movie_Title from MOVIES M, DIRECTOR D where M.Director_ID=D.Director_ID and D.Director_Name='Hitchcock';

select M.Movie_Title from ACTOR A,MOVIE_CAST C,MOVIES M where A.Actor_ID=C.Actor_ID and C.Movie_ID=M.Movie_ID
and A.Actor_ID in (select Actor_ID from MOVIE_CAST group by Actor_ID having COUNT(*)>=2);  

select Actor_Name from ACTOR where Actor_ID in
(select a.Actor_ID from 
(select Actor_ID from MOVIE_CAST natural join MOVIES where Movie_Year<2000)a inner join
(select Actor_ID from MOVIE_CAST natural join MOVIES where Movie_Year>2015)b 
on a.Actor_ID=b.Actor_ID);

select M.Movie_Title, max(R.Rev_stars) from MOVIES M, RATING R where R.Movie_ID=M.Movie_ID 
group by M.Movie_Title having count(R.Rev_Stars>=1)
order by M.Movie_Title;

update RATING R set R.Rev_Stars=5 where R.Movie_ID in 
(select M.Movie_ID from MOVIES M, DIRECTOR D where M.Director_ID=D.Director_ID and D.Director_Name='Steven Spielber');
select * from RATING;
