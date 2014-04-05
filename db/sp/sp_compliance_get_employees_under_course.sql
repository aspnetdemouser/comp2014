alter proc sp_compliance_get_employees_under_course          
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
where emp.id  in           
(select emp_id from tbl_training_assignments where course_id = @course_id  
and isnull(is_deleted,0) = 0 )          
and emp.emp_type = 1 -- only level 1 users        
and   isnull(emp.is_deleted,0) = 0
and cinfo.is_active_record = 1       
end          
-- end sp