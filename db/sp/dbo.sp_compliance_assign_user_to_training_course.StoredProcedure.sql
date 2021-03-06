/****** Object:  StoredProcedure [dbo].[sp_compliance_assign_user_to_training_course]    Script Date: 03/25/2014 22:41:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_compliance_assign_user_to_training_course]
@id int = null,
@course_id int,
@employee_id int,
@user_by int,
@status_id int = null,
@due_date datetime = null
as
begin

declare @cnt int

select @cnt = count(1) from tbl_training_assignments
where course_id = @course_id and emp_id = @employee_id

if (@cnt = 0)
begin
insert into tbl_training_assignments
( course_id,emp_id,date_assigned,due_date,completion_status,created_by,create_date)
values
(@course_id,@employee_id,getdate(), null, isnull(@status_id,1) , @user_by , getdate())

end
else
begin
update tbl_training_assignments
set completion_status = isnull(@status_id,1),
due_date = @due_date
where emp_id = @employee_id and course_id = @course_id
and id = @id

end

end
-- end sp
GO
