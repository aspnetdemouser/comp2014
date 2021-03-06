
/****** Object:  Table [dbo].[tbl_employees]    Script Date: 03/25/2014 22:35:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_employees]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_employees]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_employees]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_employees](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email_address] [varchar](500) NOT NULL,
	[login_password] [varchar](100) NOT NULL,
	[emp_type] [int] NULL,
	[position] [varchar](100) NULL,
	[facility_id] [int] NULL,
	[date_of_hire] [datetime] NULL,
	[licence_number] [varchar](100) NULL,
	[licence_expiry] [datetime] NULL,
	[date_last_exclusion_check] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_active_record] [bit] NULL,
	[create_date] [datetime] NULL,
	[update_date] [datetime] NULL,
	[create_by] [int] NULL,
	[update_by] [int] NULL,
 CONSTRAINT [PK__tbl_empl__3213E83F0AD2A005] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
