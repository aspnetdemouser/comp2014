/****** Object:  StoredProcedure [dbo].[sp_contact_Information_Insert]    Script Date: 03/25/2014 22:41:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_contact_Information_Insert]
    @emp_id INT ,
    @first_name VARCHAR(100) = NULL ,
    @last_name VARCHAR(100) = NULL ,
    @address_line VARCHAR(300) = NULL ,
    @city_name VARCHAR(50) = NULL ,
    @state_name VARCHAR(50) = NULL ,
    @zip_code VARCHAR(10) = NULL ,
    @tele_phone VARCHAR(50) = NULL ,
    @fax_number VARCHAR(50) = NULL ,
    @is_active_record BIT = NULL ,
    @create_date DATETIME = NULL ,
    @create_by INT = 0
 AS 
    BEGIN
        INSERT  INTO dbo.tbl_contact_info
                ( emp_id ,
                  first_name ,
                  last_name ,
                  address_line ,
                  city_name ,
                  state_name ,
                  zip_code ,
                  tele_phone ,
                  fax_number ,
                  is_active_record ,
                  create_date ,
                  create_by 
         
                )
        VALUES  ( @emp_id , -- emp_id - int
                  @first_name , -- first_name - varchar(100)
                  @last_name , -- last_name - varchar(100)
                  @address_line , -- address_line - varchar(300)
                  @city_name , -- city_name - varchar(50)
                  @state_name , -- state_name - varchar(50)
                  @zip_code , -- zip_code - varchar(10)
                  @tele_phone , -- tele_phone - varchar(50)
                  @fax_number , -- fax_number - varchar(50)
                  @is_active_record , -- is_active_record - bit
                  GETDATE() , -- create_date - datetime
                  @create_by  -- create_by - int
       
                )
                
        SELECT  @@IDENTITY AS id
    END
GO
