/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_DeleteByIds]    Script Date: 03/25/2014 22:41:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_comp_tbl_employees_DeleteByIds]    
       @id varchar(1000),
       @update_by varchar(10)
As    
Begin    
declare @que as varchar(2000)
set @que = 'update tbl_employees set is_deleted=1,update_by=' + @update_by + ' where id in (' + @id + ')'
exec (@que)
End
GO
