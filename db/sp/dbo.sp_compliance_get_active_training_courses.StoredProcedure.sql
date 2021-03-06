/****** Object:  StoredProcedure [dbo].[sp_compliance_get_active_training_courses]    Script Date: 03/25/2014 22:41:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_compliance_get_active_training_courses]
as
begin

select course_id,
course_title,
create_by,
update_by,
create_date,
update_date,
is_deleted,
is_active_record from 
tbl_course_master
order by course_title
end
GO
