USE [HumanResources]

CREATE TABLE [dbo].[employeecompositekey](
	[employee_num] [int] NOT NULL,
	[first_name] [varchar](255) NULL,
	[desk_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[employee_num],
	[desk_id]
))

INSERT INTO [dbo].[employeecompositekey]
SELECT employee_info.employee_num, first_name, desk_id
FROM employeeinfo AS employee_info
JOIN deskhistory AS desk_history ON desk_history.employee_num = employee_info.employee_num