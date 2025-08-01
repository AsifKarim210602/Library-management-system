use master;
go
if db_id('project') is not null
begin
alter database project set single_user with rollback immediate;
drop database project;
end
go
create database project;
go
use project;
go
create table address
(
post_code int primary key,
city varchar(30)  not null,
country varchar(30)  not null
);
insert into address values (7800,'Faridpur','Bangladesh');
insert into address values (2200, 'Mayminsing', 'Bangladesh');
insert into address values (6700, 'Sirajganj', 'Bangladesh');
insert into address values (1000, 'Dhaka', 'Bangladesh');
insert into address values (5300, 'Nilphamari', 'Bangladesh');
insert into address values(4000, 'Chittagang', 'Bangladesh');
insert into address values(1900, 'Tangail', 'Bangladesh');
insert into address values (5800, 'Bogura', 'Bangladesh');
insert into address values(1800, 'Manikganj', 'Bangladesh');
insert into address values(1700, 'Gazipur', 'Bangladesh');
create table publisher
(
id int identity(1,1)  not null,
publisher_id varchar(10) PRIMARY KEY,
Name varchar(100)  not null,
publication_year char(4) check(publication_year like '[0-9][0-9][0-9][0-9]')  not null,
post_code int foreign key references address(post_code),
street text ,
phone int  not null,
email varchar(50) check(email like '%_@_%._%')  not null,
constraint unique_pub unique(Name,phone)
);
go
create trigger pub_id
on publisher
after insert
as
begin
update publisher
set publisher_id=CONCAT('pub_',inserted.id)
from publisher join inserted on inserted.id=publisher.id
end
go
insert into publisher (publisher_id,Name,publication_year,phone,email) values  ('x','McGraw-Hill','2020',019131,'schandcompanyltd100@gmail.com');
insert into publisher (publisher_id,Name,publication_year,phone,email) values  ('x','PublisherMc Graw Hill India','2021',019158,'pearson222@gmail.com');
insert into publisher (publisher_id,Name,publication_year,phone,email) values  ('x','S.Chand','2005',019000,'pranticehall458@gmail.com');
insert into publisher (publisher_id,Name,publication_year,phone,email) values 	('x','Pragati Prakashan','2019',019589,'tata789123@gmail.com');
create table author
(
id int identity(1,1)  not null,
author_id varchar(10) primary key,
name varchar(30)  not null,
post_code int foreign key references address(post_code) not null,
nationality varchar(30) not null,
email varchar(50) check(email like '%_@_%._%') not null,
constraint unique_auth unique(name,email)
);
go
create trigger au_id
on author
after insert
as
begin
update author
set author_id=CONCAT('au_',inserted.id)
from author join inserted on inserted.id=author.id
end
go
insert into author (author_id,name,post_code,nationality,email) values   ('x', 'Peter Norton', 6700, 'Bangladeshi', 'salamkhan@gmail.com');
insert into author (author_id,name,post_code,nationality,email) values('x', 'Balagurusamy', 1000, 'Bangladeshi', 'farzanaahmed@gmail.com');
insert into author (author_id,name,post_code,nationality,email) values('x', 'VK Mehta', 5300, 'Bangladeshi', 'rafiqrahman@gmail.com');
insert into author (author_id,name,post_code,nationality,email) values('x', 'Gupta', 1000, 'Bangladeshi', 'shahanabegum@gmail.com');
insert into author (author_id,name,post_code,nationality,email) values('x', 'Kumer', 1000, 'Bangladeshi', 'tariqkhan@gmail.com');
create table book
(
id int identity(1,1)  not null,
book_id varchar(10) primary key,
year_of_publication varchar(4) check(year_of_publication like '[0-9][0-9][0-9][0-9]')  not null,
edition int check(edition >0) not null,
title varchar(50) not null,
sub varchar(20) check(sub in ('Computer Science','Electrical','Math','Communication')) not null,
constraint unique_book unique(title,edition)
);
go
create trigger bk_id
on book
after insert
as
begin
update book
set book_id=CONCAT('bk_',inserted.id)
from book join inserted on inserted.id=book.id
end
go
insert into book (book_id,year_of_publication,edition,title,sub) values ('x', '2005', 3, 'Intoduction to Computers', 'Computer Science');
insert into book (book_id,year_of_publication,edition,title,sub) values  ('x', '2010', 5, 'Fundamental of Computers', 'Computer Science');
insert into book (book_id,year_of_publication,edition,title,sub) values  ('x', '2015', 3, 'Principle of Electronics', 'Electrical');
insert into book (book_id,year_of_publication,edition,title,sub) values  ('x', '2020', 1, 'Hand Book of Electronics', 'Electrical');
insert into book (book_id,year_of_publication,edition,title,sub) values  ('x', '2021', 8, 'Programming in ANSI C', 'Computer Science');
create table book_author
(
book_id varchar(10) foreign key references book(book_id) not null,
author_id varchar(10) foreign key references author(author_id) not null,
constraint unique_book_author unique(book_id,author_id)
);
insert into book_author (book_id,author_id) values ('bk_1','au_1');
insert into book_author (book_id,author_id) values ('bk_2','au_2');
insert into book_author (book_id,author_id) values ('bk_3','au_3');
insert into book_author (book_id,author_id) values ('bk_4','au_4');
insert into book_author (book_id,author_id) values ('bk_4','au_5');
insert into book_author (book_id,author_id) values ('bk_5','au_2');
create table book_publisher
(
book_id varchar(10) foreign key references book(book_id) not null,
publisher_id varchar(10) foreign key references publisher(publisher_id) not null,
constraint unique_book_publisher unique(book_id,publisher_id)
);
insert into book_publisher (book_id,publisher_id) values ('bk_1','pub_1');
insert into book_publisher (book_id,publisher_id) values ('bk_2','pub_2');
insert into book_publisher (book_id,publisher_id) values ('bk_3','pub_3');
insert into book_publisher (book_id,publisher_id) values ('bk_4','pub_4');
insert into book_publisher (book_id,publisher_id) values ('bk_5','pub_2');
create table student
(
roll char(6) primary key check(roll like '[0-9][0-9][0-9][0-9][0-9][0-9]'),
first_name varchar(20)  not null,
last_name varchar(20),
depertment varchar(20) check(depertment in('ICE','CSE','EEE'))  not null,
dob varchar(10) check(dob like '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')  not null,
post_code int foreign key references address(post_code)  not null,
phone int  not null,
email varchar(50) check(email like '%_@_%._%') not null,
sess varchar(9) check(sess like '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')  not null,
street text  not null,
constraint unique_stu unique(phone)
);
insert into student (roll,first_name,last_name,depertment,dob,post_code,phone,email,sess,street) values('210602','Asif','Karim','ICE','2001-05-12',7800,017293,'zisun1020@gmail.com','2020-2021','Meril bypass');
insert into student (roll,first_name,last_name,depertment,dob,post_code,phone,email,sess,street)   values('210603', 'Mahdi', 'Hasan', 'CSE', '2002-05-12',1000, 018765, 'mahdihasan03@gmail.com', '2020-2021', 'Mia bari street');
insert into student (roll,first_name,last_name,depertment,dob,post_code,phone,email,sess,street)  values('210604', 'Sadia', 'Islam', 'EEE', '2000-05-12',1000, 019876, 'sadia04@gmail.com', '2019-2020', 'Rahim street');
insert into student (roll,first_name,last_name,depertment,dob,post_code,phone,email,sess,street)   values('210605', 'Nishat', 'Tasnim', 'ICE', '2001-09-12',6700, 017289, 'nishat05@gmail.com', '2019-2020', 'Sheed street');
insert into student (roll,first_name,last_name,depertment,dob,post_code,phone,email,sess,street)  values('210606', 'Shubail', 'Haque', 'CSE', '2001-05-01',2200, 016253, 'subail06@gmail.com', '2018-2019', 'Independence street');
insert into student (roll,first_name,last_name,depertment,dob,post_code,phone,email,sess,street) values('210607', 'Sojibul', 'Barua', 'EEE', '1999-05-12',1700, 015278, 'sojib07@gmail.com', '2020-2021', 'Bazar road');
insert into student (roll,first_name,last_name,depertment,dob,post_code,phone,email,sess,street) values('210608', 'Moumita', 'Haque', 'ICE', '2001-01-12',2200, 013297, 'moumita08@gmail.com', '2019-2020', 'Center street');
insert into student (roll,first_name,last_name,depertment,dob,post_code,phone,email,sess,street) values('210609', 'Jerin', 'Tasnim', 'CSE', '2001-03-12',1000, 012456, 'jerin09@gmail.com', '2017-2018', 'Jamil steet');
insert into student (roll,first_name,last_name,depertment,dob,post_code,phone,email,sess,street) values('210610', 'Lamia', 'Islam', 'ICE', '2000-02-12',5300, 017432, 'lamia11@gmail.com', '2020-2021', 'Captain manusr ali street');
insert into student (roll,first_name,last_name,depertment,dob,post_code,phone,email,sess,street) values('210611', 'Akash', 'Miya', 'CSE', '2000-05-02',4000, 016754, 'akash12@gmail.com', '2019-2020', 'Mirja bari steet');
create table teacher
(
teacher_id char(4) primary key check(teacher_id like '[0-9][0-9][0-9][0-9]'),
first_name varchar(20)  not null,
last_name varchar(20),
depertment varchar(20) check(depertment in('ICE','CSE','EEE'))  not null,
dob varchar(10) check(dob like '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')  not null,
post_code int foreign key references address(post_code)  not null,
phone int  not null,
email varchar(50) check(email like '%_@_%._%') not null,
position varchar(20) check(position in ('lecturer','assistant professor','associate professor','professor') )  not null,
street text  not null,
constraint unique_tea unique(phone)
);
insert into teacher (teacher_id,first_name,last_name,depertment,dob,post_code,phone,email,position,street) values ('1002', 'Md. Anwar ', 'Hossain', 'ICE', '1990-05-12',2200,01982734, 'manwar.ice@gmail.com', 'associate professor', 'Green Road');
insert into teacher (teacher_id,first_name,last_name,depertment,dob,post_code,phone,email,position,street) values ('1003', 'Kamrul', 'Hasan', 'EEE', '1992-05-12',6700,01823654, 'kamrulhasan@gmail.com', 'professor', 'Lakeview Street');
insert into teacher (teacher_id,first_name,last_name,depertment,dob,post_code,phone,email,position,street) values ('1004', 'Taskin Noor', 'Turna', 'ICE', '1991-05-12',1000,01723918, ' taskin.it1405@gmail.com', 'assistant professor', 'Park Street');
insert into teacher (teacher_id,first_name,last_name,depertment,dob,post_code,phone,email,position,street) values ('1005', 'Riaz', 'Miah', 'CSE', '1992-01-11',5300,01783245, 'riazmiah@gmail.com', 'lecturer', 'Rohim ali street');
insert into teacher (teacher_id,first_name,last_name,depertment,dob,post_code,phone,email,position,street) values ('1006', 'Dr. Md. Omar ', 'Faruk', 'ICE', '1996-02-12',4000,01892456, 'faruk005@gmail.com', 'associate professor', 'Jamal street');
insert into teacher (teacher_id,first_name,last_name,depertment,dob,post_code,phone,email,position,street) values ('1007', 'Akif', 'Mahdi', 'ICE', '1993-07-12',1900, 01782934, ' akif2100@gmail.com', 'lecturer', 'Monsurabad');
insert into teacher (teacher_id,first_name,last_name,depertment,dob,post_code,phone,email,position,street) values ('1008', 'Tanvir', 'Ahmed', 'CSE', '1994-01-12',4000, 01678239, 'tanvirahmed@gmail.com', 'assistant professor', 'Shaheed street');
insert into teacher (teacher_id,first_name,last_name,depertment,dob,post_code,phone,email,position,street) values ('1009', 'Rashid', 'Ali', 'EEE', '1995-08-12',1800, 01927465, 'rashidali@gmail.com', 'professor', 'River Rd');
insert into teacher (teacher_id,first_name,last_name,depertment,dob,post_code,phone,email,position,street) values ('1010', 'Dr. Md. Imran ', 'Hossain', 'ICE', '1993-02-12',5800, 01893456, 'imranhossain001@gmail.com', 'associate professor', 'Captain monsur street');
create table member
(
member_id varchar(10) primary key ,
member_type char(7) check(member_type in ('student','teacher')) not null,
loan_count int check(loan_count>=0) not null,
stat char(6) check(stat in ('active','expire')) not null,
membership_date varchar(10) check(membership_date like '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')  not null,
);
create table student_member
(
id int identity(1,1)  not null,
member_id varchar(10) primary key,
roll char(6) foreign key references student(roll) unique,
);
go
create trigger stu_mem_id
on student_member
after insert
as
begin
update student_member
set member_id=CONCAT('stu_',inserted.id)
from student_member join inserted on inserted.id=student_member.id;
insert into member (member_id,member_type,loan_count,stat,membership_date) 
select student_member.member_id,'student',0,'active',cast(getdate() as date) from student_member join inserted on student_member.id=inserted.id
end
go
insert into student_member (member_id,roll) values ('x',210602);
insert into student_member (member_id,roll) values ('x',210603);
insert into student_member (member_id,roll) values ('x',210604);
insert into student_member (member_id,roll) values('x',210605);
insert into student_member (member_id,roll) values ('x',210606);
insert into student_member (member_id,roll) values ('x',210607);
insert into student_member (member_id,roll) values ('x',210608);
insert into student_member (member_id,roll) values ('x',210609);
insert into student_member (member_id,roll) values('x',210610);
insert into student_member (member_id,roll) values ('x',210611);
create table teacher_member
(
id int identity(1,1)  not null,
member_id varchar(10) primary key,
teacher_id char(4) foreign key references teacher(teacher_id) unique,
);
go
create trigger tea_mem_id
on teacher_member
after insert
as
begin
update teacher_member
set member_id=CONCAT('fac_',inserted.id)
from teacher_member join inserted on inserted.id=teacher_member.id;
insert into member (member_id,member_type,loan_count,stat,membership_date) 
select teacher_member.member_id,'teacher',0,'active',cast(getdate() as date) from teacher_member join inserted on teacher_member.id=inserted.id
end
go
insert into teacher_member (member_id,teacher_id) values('x', 1002);
insert into teacher_member (member_id,teacher_id) values('x', 1003);
insert into teacher_member (member_id,teacher_id) values('x', 1004);
insert into teacher_member (member_id,teacher_id) values('x', 1005);
insert into teacher_member (member_id,teacher_id) values('x', 1006);
insert into teacher_member (member_id,teacher_id) values('x', 1007);
insert into teacher_member (member_id,teacher_id) values('x', 1008);
insert into teacher_member (member_id,teacher_id) values('x', 1009);
insert into teacher_member (member_id,teacher_id) values('x', 1010);
create table shelf
(
id int identity(1,1)  not null,
cell_id varchar(10) primary key,
shelf_no char(2) check(shelf_no like '[0-9][0-9]') not null,
row_no char(1) check(row_no like '[0-9]') not null,
col_no char(1) check(col_no like '[0-9]') not null,
constraint unique_shelf unique(shelf_no,row_no,col_no)
);
go
create trigger loc_id
on shelf
after insert
as
begin
update shelf
set cell_id=CONCAT('loc_',inserted.id)
from shelf join inserted on inserted.id=shelf.id
end
go
insert into shelf (cell_id,shelf_no,row_no,col_no) values ('x','01','1','1');
insert into shelf (cell_id,shelf_no,row_no,col_no) values ('x','01','1','2');
insert into shelf (cell_id,shelf_no,row_no,col_no) values ('x','01','2','1');
insert into shelf (cell_id,shelf_no,row_no,col_no) values ('x','01','2','2');
insert into shelf (cell_id,shelf_no,row_no,col_no) values ('x','01','3','1');
insert into shelf (cell_id,shelf_no,row_no,col_no) values ('x','01','3','2');
insert into shelf (cell_id,shelf_no,row_no,col_no) values ('x','02','1','1');
insert into shelf (cell_id,shelf_no,row_no,col_no) values ('x','02','1','2');
insert into shelf (cell_id,shelf_no,row_no,col_no) values ('x','02','2','1');
insert into shelf (cell_id,shelf_no,row_no,col_no) values ('x','02','2','2');
insert into shelf (cell_id,shelf_no,row_no,col_no) values ('x','02','3','1');
insert into shelf (cell_id,shelf_no,row_no,col_no) values ('x','02','3','2');
create table item
(
id int identity(1,1)  not null,
item_id varchar(10) primary key,
copy_no char(3) check(copy_no like 'C[0-9][0-9]') not null,
stat varchar(10) check(stat in ('available','borrowed','damaged')) not null,
book_id varchar(10) foreign key references book(book_id) not null,
cell_id varchar(10) foreign key references shelf(cell_id) not null,
constraint unique_item unique(book_id,copy_no)
);
go
create trigger item_id
on item
after insert
as
begin
update item
set item_id=CONCAT('it_',inserted.id)
from item join inserted on inserted.id=item.id
end
go
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C01','available','bk_1','loc_1');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C02','available','bk_1','loc_1');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C03','available','bk_1','loc_1');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C04','available','bk_1','loc_1');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C05','available','bk_1','loc_2');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C06','available','bk_1','loc_2');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C01','available','bk_2','loc_2');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C02','available','bk_2','loc_2');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C03','available','bk_2','loc_2');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C04','available','bk_2','loc_3');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C05','available','bk_2','loc_3');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C06','available','bk_2','loc_3');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C01','available','bk_3','loc_7');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C02','available','bk_3','loc_7');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C03','available','bk_3','loc_7');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C04','available','bk_3','loc_8');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C05','available','bk_3','loc_8');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C06','available','bk_3','loc_8');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C01','available','bk_4','loc_9');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C02','available','bk_4','loc_9');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C03','available','bk_4','loc_9');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C04','available','bk_4','loc_10');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C05','available','bk_4','loc_10');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C06','available','bk_4','loc_10');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C01','available','bk_5','loc_3');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C02','available','bk_5','loc_3');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C03','available','bk_5','loc_4');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C04','available','bk_5','loc_4');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C05','available','bk_5','loc_4');
insert into item (item_id,copy_no,stat,book_id,cell_id) values ('x','C06','available','bk_5','loc_4');
create table loan
(
id int identity(1,1)  not null,
loan_id varchar(10) primary key,
item_id varchar(10) foreign key references item(item_id) not null,
stat varchar(10) check(stat in ('active','return')),
issue_date varchar(10) check(issue_date like '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
member_id varchar(10) foreign key references member(member_id) not null,
);
go
create trigger take_loan
on loan
after insert
as
begin
update loan
set loan_id=CONCAT('ln_',inserted.id),issue_date=cast(getdate() as date)
from loan join inserted on inserted.id=loan.id;
update item 
set stat='borrowed' 
from item join inserted on inserted.item_id=item.item_id;
end
go
go
create proc loan_request @member_id varchar(10),@item_id varchar(10) as
begin
Declare @is_active int;
Declare @is_max int;
Declare @member_stat varchar(10);
Declare @count int;
Declare @item_stat varchar(10);
select @member_stat=stat,@count=loan_count,@item_stat=(select stat from item where item_id=@item_id) from member where member.member_id=@member_id 
if @member_stat='active' and @count<2 and @item_stat = 'available'
begin
update  member set loan_count=@count+1 where member.member_id=@member_id  ;
insert into loan (loan_id,item_id,member_id,stat,issue_date) values ('x',@item_id,@member_id,'active','0000-00-00');
end
end
go
exec loan_request 'fac_1','it_1';
exec loan_request 'fac_1','it_22';
exec loan_request 'fac_2','it_3';
exec loan_request 'fac_2','it_15';
exec loan_request 'stu_1','it_5';
exec loan_request 'stu_1','it_27';
exec loan_request 'stu_2','it_7';
exec loan_request 'stu_2','it_21';
exec loan_request 'stu_3','it_9';
exec loan_request 'stu_4','it_10';
create table fine
(
fine_id  int identity(1,1) primary key,
loan_id varchar(10) foreign key references loan(loan_id) not null,
fine_date varchar(10) check(fine_date like '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
reason text,
amount money check(amount>=0) not null
)
go
create trigger apply_fine
on fine
after insert
as
begin
update fine
set fine_date=cast(getdate() as date)
from fine join inserted on inserted.fine_id=fine.fine_id;
end
go
insert into fine (loan_id,reason,amount,fine_date) select loan_id,'late return',20,'0000-00-00' from loan where datediff(day,cast(getdate() as date),issue_date)>=30 and stat='active';
go
create proc show_fine_stu @member_id varchar(10) as
begin
select student.roll,book.title, case 
when datediff(day,cast(getdate() as date),cast(sub.fine_date as date))*3+amount >500
then 500
else datediff(day,cast(getdate() as date),cast(sub.fine_date as date))*3+amount 
end as amount
from
(select member.member_id,loan.item_id,fine.fine_date,fine.amount from member
join loan on member.member_id=loan.member_id 
join fine on loan.loan_id=fine.loan_id
where member.member_id=@member_id) as sub
join student_member on sub.member_id=student_member.member_id
join student on student_member.roll=student.roll
join item on sub.item_id=item.item_id
join book on item.book_id=book.book_id
end
go
exec show_fine_stu 'stu_1';
go
create proc show_fine_teacher @member_id varchar(10) as
begin
select teacher.teacher_id,book.title, case 
when datediff(day,cast(getdate() as date),cast(sub.fine_date as date))*3+amount >500
then 500
else datediff(day,cast(getdate() as date),cast(sub.fine_date as date))*3+amount 
end as amount
from
(select member.member_id,loan.item_id,fine.fine_date,fine.amount from member
join loan on member.member_id=loan.member_id 
join fine on loan.loan_id=fine.loan_id
where member.member_id=@member_id) as sub
join teacher_member on sub.member_id=teacher_member.member_id
join teacher on teacher_member.teacher_id=teacher.teacher_id
join item on sub.item_id=item.item_id
join book on item.book_id=book.book_id
end
go
exec show_fine_teacher 'fac_1';
select * from student;
select * from teacher;
select * from loan;