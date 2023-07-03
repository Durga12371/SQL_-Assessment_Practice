select * from student_table
select * from Department_Table

--- Display number students in department

select d1.Name,count(s1.Department_Id) as count from student_table s1 
Inner Join Department_Table d1 on s1.Department_Id=d1.Id  group by s1.Department_Id , d1.Name

------Display the Computer Students

select s1.Student_ID,s1.Student_Name,s1.Student_Email,d1.Name from student_table as s1 
Inner Join Department_Table d1 on s1.Department_Id=d1.Id where d1.Id=1

--Display the mechanical Students
select s1.Student_ID,s1.Student_Name,s1.Student_Email,d1.Name from student_table as s1 Inner Join Department_Table d1 on s1.Department_Id=d1.Id where d1.Id=5

---Display Computer and Mechanical Students
select s1.Student_ID,s1.Student_Name,s1.Student_Email,d1.Name from student_table as s1 Inner Join Department_Table d1 on s1.Department_Id=d1.Id where d1.Id=5 or d1.Id=1

select s1.Student_ID,s1.Student_Name,s1.Student_Email,d1.Name from student_table as s1 Inner Join Department_Table d1 on s1.Department_Id=d1.Id 

---Check Clustered Index

Execute sp_helpindex student_table

---  Create Clusterd Index
