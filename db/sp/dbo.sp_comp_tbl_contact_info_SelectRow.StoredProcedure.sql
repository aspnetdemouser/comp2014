  
alter Procedure [dbo].[sp_comp_tbl_contact_info_SelectRow]    
 @email_address varchar(500)    
As    
Begin    
 Select     
  c.[id],    
  c.[emp_id],    
  c.[first_name],    
  c.[last_name],    
  c.[address_line1],    
  c.[address_line2],    
  c.[city_name],    
  c.[state_name],    
  c.[zip_code],    
  c.[tele_phone],    
  c.[fax_number],    
  c.[is_active_record],    
  c.[create_date],    
  c.[update_date],    
  c.[create_by],    
  c.[update_by],  
  c.[country_name]   
 From tbl_contact_info c    
 inner Join tbl_employees e on c.emp_id = e.id    
  Where    
     e.email_address = @email_address  
     and c.is_active_record = 1  
END  