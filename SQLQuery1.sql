create database blogdbb
use blogdbb
create table Categories(
Id int primary key identity,
[Name] nvarchar(50) not null unique)
insert into Categories
values('Agdamli')
insert into Categories
values('Qessab')
insert into Categories
values('Hekim')
 
create table Users(
Id int primary key identity,
UserName nvarchar(50) not null unique,
FullName nvarchar(50) not null,
Age int check(Age>0 and Age<150)
)
insert into Users
values('Emin', 'Mustafayev Emin' , 149)
insert into Users
values('Bextiyar ', 'Bextiyar Novruzov' , 148)
insert into Users
values('Anar', 'Anar Bey' , 147)

create table Tags(
Id int primary key identity,
[Name] nvarchar(50) not null unique)
insert into Tags
values('Dvijeniya')
insert into Tags
values('Mujik')
insert into Tags
values('Hekim baba')

create table Blogs(
Id int primary key identity,
Title nvarchar(50),
[Description] nvarchar(250) not null,
userId int foreign key references Users(Id),
categoriesId int foreign key references Categories(Id)
)
insert into Blogs
values('Veziyyetden cixmagin en yaxsi on yolu','Agdamli kimi dusun ve varlan',1,1)
insert into Blogs
values('Niye et dogramag bir senetdir','Ineklerimi cox isteyirem',2,2)
insert into Blogs
values('Xestelerim emeliyyatdan sonra niye daha pis','Xestelerimi cox isteyirem',3,3)



create table Comments(
Id int primary key identity,
Content nvarchar(250),
userId int foreign key references Users(Id),
blogID int foreign key references Blogs(Id)
)
insert into Comments
values('yuz min dollarliq masini danisib 70 min manata aldim',1,1)
insert into Comments
values('Niye camaata mal eti adiyla essek eti satiram',2,2)
insert into Comments
values('Niyede sirinlik almiyim xalata cib niye qoyulub',3,4)--arada error aldim ona gore 4 yazdm

 

create table BlogsTag(
Id int primary key identity,
blogId int foreign key references Tags(Id),
tagId int foreign key references Blogs(Id)
)
insert into BlogsTag
values(1,1)
insert into BlogsTag
values(2,2)
insert into BlogsTag
values(3,4)

create view BlogUserDetallari as
Select
Blogs.Title,
Users.UserName,
Users.FullName
from Blogs
join Users on
Users.Id=Blogs.userId

select* from BlogUserDetallari


create view BlogCategoriesDetallari as
select
Blogs.Title,
Categories.Name as xususiyyetleri
from Blogs
join Categories
on Categories.Id=Blogs.categoriesId

select*from BlogCategoriesDetallari


create procedure usp_Get_Blog @userId int as
select
Blogs.Title,
Blogs.Description 
from Blogs
where 
Blogs.userId=@userId

EXEC usp_Get_Blog @userId = 1
EXEC usp_Get_Blog @userId = 2
EXEC usp_Get_Blog @userId = 3


create procedure usp_Get_comments @userId int as
select Comments.Content
from Comments
where
Comments.userId=@userId

exec usp_Get_comments @userID = 1
exec usp_Get_comments @userID = 2
exec usp_Get_comments @userID = 3



create function Gets_Blog_number( @categoryId int) 
returns int
as
begin
declare @BlogsCount int
select @BlogsCount = COUNT(*)
 from Blogs
where Blogs.categoriesId=@categoryId
return @BlogsCount
end

select dbo.Gets_Blog_number(1)
select dbo.Gets_Blog_number(2)
select dbo.Gets_Blog_number(3)

create function GetBlogsAsTable(@userId int)
returns Table
as
return(

select Blogs.Title,
Blogs.Description
from Blogs
where Blogs.userId=@userId
) 
select * from GetBlogsAsTable(1)
select * from GetBlogsAsTable(2)
select * from GetBlogsAsTable(3)
 

 









  












 






 