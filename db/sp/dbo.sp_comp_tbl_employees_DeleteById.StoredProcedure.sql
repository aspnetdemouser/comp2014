/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_DeleteById]    Script Date: 03/25/2014 22:41:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_comp_tbl_employees_DeleteById]    
       @id int,
       @update_by int
As    
Begin    
update tbl_employees set is_deleted=1,update_by=@update_by where id =@id
End
GO
