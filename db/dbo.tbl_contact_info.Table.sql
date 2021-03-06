
/****** Object:  Table [dbo].[tbl_contact_info]    Script Date: 03/25/2014 22:35:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_contact_info]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_contact_info]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_contact_info]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_contact_info](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[emp_id] [int] NULL,
	[first_name] [varchar](100) NULL,
	[last_name] [varchar](100) NULL,
	[address_line] [varchar](300) NULL,
	[city_name] [varchar](50) NULL,
	[country_name] [varchar](50) NULL,
	[state_name] [varchar](50) NULL,
	[zip_code] [varchar](10) NULL,
	[tele_phone] [varchar](50) NULL,
	[fax_number] [varchar](50) NULL,
	[is_active_record] [bit] NULL,
	[create_date] [datetime] NULL,
	[update_date] [datetime] NULL,
	[create_by] [int] NULL,
	[update_by] [int] NULL,
 CONSTRAINT [PK__tbl_cont__3213E83F0F975522] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
