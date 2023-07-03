------  CTE 



------ Employee_Table detials

WITH EmployeeCTE AS (
  SELECT *
  FROM Employees_Table
)
SELECT *
FROM EmployeeCTE;

---Department_Table

WITH DepartmentCTE AS (
  SELECT *
  FROM Department_Table
)
SELECT *
FROM DepartmentCTE;


----- Salary Table

With SalaryCTE as(
 select * from Salarie_Table
 )
 select * from SalaryCTE;


 -----> CTE between Employee_table and Department_Table
----> Display Employee details with Department

 WITH DepartmentCTE AS (
  SELECT DepartmentID,DepartmentName
  FROM Department_Table
),
EmployeeCTE AS (
  SELECT EmployeeID,EmployeeName,DepartmentID
  FROM Employees_Table
)
SELECT E.EmployeeID, E.EmployeeName, D.DepartmentName
FROM EmployeeCTE E
JOIN DepartmentCTE D ON E.DepartmentID = D.DepartmentID;



----->Display Employee details with Department and Salary

WITH DepartmentCTE AS (
  SELECT DepartmentID,DepartmentName
  FROM Department_Table
),
EmployeeCTE AS (
  SELECT EmployeeID, EmployeeName, DepartmentID
  FROM Employees_Table
),
SalaryCTE AS (
  SELECT EmployeeID, SalaryAmount
  FROM Salarie_Table
)
SELECT E.EmployeeID, E.EmployeeName, D.DepartmentName, S.SalaryAmount
FROM EmployeeCTE E
JOIN DepartmentCTE D ON E.DepartmentID = D.DepartmentID
JOIN SalaryCTE S ON E.EmployeeID = S.EmployeeID;


---->Display Highest Salary Employee Details with Department Name


WITH MaxSalaryCTE AS (
  SELECT Max(SalaryAmount) as salaryamount
  FROM Salarie_Table 
),
DepartmentCTE AS (
  SELECT DepartmentID,DepartmentName
  FROM Department_Table
),
EmployeeCTE AS (
    SELECT E.EmployeeID, E.EmployeeName, S.SalaryAmount,D.DepartmentName
  FROM Employees_Table E
  JOIN DepartmentCTE D ON E.DepartmentID = D.DepartmentID
  JOIN Salarie_Table S ON E.EmployeeID = S.EmployeeID
  WHERE S.SalaryAmount = (SELECT salaryamount FROM MaxSalaryCTE)
)
select * from EmployeeCTE;


----> Display Minumum Salary Employee Details with Department Name


WITH MaxSalaryCTE AS (
  SELECT Min(SalaryAmount) as salaryamount
  FROM Salarie_Table 
),
DepartmentCTE AS (
  SELECT DepartmentID,DepartmentName
  FROM Department_Table
),
EmployeeCTE AS (
    SELECT E.EmployeeID, E.EmployeeName, S.SalaryAmount,D.DepartmentName
  FROM Employees_Table E
  JOIN DepartmentCTE D ON E.DepartmentID = D.DepartmentID
  JOIN Salarie_Table S ON E.EmployeeID = S.EmployeeID
  WHERE S.SalaryAmount = (SELECT salaryamount FROM MaxSalaryCTE)
)
select * from EmployeeCTE;



Select e.EmployeeName,d.DepartmentName from Employees_Table e
Left join Department_Table d on e.DepartmentID=d.DepartmentID

Select e.EmployeeName,d.DepartmentName from Employees_Table e
right join Department_Table d on e.DepartmentID=d.DepartmentID


Select e.EmployeeName,d.DepartmentName from Employees_Table e
CROSS join Department_Table d 

select * from Employees_Table
select * from Department_Table

select e.EmployeeName,d.DepartmentName from Employees_Table e
Inner join Department_Table d on e.EmployeeID=d.DepartmentID






--- Temp table




CREATE TABLE #products_temp_table (
	product_id int primary key,
	product_name nvarchar(50),
	price int
)

INSERT INTO #products_temp_table (product_id, product_name, price)

VALUES

(1,'Computer',800),
(2,'TV',1200),
(3,'Printer',150),
(4,'Desk',400)

SELECT * FROM #products_temp_table

