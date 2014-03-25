
/****** Object:  Table [dbo].[tbl_emp_types]    Script Date: 03/25/2014 22:35:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_emp_types]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_emp_types]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_emp_types]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_emp_types](
	[emp_type_id] [int] NOT NULL,
	[emp_type_name] [varchar](50) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
