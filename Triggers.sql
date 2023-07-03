select * from Employees
select * from New_Employee
select * from tblEmployeeAudit
go

alter trigger tr_Employee
on Employees
for insert
as
begin
    declare @ID int
	Select @ID=ID from inserted
	insert into  tblEmployeeAudit
	values (
	      CAST(@ID as varchar(5))+
		' is added at ' +
		cast(getdate() as varchar(20)))
end
go

insert into Employees values('naidu','kella','male',45000,3)
insert into Employees values('divya','sri','female',50000,2)

go

alter trigger tr_tblEmployee_Fordelete
on Employees
for delete
as
begin
     declare @ID int
	 select @ID=ID from deleted
	 insert into tblEmployeeAudit
	 values (
	      CAST(@ID as varchar(5))+
		' is deleted at ' +
		cast(getdate() as varchar(20)))

end
go
delete from Employees where ID=17

go

alter trigger tr_tblEmployee_ForUpdate
on Employees
for Update
as
Begin
      -- Declare variables to hold old and updated data
      Declare @Id int
      Declare @OldFirstName nvarchar(20), @NewFirstName nvarchar(20)
	  Declare @OldLastName nvarchar(20),@NewLastName nvarchar(20)
      Declare @OldSalary int, @NewSalary int
      Declare @OldGender nvarchar(20), @NewGender nvarchar(20)
      Declare @OldDeptId int, @NewDeptId int
     
      -- Variable to build the audit string
      Declare @AuditString nvarchar(1000)
      
      -- Load the updated records into temporary table
      Select *
      into #TempTable
      from inserted
     
      -- Loop thru the records in temp table
      While(Exists(Select Id from #TempTable))
      Begin
            --Initialize the audit string to empty string
            Set @AuditString = ''
           
            -- Select first row data from temp table
            Select Top 1 @Id = Id, @NewFirstName = FirstName, @NewLastName=LastName,
            @NewGender = Gender, @NewSalary = Salary,
            @NewDeptId = DepartmentId
            from #TempTable
           
            -- Select the corresponding row from deleted table
            Select @OldFirstName = FirstName,@OldLastName=LastName, @OldGender = Gender, 
            @OldSalary = Salary, @OldDeptId = DepartmentId
            from deleted where Id = @Id
   
     -- Build the audit string dynamically           
            Set @AuditString = 'Employee with Id = ' + Cast(@Id as nvarchar(4)) + ' changed'
            if(@OldFirstName <> @NewFirstName)
                  Set @AuditString = @AuditString + ' NAME from ' + @OldFirstName + ' to ' + @NewFirstName
             if(@OldLastName <> @NewLastName)
                  Set @AuditString = @AuditString + ' NAME from ' + @OldLastName + ' to ' + @NewLastName    
            if(@OldGender <> @NewGender)
                  Set @AuditString = @AuditString + ' GENDER from ' + @OldGender + ' to ' + @NewGender
                 
            if(@OldSalary <> @NewSalary)
                  Set @AuditString = @AuditString + ' SALARY from ' + Cast(@OldSalary as nvarchar(10))+ ' to ' + Cast(@NewSalary as nvarchar(10))
                  
     if(@OldDeptId <> @NewDeptId)
                  Set @AuditString = @AuditString + ' DepartmentId from ' + Cast(@OldDeptId as nvarchar(10))+ ' to ' + Cast(@NewDeptId as nvarchar(10))
           
            insert into tblEmployeeAudit values(@AuditString)
            
            -- Delete the row from temp table, so we can move to the next row
            Delete from #TempTable where Id = @Id
      End
End
go
update Employees set FirstName='moida',LastName='Bhavani',Salary=60000,DepartmentId=2,Gender='female'

-----  Instead of Insert Trigger 
go

create or alter view vEmployeeDetails
as
select n.ID,n.Gender,d.Name from New_Employee n
Inner join Departments d 
on n.DepartmentId=d.ID
go
select * from vEmployeeDetails

go

Insert into vEmployeeDetails values(7,'Female','IT') 
go

Create or alter trigger tr_vWEmployeeDetails_InsteadOfInsert
on vEmployeeDetails
Instead Of Insert
as
Begin
 Declare @DeptId int
 
 --Check if there is a valid DepartmentId
 --for the given DepartmentName
 Select @DeptId =d.ID
 from Departments d
 join inserted
 on inserted.Name = d.Name
 
 --If DepartmentId is null throw an error
 --and stop processing
 if(@DeptId is null)
 Begin
  Raiserror('Invalid Department Name. Statement terminated', 16, 1)
  return
 End
 
 --Finally insert into tblEmployee table
 Insert into New_Employee(Name, Gender, DepartmentId)
 Select  Name, Gender, @DeptId
 from inserted
End

