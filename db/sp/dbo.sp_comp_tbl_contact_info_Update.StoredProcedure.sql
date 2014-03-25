/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_contact_info_Update]    Script Date: 03/25/2014 22:41:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/************************************************************* 
** File:   [sp_comp_tbl_contact_info_Update]
** Author: Kalpesh Gadhia.
** Description:  Creates a stored procedure that updates a record in tbl_contact_info datatable.
** Purpose: to update new record in tbl_contact_info datatable.
** Date: 03/20/2014

************************************************************** 
** Change History 
************************************************************************************************************************* 
** PR   Date        Author					Change Description  
** --   ----------  ------------------		--------------------------------
** 01   03/20/2014  Kalpesh Gadhia          Newly Created
************************************************************************************************************************/
CREATE PROCEDURE [dbo].[sp_comp_tbl_contact_info_Update] 
(
	 @id  INT = 0, 
	 @emp_id INT = 0, 
	 @first_name VARCHAR(100) = NULL, 
	 @last_name VARCHAR(100) = NULL, 
	 @address_line VARCHAR(300) = NULL, 
	 @city_name VARCHAR(50) = NULL, 
	 @country_name VARCHAR(50) = NULL, 
	 @state_name VARCHAR(50) = NULL, 
	 @zip_code VARCHAR(10) = NULL, 
	 @tele_phone VARCHAR(50) = NULL, 
	 @fax_number VARCHAR(50) = NULL, 
	 @update_by INT = NULL
	 
)
AS
BEGIN
	
	UPDATE  
		dbo.tbl_contact_info
	SET 
		emp_id = @emp_id, 
		first_name = @first_name, 
		last_name = @last_name, 
		address_line = @address_line, 
		city_name = @city_name, 
		country_name = @country_name, 
		state_name = @state_name, 
		zip_code = @zip_code, 
		tele_phone = @tele_phone, 
		fax_number = @fax_number, 
		update_by = @update_by,
		update_date = GETDATE()
	WHERE 
		id=@id
		
		select @id
END
GO
