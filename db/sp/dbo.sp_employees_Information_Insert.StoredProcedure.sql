/****** Object:  StoredProcedure [dbo].[sp_employees_Information_Insert]    Script Date: 03/25/2014 22:41:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_employees_Information_Insert]
    @email_address VARCHAR(500) ,
    @login_password VARCHAR(100) ,
    @emp_type INT = 0 ,
    @facility_id INT = 0 ,
    @position VARCHAR(100) = NULL ,
    @date_of_hire DATETIME = NULL ,
    @licence_number VARCHAR(100) = NULL ,
    @licence_expiry DATETIME = NULL ,
    @date_last_exclusion_check DATETIME = NULL ,
    @is_deleted BIT = NULL ,
    @is_active_record BIT = NULL ,
    @create_by INT = 0
AS 
    BEGIN



        IF EXISTS ( SELECT  *
                    FROM    tbl_employees e
                    WHERE   LTRIM(RTRIM(e.email_address)) = LTRIM(RTRIM(@email_address)) ) 
            BEGIN
                SELECT  -1
            END
        ELSE 
            BEGIN
                INSERT  INTO dbo.tbl_employees
                        ( email_address ,
                          login_password ,
                          emp_type ,
                          facility_id ,
                          position ,
                          date_of_hire ,
                          licence_number ,
                          licence_expiry ,
                          date_last_exclusion_check ,
                          is_deleted ,
                          is_active_record ,
                          create_date ,
                          create_by 
                        
                        
                        )
                VALUES  ( @email_address ,
                          @login_password ,
                          @emp_type ,
                          @facility_id ,
                          @position ,
                          @date_of_hire ,
                          @licence_number ,
                          @licence_expiry ,
                          @date_last_exclusion_check ,
                          @is_deleted ,
                          @is_active_record ,
                          GETDATE() ,
                          0 
                        
                        )
                SELECT  SCOPE_IDENTITY() 

            END
        
    END
GO
