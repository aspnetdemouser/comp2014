     
alter Procedure [dbo].[sp_comp_tbl_employees_GetAll]      
@facility_id int = null,  
@lastname varchar(50) = null,
@is_active_only bit = 1
As      
Begin      
declare @sql varchar(max)  
  
set @sql = '  
 Select       
  e.[id],      
  e.[email_address],      
  e.[login_password],      
  e.[emp_type],      
  e.facility_id,    
  f.[facility_name],      
  e.[position],      
  e.[date_of_hire],      
  e.[licence_number],      
  e.[licence_expiry],      
  e.[date_last_exclusion_check],      
  isnull(e.[is_deleted],0) is_deleted,    
  e.[is_active_record],      
 e.[create_date],      
  e.[update_date],      
  e.[create_by],    
  e.[employee_type_text],  
 e.[update_by],  
 isnull(c.first_name,'''') + '' '' + isnull(c.last_name,'''') as [name]  
 From tbl_employees  e    
 inner join tbl_contact_info c on c.emp_id = e.id  
  left outer join tbl_facility f  on e.facility_id = f.id     
    
 Where      
  e.[is_active_record] = 1      
  AND c.[is_active_record] = 1  
  AND e.[emp_type] = 1 '  
  
  
   
 if ISNULL(@lastname,'') <>''                                          
   begin                                                          
		set @sql = @sql +  ' and c.last_name like ''%' + @lastname + '%'''  
   end  
   
if isnull(@is_active_only,0) = 1 
begin   
		set @sql = @sql +  ' AND isnull(e.[is_deleted],0) = 0 '
end
     
   set @sql = @sql + ' Order by c.first_name '  
      
    exec (@sql)                                                          
   
   
End      
      