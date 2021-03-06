  
alter PROCEDURE [dbo].[sp_comp_tbl_employees_GetByid] @id INT = 0  
AS   
    BEGIN      
        SELECT  e.[id] ,  
                e.[email_address] ,  
                e.[login_password] ,  
                e.[emp_type] ,  
                e.facility_id ,  
                f.[facility_name] ,  
                e.[position] ,  
                e.[date_of_hire] ,  
                e.[licence_number] ,  
                e.[licence_expiry] ,  
                e.[date_last_exclusion_check] ,  
                ISNULL(e.[is_deleted], 0) is_deleted ,  
                e.[is_active_record] ,  
                e.[create_date] ,  
                e.[update_date] ,  
                e.[create_by] ,  
                e.[update_by] ,  
                e.[employee_type_text],                  
                ISNULL(c.first_name, '') + ' ' + ISNULL(c.last_name, '') AS [name]  
        FROM    tbl_employees e  
                INNER JOIN tbl_contact_info c ON c.emp_id = e.id  
                LEFT OUTER JOIN tbl_facility f ON e.facility_id = f.id  
        WHERE   e.[is_active_record] = 1  
                AND c.[is_active_record] = 1  
                --AND ISNULL(e.[is_deleted], 0) = 0  
                AND e.[emp_type] = 1 -- level 1 employee   
                AND e.[id] = @id   
    END  