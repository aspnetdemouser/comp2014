/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_Update]    Script Date: 03/25/2014 22:41:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_comp_tbl_employees_Update]   
(  
  @id  INT = 0,   
  @position VARCHAR(100) = NULL,   
  @date_of_hire DATETIME = NULL,   
  @licence_number VARCHAR(100) = NULL,  
  @licence_expiry DATETIME = NULL,   
  @date_last_exclusion_check DATETIME = NULL,  
  @create_by INT = NULL,   
  @update_by INT = NULL ,
  @password varchar(100)
)  
AS  
BEGIN  
   

insert into tbl_employees
   (
	create_date,
	update_date,
	create_by,
	update_by,
	is_active_record,
	is_deleted,
	position,
	login_password,date_of_hire,
	licence_number,
	licence_expiry,
	date_last_exclusion_check,
	email_address,emp_type,facility_id)
	select
	create_date,
	update_date,
	create_by,
	update_by,
	0,
	is_deleted,
	position,
	login_password,date_of_hire,
	licence_number,
	licence_expiry,
	date_last_exclusion_check,
	email_address,emp_type,facility_id
	from tbl_employees where id = @id and 
	is_active_record = 1
   
   If ( @@RowCount > 0)
   Begin
	 UPDATE    
			dbo.tbl_employees  
		SET   
		  position = @position, 
		  [login_password] = @password  ,
		  date_of_hire = @date_of_hire,   
		  licence_number = @licence_number,  
		  licence_expiry = @licence_expiry,   
		  date_last_exclusion_check = @date_last_exclusion_check,  
		  update_by = @update_by,  
		  update_date = GETDATE()  
		 WHERE   
		  id=@id  
End
    
  select @id  
END
GO
