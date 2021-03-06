/****** Object:  StoredProcedure [dbo].[sp_compliance_get_training_users_to_assign_to_course]    Script Date: 03/25/2014 22:41:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_compliance_get_training_users_to_assign_to_course]
@course_id int,
@facility_id int = null
as
begin

declare @course_name varchar(100)
select @course_name = course_title from tbl_course_master where course_id = @course_id
and isnull(is_active_record,0) = 1 
and isnull(is_deleted,0) = 0

select emp.id as employeeid,
emp.email_address,
emp.facility_id,
cinfo.first_name firstname,
cinfo.last_name lastname,
@course_name as course_name,
@course_id as course_id
 from tbl_employees emp inner join
tbl_contact_info cinfo on cinfo.emp_id = emp.id
where emp.id not in 
(select emp_id from tbl_training_assignments where course_id = @course_id)

end
-- end sp
GO
