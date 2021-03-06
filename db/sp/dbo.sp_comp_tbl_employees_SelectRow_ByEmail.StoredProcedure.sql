/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_SelectRow_ByEmail]    Script Date: 03/25/2014 22:41:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_comp_tbl_employees_SelectRow_ByEmail]    
 @email_address varchar(500),    
 @login_password varchar(100)    
As    
Begin    
 Select     
  e.[id],    
  [email_address],    
  [login_password],    
  [emp_type],    
  e.facility_id,  
  f.[facility_name],    
  [position],    
  [date_of_hire],    
  [licence_number],    
  [licence_expiry],    
  [date_last_exclusion_check],    
  [is_deleted],    
  [is_active_record],    
  [create_date],    
  [update_date],    
  [create_by],    
  [update_by]    
 From tbl_employees  e  
 left outer join tbl_facility f  
 on e.facility_id = f.id   
 Where    
  [email_address] = @email_address    
  AND [login_password] = @login_password    
  AND [is_active_record] = 1 
  AND isnull(e.[is_deleted],0) = 0
     
End
GO
