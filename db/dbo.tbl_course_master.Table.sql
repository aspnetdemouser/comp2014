
/****** Object:  Table [dbo].[tbl_course_master]    Script Date: 03/25/2014 22:35:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_course_master]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_course_master]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_course_master]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_course_master](
	[course_id] [int] IDENTITY(1,1) NOT NULL,
	[course_title] [varchar](max) NOT NULL,
	[create_by] [int] NULL,
	[update_by] [int] NULL,
	[create_date] [datetime] NULL,
	[update_date] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[is_active_record] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_course_master] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
