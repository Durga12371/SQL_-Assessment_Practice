----> Create Index

create index idx_employeesTable_employeeid on Employees_Table(EmployeeID);
create index idx_employeesTable_employeename on Employees_Table(EmployeeName);
create index idx_employeesTable_departmentid on Employees_Table(DepartmentID);
create index idx_departmentTable_departmentid on Department_Table(DepartmentName);

insert into Employees_Table (EmployeeID,EmployeeName,DepartmentID)
values(18,'divya sri',4),
      (13,'Naidu',3);

select * from Employees_Table ;

select EmployeeName from Employees_Table where EmployeeName='Durga';

select * from Employees_Table where EmployeeID=1;

select e.EmployeeName,d.DepartmentName from Employees_Table e
Inner Join Department_Table d 
on e.DepartmentID=d.DepartmentID;



go






---->JSON

declare @json nvarchar(4000)
set @json = '{
  "name":"Durga",
   "Id":1
}'
 


select ISJSON(@json)
select JSON_QUERY(@json,'$')
--select JSON_QUERY(@json,'$.name')
select JSON_VALUE(@json,'$.Id')
select JSON_VALUE(@json,'strict $.gmail')