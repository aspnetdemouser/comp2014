/****** Object:  StoredProcedure [dbo].[sp_comp_get_training_assigments_to_manage]    Script Date: 03/30/2014 16:05:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_get_training_assigments_to_manage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_get_training_assigments_to_manage]
GO

/****** Object:  StoredProcedure [dbo].[sp_comp_get_training_assigments_to_manage]    Script Date: 03/30/2014 16:05:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_comp_get_training_assigments_to_manage]
@created_by int = 0
as
begin

select emp.email_address,
emp.id as emp_id,
cinfo.first_name as firstname,
cinfo.last_name as lastname,
isnull(cinfo.first_name,'')
+ ' ' + isnull(cinfo.last_name,'') as emp_name,
ta.id as ta_id,

cm.course_title,
ta.completion_status,
ta.date_assigned,
ta.due_date,
ta.course_id,
emp.emp_type

from tbl_training_assignments ta
inner join tbl_employees emp on ta.emp_id = emp.id
left outer join tbl_contact_info cinfo on cinfo.emp_id = emp.id
inner join tbl_course_master cm on cm.course_id = ta.course_id
where emp.is_active_record = 1
and isnull(emp.is_deleted,0) = 0
and cinfo.is_active_record =1
and  emp.emp_type = 1 -- level 1 emp
order by   ta.date_assigned
end
GO


