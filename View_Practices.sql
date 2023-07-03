--- View is nothing but Virtual table.



CREATE VIEW EmployeeSalaryView AS
SELECT E.EmployeeID, E.EmployeeName, S.SalaryAmount
FROM Employees_Table E
JOIN Salarie_Table S  ON E.EmployeeID = S.EmployeeID;


go
----find the employee(s) with the Max salary:

SELECT EmployeeID, EmployeeName, SalaryAmount
FROM EmployeeSalaryView
WHERE SalaryAmount = (
  SELECT MAX(SalaryAmount)
  FROM EmployeeSalaryView
);

go

---find the employee(s) with the Min salary:

SELECT EmployeeID, EmployeeName, SalaryAmount
FROM EmployeeSalaryView
WHERE SalaryAmount = (
  SELECT MIN(SalaryAmount)
  FROM EmployeeSalaryView
);
go

----find the employee with the second-highest salary

SELECT EmployeeID, EmployeeName, SalaryAmount
FROM EmployeeSalaryView
WHERE SalaryAmount = (
  SELECT MAX(SalaryAmount)
  FROM EmployeeSalaryView
  WHERE SalaryAmount < (
    SELECT MAX(SalaryAmount)
    FROM EmployeeSalaryView
  )
);
go

with cte as (
select * from EmployeeSalaryView)
select * from cte;




----->
CREATE VIEW EmployeeSalaryView1 AS
SELECT E.EmployeeID, E.EmployeeName, S.SalaryAmount,E.DepartmentID
FROM Employees_Table E
JOIN Salarie_Table S  ON E.EmployeeID = S.EmployeeID;



WITH DepartmentCTE AS (
  SELECT DepartmentID,DepartmentName
  FROM Department_Table
)
SELECT E.EmployeeID, E.EmployeeName, D.DepartmentName
from EmployeeSalaryView1 E 
Inner Join Department_Table D on E.DepartmentID=D.DepartmentID