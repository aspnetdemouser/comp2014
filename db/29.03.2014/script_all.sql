
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_GetByid]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_employees_GetByid]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_tbl_employees_GetByid]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_SelectRow_ByEmail]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_employees_SelectRow_ByEmail]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_tbl_employees_SelectRow_ByEmail]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_Update]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_employees_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_tbl_employees_Update]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_incident_department_insert]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_incident_department_insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_tbl_incident_department_insert]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_incident_insert]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_incident_insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_tbl_incident_insert]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_incident_person_insert]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_incident_person_insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_tbl_incident_person_insert]
GO
/****** Object:  StoredProcedure [dbo].[sp_compliance_assign_user_to_training_course]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_compliance_assign_user_to_training_course]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_compliance_assign_user_to_training_course]
GO
/****** Object:  StoredProcedure [dbo].[sp_compliance_get_active_training_courses]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_compliance_get_active_training_courses]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_compliance_get_active_training_courses]
GO
/****** Object:  StoredProcedure [dbo].[sp_compliance_get_training_users_to_assign_to_course]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_compliance_get_training_users_to_assign_to_course]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_compliance_get_training_users_to_assign_to_course]
GO
/****** Object:  StoredProcedure [dbo].[sp_contact_Information_Insert]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_contact_Information_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_contact_Information_Insert]
GO
/****** Object:  StoredProcedure [dbo].[sp_employees_Information_Insert]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_employees_Information_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_employees_Information_Insert]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_contact_info_SelectRow]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_contact_info_SelectRow]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_tbl_contact_info_SelectRow]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_contact_info_Update]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_contact_info_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_tbl_contact_info_Update]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_department]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_department]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_tbl_department]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_DeleteById]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_employees_DeleteById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_tbl_employees_DeleteById]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_DeleteByIds]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_employees_DeleteByIds]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_tbl_employees_DeleteByIds]
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_GetAll]    Script Date: 03/29/2014 17:27:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_employees_GetAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_comp_tbl_employees_GetAll]
GO
/****** Object:  Table [dbo].[tbl_contact_info]    Script Date: 03/29/2014 17:27:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_contact_info]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_contact_info]
GO
/****** Object:  Table [dbo].[tbl_course_master]    Script Date: 03/29/2014 17:27:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_course_master]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_course_master]
GO
/****** Object:  Table [dbo].[tbl_emp_types]    Script Date: 03/29/2014 17:27:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_emp_types]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_emp_types]
GO
/****** Object:  Table [dbo].[tbl_employees]    Script Date: 03/29/2014 17:27:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_employees]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_employees]
GO
/****** Object:  Table [dbo].[tbl_facility]    Script Date: 03/29/2014 17:27:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_facility]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_facility]
GO
/****** Object:  Table [dbo].[tbl_training_assignments]    Script Date: 03/29/2014 17:27:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_training_assignments]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_training_assignments]
GO
/****** Object:  Table [dbo].[tbl_training_assignments]    Script Date: 03/29/2014 17:27:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_training_assignments]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_training_assignments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[course_id] [int] NOT NULL,
	[emp_id] [int] NOT NULL,
	[date_assigned] [datetime] NOT NULL,
	[due_date] [datetime] NULL,
	[completion_status] [int] NULL,
	[created_by] [int] NULL,
	[update_by] [int] NULL,
	[create_date] [datetime] NULL,
	[update_date] [datetime] NULL,
	[is_deleted] [bit] NULL,
 CONSTRAINT [PK__tbl_trai__3213E83F2B3F6F97] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[tbl_training_assignments] ON
INSERT [dbo].[tbl_training_assignments] ([id], [course_id], [emp_id], [date_assigned], [due_date], [completion_status], [created_by], [update_by], [create_date], [update_date], [is_deleted]) VALUES (1, 1, 1, CAST(0x0000A2FD002BF640 AS DateTime), NULL, 1, 1, NULL, CAST(0x0000A2FD002BF640 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_training_assignments] OFF
/****** Object:  Table [dbo].[tbl_facility]    Script Date: 03/29/2014 17:27:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_facility]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbl_facility](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[facility_name] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_facility] ON
INSERT [dbo].[tbl_facility] ([id], [facility_name]) VALUES (1, N'SAL Hospital')
INSERT [dbo].[tbl_facility] ([id], [facility_name]) VALUES (2, N'Medi Link Hospital')
SET IDENTITY_INSERT [dbo].[tbl_facility] OFF
/****** Object:  Table [dbo].[tbl_employees]    Script Date: 03/29/2014 17:27:46 ******/
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
	[employee_type_text] [varchar](50) NULL,
 CONSTRAINT [PK__tbl_empl__3213E83F0AD2A005] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_employees] ON
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (1, N'admin@admin.com', N'111111', 2, N'doctor', 1, CAST(0x0000A17D00000000 AS DateTime), N'343774444', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A2E100000000 AS DateTime), 0, 1, NULL, CAST(0x0000A2F80169531F AS DateTime), NULL, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (2, N'test1@test1.com', N'111111', 1, N'Nurse', 1, CAST(0x0000A30800000000 AS DateTime), N'654755W', CAST(0x0000A2C800000000 AS DateTime), CAST(0x0000A53200000000 AS DateTime), 0, 0, NULL, CAST(0x0000A2FB01822210 AS DateTime), NULL, 0, N'')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (3, N'test2@test2.com', N'123456', 1, N'Doctor', 2, CAST(0x0000A22600000000 AS DateTime), N'T8923SE', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A40B00000000 AS DateTime), 0, 0, NULL, CAST(0x0000A2FB0183DA40 AS DateTime), NULL, 0, N'')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (4, N'test3@test3.com', N'123456', 1, N'Nurse', 1, CAST(0x00009EEE00000000 AS DateTime), N'N23242', CAST(0x0000A48800000000 AS DateTime), NULL, 1, 1, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (5, N'test@you.com', N'123456', 1, N'', 1, NULL, N'POOWER', NULL, NULL, 1, 1, CAST(0x0000A2F50014FDE9 AS DateTime), CAST(0x0000A2F600290317 AS DateTime), 0, 1, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (6, N'rajeshpatel@example.com', N'111111', 1, N'Nurse', 1, CAST(0x00009EDE00000000 AS DateTime), N'wew3ssd', CAST(0x0000A41100000000 AS DateTime), CAST(0x0000A25A00000000 AS DateTime), 0, 1, CAST(0x0000A2F50017C6A6 AS DateTime), CAST(0x0000A2FD0029A5DC AS DateTime), 0, 0, N'')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (7, N'test11@test1.com', N'', 1, N'doctor', 1, CAST(0x0000A2A600000000 AS DateTime), N'sfsd', CAST(0x0000A2A600000000 AS DateTime), CAST(0x0000A2A600000000 AS DateTime), 1, 1, CAST(0x0000A2F5001B1664 AS DateTime), CAST(0x0000A2F5001B8AC0 AS DateTime), 0, 1, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (8, N'gssfssasf@easdfa.com', N'123456', 1, N'Nurse', 1, CAST(0x0000A4CC00000000 AS DateTime), N'aaa', CAST(0x0000A21700000000 AS DateTime), CAST(0x0000A21700000000 AS DateTime), 1, 1, CAST(0x0000A2F5001CA11A AS DateTime), NULL, 0, 1, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (9, N'', N'', 1, N'', 1, NULL, N'', NULL, NULL, 1, 1, CAST(0x0000A2F6002958C2 AS DateTime), NULL, 0, 1, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (10, N'test09@example.com', N'123456', 1, N'nurse', 1, CAST(0x0000A2C100000000 AS DateTime), N'JKWEe', CAST(0x0000A37900000000 AS DateTime), CAST(0x0000A2D700000000 AS DateTime), 0, 1, CAST(0x0000A2F6003F2F66 AS DateTime), CAST(0x0000A2FA018AB134 AS DateTime), 0, 0, N'Doctor')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (11, N'test@test.com', N'111111', 1, N'DocTor', 1, NULL, N'MMM343', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A2FD00000000 AS DateTime), 1, 1, CAST(0x0000A2F600401C61 AS DateTime), CAST(0x0000A2F60040E143 AS DateTime), 0, 1, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (12, N'asdasfasf@asdfas.com', N'123456', 1, N'Sr. Doctor', 1, CAST(0x0000A0A300000000 AS DateTime), N'KMMWE3', CAST(0x0000A2EA00000000 AS DateTime), CAST(0x0000A33C00000000 AS DateTime), 1, 1, CAST(0x0000A2F600467097 AS DateTime), CAST(0x0000A2FA0003C69C AS DateTime), 0, 1, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (13, N'asfdsaf@ass.com', N'123456', 1, N'doctor', 1, CAST(0x0000A29600000000 AS DateTime), N'wwww', CAST(0x0000A2E400000000 AS DateTime), CAST(0x0000A2FB00000000 AS DateTime), 1, 1, CAST(0x0000A2F60170FDCC AS DateTime), NULL, 0, 1, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (14, N'sfsfs@asd.com', N'112A', 1, N'sfdsf', 1, CAST(0x0000A2E300000000 AS DateTime), N'sfs', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A2F200000000 AS DateTime), 1, 1, CAST(0x0000A2F60187A03D AS DateTime), NULL, 0, 1, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (15, N'admin@admin.com', N'111111', 2, N'Admin1', 1, CAST(0x0000A1B200000000 AS DateTime), N'343774444', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A2E100000000 AS DateTime), 0, 0, NULL, CAST(0x0000A2F6010151E8 AS DateTime), NULL, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (16, N'asdasfasf@asdfas.com', N'111111', 1, N'Doctor', 1, CAST(0x0000A22D00000000 AS DateTime), N'lic number 99', CAST(0x0000A2EA00000000 AS DateTime), CAST(0x0000A33C00000000 AS DateTime), 0, 0, CAST(0x0000A2F600467097 AS DateTime), CAST(0x0000A2F7001ADCBB AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (17, N'asdasfasf@asdfas.com', N'123456', 1, N'Sr. Doctor', 1, CAST(0x0000A0A300000000 AS DateTime), N'KMMWE3', CAST(0x0000A2EA00000000 AS DateTime), CAST(0x0000A33C00000000 AS DateTime), 0, 0, CAST(0x0000A2F600467097 AS DateTime), CAST(0x0000A2F801699705 AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (18, N'asdasfasf@asdfas.com', N'123456', 1, N'Sr. Doctor', 1, CAST(0x0000A0A300000000 AS DateTime), N'KMMWE3', CAST(0x0000A2EA00000000 AS DateTime), CAST(0x0000A33C00000000 AS DateTime), 0, 0, CAST(0x0000A2F600467097 AS DateTime), CAST(0x0000A2F80169AB1B AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (19, N'test2@test2.com', N'123456', 1, N'Doctor', 2, CAST(0x0000A21100000000 AS DateTime), N'T8923SE', CAST(0x0000A2EB00000000 AS DateTime), CAST(0x0000A41200000000 AS DateTime), 0, 0, NULL, CAST(0x0000A2F600592EAB AS DateTime), NULL, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (20, N'asdasfasf@asdfas.com', N'123456', 1, N'Sr. Doctor', 1, CAST(0x0000A0A300000000 AS DateTime), N'KMMWE3', CAST(0x0000A2EA00000000 AS DateTime), CAST(0x0000A33C00000000 AS DateTime), 0, 0, CAST(0x0000A2F600467097 AS DateTime), CAST(0x0000A2F8016BD9E3 AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (21, N'asdasfasf@asdfas.com', N'123456', 1, N'Sr. Doctor', 1, CAST(0x0000A0A300000000 AS DateTime), N'KMMWE3', CAST(0x0000A2EA00000000 AS DateTime), CAST(0x0000A33C00000000 AS DateTime), 0, 0, CAST(0x0000A2F600467097 AS DateTime), CAST(0x0000A2FA0003078C AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (22, N'asdasfasf@asdfas.com', N'123456', 1, N'Sr. Doctor', 1, CAST(0x0000A0A300000000 AS DateTime), N'KMMWE3', CAST(0x0000A2EA00000000 AS DateTime), CAST(0x0000A33C00000000 AS DateTime), 0, 0, CAST(0x0000A2F600467097 AS DateTime), CAST(0x0000A2FA00030DA2 AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (23, N'asdasfasf@asdfas.com', N'123456', 1, N'Sr. Doctor', 1, CAST(0x0000A0A300000000 AS DateTime), N'KMMWE3', CAST(0x0000A2EA00000000 AS DateTime), CAST(0x0000A33C00000000 AS DateTime), 0, 0, CAST(0x0000A2F600467097 AS DateTime), CAST(0x0000A2FA0003122E AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (24, N'asdasfasf@asdfas.com', N'123456', 1, N'Sr. Doctor', 1, CAST(0x0000A0A300000000 AS DateTime), N'KMMWE3', CAST(0x0000A2EA00000000 AS DateTime), CAST(0x0000A33C00000000 AS DateTime), 0, 0, CAST(0x0000A2F600467097 AS DateTime), CAST(0x0000A2FA000322FF AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (25, N'asdasfasf@asdfas.com', N'123456', 1, N'Sr. Doctor', 1, CAST(0x0000A0A300000000 AS DateTime), N'KMMWE3', CAST(0x0000A2EA00000000 AS DateTime), CAST(0x0000A33C00000000 AS DateTime), 0, 0, CAST(0x0000A2F600467097 AS DateTime), CAST(0x0000A2FA0003A02F AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (26, N'asdasfasf@asdfas.com', N'123456', 1, N'Sr. Doctor', 1, CAST(0x0000A0A300000000 AS DateTime), N'KMMWE3', CAST(0x0000A2EA00000000 AS DateTime), CAST(0x0000A33C00000000 AS DateTime), 0, 0, CAST(0x0000A2F600467097 AS DateTime), CAST(0x0000A2FA0003BF64 AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (27, N'asdasfas@asd.com', N'111111', 1, N'asdfs', 1, CAST(0x0000A2E900000000 AS DateTime), N'sfsfs', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A2D700000000 AS DateTime), 1, 1, CAST(0x0000A2FA0004EFC6 AS DateTime), NULL, 0, 1, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (28, N'sfsasasf@asdf.com', N'111111', 1, N'asdfasfas', 1, CAST(0x0000A2E200000000 AS DateTime), N'asdfasasd', CAST(0x0000A35700000000 AS DateTime), CAST(0x0000A31600000000 AS DateTime), 1, 1, CAST(0x0000A2FA000C77D0 AS DateTime), CAST(0x0000A2FA000C91AD AS DateTime), 0, 1, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (29, N'sfsasasf@asdf.com', N'111111', 1, N'asdfasfas', 1, CAST(0x0000A2E200000000 AS DateTime), N'asdfasasd', CAST(0x0000A35700000000 AS DateTime), CAST(0x0000A31600000000 AS DateTime), 0, 0, CAST(0x0000A2FA000C77D0 AS DateTime), NULL, 0, NULL, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (30, N'test09@example.com', N'123456', 1, N'nurse', 1, CAST(0x0000A2B400000000 AS DateTime), N'JKWEe', CAST(0x0000A37900000000 AS DateTime), CAST(0x0000A2D700000000 AS DateTime), 0, 0, CAST(0x0000A2F6003F2F66 AS DateTime), NULL, 0, NULL, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (31, N'test1@test1.com', N'123456', 1, N'Nurse', 1, CAST(0x0000A30800000000 AS DateTime), N'654755W', CAST(0x0000A2C800000000 AS DateTime), CAST(0x0000A53200000000 AS DateTime), 0, 0, NULL, CAST(0x0000A2F6004E42B7 AS DateTime), NULL, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (32, N'test1@test1.com', N'111111', 1, N'Nurse', 1, CAST(0x0000A30800000000 AS DateTime), N'654755W', CAST(0x0000A2C800000000 AS DateTime), CAST(0x0000A53200000000 AS DateTime), 0, 0, NULL, CAST(0x0000A2FA018B6974 AS DateTime), NULL, 0, N'')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (33, N'test1@test1.com', N'111111', 1, N'Nurse', 1, CAST(0x0000A30800000000 AS DateTime), N'654755W', CAST(0x0000A2C800000000 AS DateTime), CAST(0x0000A53200000000 AS DateTime), 0, 0, NULL, CAST(0x0000A2FA018B7A20 AS DateTime), NULL, 0, N'')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (34, N'sss@aa.com', N'111111', 1, N'sdfsfs', 1, CAST(0x0000A2F000000000 AS DateTime), N'asd', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A2F300000000 AS DateTime), 0, 1, CAST(0x0000A2FB000614B1 AS DateTime), CAST(0x0000A2FB0006237E AS DateTime), 0, 0, N'')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (35, N'sss@aa.com', N'111111', 1, N'sdfsfs', 1, CAST(0x0000A2F000000000 AS DateTime), N'asd', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A2F300000000 AS DateTime), 0, 0, CAST(0x0000A2FB000614B1 AS DateTime), NULL, 0, NULL, N'')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (36, N'sss@aa.com', N'111111', 1, N'sdfsfs', 1, CAST(0x0000A2F000000000 AS DateTime), N'asd', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A2F300000000 AS DateTime), 0, 0, CAST(0x0000A2FB000614B1 AS DateTime), CAST(0x0000A2FB00061F50 AS DateTime), 0, 0, N'')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (37, N'kkk@kkk.com', N'111111', 1, N'doctor', 1, CAST(0x0000A2E200000000 AS DateTime), N'test', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A2F100000000 AS DateTime), 0, 0, CAST(0x0000A2FB017F5575 AS DateTime), CAST(0x0000A2FB01822C8B AS DateTime), 0, 0, N'doc type')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (38, N'kkk@kkk.com', N'111111', 1, N'doctor', 1, CAST(0x0000A2E200000000 AS DateTime), N'test', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A2F100000000 AS DateTime), 0, 0, CAST(0x0000A2FB017F5575 AS DateTime), NULL, 0, NULL, N'doc type')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (39, N'test1@test1.com', N'111111', 1, N'Nurse', 1, CAST(0x0000A30800000000 AS DateTime), N'654755W', CAST(0x0000A2C800000000 AS DateTime), CAST(0x0000A53200000000 AS DateTime), 0, 0, NULL, CAST(0x0000A2FB0002D192 AS DateTime), NULL, 0, N'')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (40, N'kkk@kkk.com', N'111111', 1, N'doctor', 1, CAST(0x0000A2E200000000 AS DateTime), N'test', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A2F100000000 AS DateTime), 0, 0, CAST(0x0000A2FB017F5575 AS DateTime), CAST(0x0000A2FB017F5F66 AS DateTime), 0, 0, N'doc type')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (41, N'ttt@aa.com', N'111111', 1, N'asdfas', 1, CAST(0x0000A2E900000000 AS DateTime), N'asdfas', CAST(0x0000A2FA00000000 AS DateTime), CAST(0x0000A2FF00000000 AS DateTime), 0, 1, CAST(0x0000A2FB018252A6 AS DateTime), CAST(0x0000A2FC0002415C AS DateTime), 0, 0, N'sd')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (42, N'ttt@aa.com', N'123123', 1, N'asdfas', 1, CAST(0x0000A2E900000000 AS DateTime), N'asdfas', CAST(0x0000A2E900000000 AS DateTime), CAST(0x0000A2FF00000000 AS DateTime), 0, 0, CAST(0x0000A2FB018252A6 AS DateTime), NULL, 0, NULL, N'sd')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (43, N'ttt@aa.com', N'123123', 1, N'asdfas', 1, CAST(0x0000A2E900000000 AS DateTime), N'asdfas', CAST(0x0000A2E900000000 AS DateTime), CAST(0x0000A2FF00000000 AS DateTime), 0, 0, CAST(0x0000A2FB018252A6 AS DateTime), CAST(0x0000A2FB01825B1B AS DateTime), 0, 0, N'sd')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (44, N'ttt@aa.com', N'123123', 1, N'asdfas', 1, CAST(0x0000A2E900000000 AS DateTime), N'asdfas', CAST(0x0000A2FA00000000 AS DateTime), CAST(0x0000A2FF00000000 AS DateTime), 0, 0, CAST(0x0000A2FB018252A6 AS DateTime), CAST(0x0000A2FB01829C51 AS DateTime), 0, 0, N'sd')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (45, N'test2@test2.com', N'123456', 1, N'Doctor', 2, CAST(0x0000A21100000000 AS DateTime), N'T8923SE', CAST(0x0000A2EB00000000 AS DateTime), CAST(0x0000A41200000000 AS DateTime), 0, 0, NULL, CAST(0x0000A2F90170D475 AS DateTime), NULL, 0, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (46, N'test2@test2.com', N'123456', 1, N'Doctor', 2, CAST(0x0000A21800000000 AS DateTime), N'T8923SE', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A40B00000000 AS DateTime), 0, 0, NULL, CAST(0x0000A2FB0183BE23 AS DateTime), NULL, 0, N'')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (47, N'test2@test2.com', N'123456', 1, N'Doctor', 2, CAST(0x0000A22600000000 AS DateTime), N'T8923SE', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A40B00000000 AS DateTime), 0, 0, NULL, CAST(0x0000A2FB0183C904 AS DateTime), NULL, 0, N'')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (48, N'ttt@aa.com', N'111111', 1, N'asdfas', 1, CAST(0x0000A2E900000000 AS DateTime), N'asdfas', CAST(0x0000A2FA00000000 AS DateTime), CAST(0x0000A2FF00000000 AS DateTime), 0, 0, CAST(0x0000A2FB018252A6 AS DateTime), CAST(0x0000A2FB01833E0B AS DateTime), 0, 0, N'sd')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (49, N'rajeshpatel@example.com', N'123456', 1, N'Nurse', 1, CAST(0x00009EE600000000 AS DateTime), N'wew3ssd', CAST(0x0000A41200000000 AS DateTime), CAST(0x0000A1FC00000000 AS DateTime), 0, 0, CAST(0x0000A2F50017C6A6 AS DateTime), NULL, 0, NULL, NULL)
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (50, N'rajeshpatel@example.com', N'123456', 1, N'Nurse', 1, CAST(0x00009EE600000000 AS DateTime), N'wew3ssd', CAST(0x0000A41200000000 AS DateTime), CAST(0x0000A1FC00000000 AS DateTime), 0, 0, CAST(0x0000A2F50017C6A6 AS DateTime), CAST(0x0000A2FD0024FAF5 AS DateTime), 0, 0, N'')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (51, N'test109@aaa.com', N'111111', 1, N'test109', 1, CAST(0x0000A2F000000000 AS DateTime), N'safdasf', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A30100000000 AS DateTime), 0, 1, CAST(0x0000A2FD002C281B AS DateTime), CAST(0x0000A2FD002C3290 AS DateTime), 0, 0, N'testing')
INSERT [dbo].[tbl_employees] ([id], [email_address], [login_password], [emp_type], [position], [facility_id], [date_of_hire], [licence_number], [licence_expiry], [date_last_exclusion_check], [is_deleted], [is_active_record], [create_date], [update_date], [create_by], [update_by], [employee_type_text]) VALUES (52, N'test109@aaa.com', N'111111', 1, N'test109', 1, CAST(0x0000A2F000000000 AS DateTime), N'safdasf', CAST(0x0000A2FF00000000 AS DateTime), CAST(0x0000A30100000000 AS DateTime), 0, 0, CAST(0x0000A2FD002C281B AS DateTime), NULL, 0, NULL, N'testing')
SET IDENTITY_INSERT [dbo].[tbl_employees] OFF
/****** Object:  Table [dbo].[tbl_emp_types]    Script Date: 03/29/2014 17:27:46 ******/
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
INSERT [dbo].[tbl_emp_types] ([emp_type_id], [emp_type_name]) VALUES (1, N'Level 1')
INSERT [dbo].[tbl_emp_types] ([emp_type_id], [emp_type_name]) VALUES (2, N'Level 2')
INSERT [dbo].[tbl_emp_types] ([emp_type_id], [emp_type_name]) VALUES (3, N'Adminstrators')
/****** Object:  Table [dbo].[tbl_course_master]    Script Date: 03/29/2014 17:27:46 ******/
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
SET IDENTITY_INSERT [dbo].[tbl_course_master] ON
INSERT [dbo].[tbl_course_master] ([course_id], [course_title], [create_by], [update_by], [create_date], [update_date], [is_deleted], [is_active_record]) VALUES (1, N'Compliance Nursing', 1, NULL, CAST(0x0000A37300000000 AS DateTime), NULL, 0, 1)
INSERT [dbo].[tbl_course_master] ([course_id], [course_title], [create_by], [update_by], [create_date], [update_date], [is_deleted], [is_active_record]) VALUES (2, N'Compliance Operational', 1, NULL, CAST(0x0000A3A300000000 AS DateTime), NULL, 0, 1)
INSERT [dbo].[tbl_course_master] ([course_id], [course_title], [create_by], [update_by], [create_date], [update_date], [is_deleted], [is_active_record]) VALUES (3, N'Med Compliance Beginners ', 1, NULL, CAST(0x0000A3EE00000000 AS DateTime), NULL, 0, 1)
INSERT [dbo].[tbl_course_master] ([course_id], [course_title], [create_by], [update_by], [create_date], [update_date], [is_deleted], [is_active_record]) VALUES (9, N'Course 4', 1, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[tbl_course_master] ([course_id], [course_title], [create_by], [update_by], [create_date], [update_date], [is_deleted], [is_active_record]) VALUES (10, N'course 5', 1, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[tbl_course_master] ([course_id], [course_title], [create_by], [update_by], [create_date], [update_date], [is_deleted], [is_active_record]) VALUES (11, N'course 6', NULL, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[tbl_course_master] ([course_id], [course_title], [create_by], [update_by], [create_date], [update_date], [is_deleted], [is_active_record]) VALUES (12, N'course 7', 1, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[tbl_course_master] ([course_id], [course_title], [create_by], [update_by], [create_date], [update_date], [is_deleted], [is_active_record]) VALUES (13, N'course 8', 1, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[tbl_course_master] ([course_id], [course_title], [create_by], [update_by], [create_date], [update_date], [is_deleted], [is_active_record]) VALUES (14, N'course 9', 1, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[tbl_course_master] ([course_id], [course_title], [create_by], [update_by], [create_date], [update_date], [is_deleted], [is_active_record]) VALUES (15, N'course 10', 1, NULL, NULL, NULL, 0, 1)
INSERT [dbo].[tbl_course_master] ([course_id], [course_title], [create_by], [update_by], [create_date], [update_date], [is_deleted], [is_active_record]) VALUES (16, N'course11', 1, NULL, NULL, NULL, 0, 1)
SET IDENTITY_INSERT [dbo].[tbl_course_master] OFF
/****** Object:  Table [dbo].[tbl_contact_info]    Script Date: 03/29/2014 17:27:46 ******/
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
	[address_line1] [varchar](300) NULL,
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
	[address_line2] [varchar](300) NULL,
 CONSTRAINT [PK__tbl_cont__3213E83F0F975522] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_contact_info] ON
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (1, 1, N'Alexdraner', N'flametings', N'houston address', N'houson west', NULL, N'IN', N'11021', N'3335522222', N'232232232', 1, CAST(0x0000A2EC00000000 AS DateTime), CAST(0x0000A2F801695322 AS DateTime), NULL, 0, NULL)
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (2, 2, N'kal', N'po', N'kat', N'houston', NULL, N'LA', N'11021', N'712-321-1154', N'987-222-1577', 1, NULL, CAST(0x0000A2FB01822215 AS DateTime), NULL, 0, N'aa2')
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (3, 3, N'Raj', N'david', N'geet werwr', N'sdsf', NULL, N'IN', N'sds', N'', N'gggg', 1, NULL, CAST(0x0000A2FB0183DA40 AS DateTime), NULL, 0, N'')
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (4, 4, N'vimal', N'patel', NULL, NULL, N'USA', N'TX', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (5, 5, N'sameer', N'borisagar', N'sameer', N'', NULL, N'st', N'zzp', N'sfsfs', N'sds', 1, CAST(0x0000A2F5001508A1 AS DateTime), CAST(0x0000A2F600290331 AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (6, 6, N'rajesh', N'patel', N'address1', N'city', NULL, N'PA', N'zip', N'te', N'fzx', 1, CAST(0x0000A2F50017C6A9 AS DateTime), CAST(0x0000A2FD0029A5DD AS DateTime), 0, 0, N'address2')
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (7, 7, N'asfdasdf', N'asfdas', N'asfdasdf', N'', NULL, N'', N'', N'', N'', 1, CAST(0x0000A2F5001B1F84 AS DateTime), CAST(0x0000A2F5001B8AC5 AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (8, 8, N'asfasfasd', N'sds', NULL, N'', NULL, N'', N'', N'', N'', 1, CAST(0x0000A2F5001CA11B AS DateTime), NULL, 0, NULL, NULL)
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (9, 9, N'', N'', NULL, N'', NULL, N'', N'', N'', N'', 1, CAST(0x0000A2F6002958F7 AS DateTime), NULL, 0, NULL, NULL)
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (10, 10, N'rame', N'david', N'', N'', NULL, N'IN', N'', N'', N'', 1, CAST(0x0000A2F6003F2F68 AS DateTime), CAST(0x0000A2FA018AB136 AS DateTime), 0, 0, N'')
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (11, 11, N'rajesh', N'baba', N'gfaa', N'rajkot', NULL, N'TX', N'42', N's2342', N'234242', 1, CAST(0x0000A2F600401C62 AS DateTime), CAST(0x0000A2F60040E143 AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (12, 12, N'devadd', N'patel', N'ffffffsssss', N'c2', NULL, N'GA', N'3433', N'tele', N'fxa33', 1, CAST(0x0000A2F600467745 AS DateTime), CAST(0x0000A2FA0003C69C AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (13, 13, N'aa', N'sd', NULL, N'', NULL, N'KS', N'', N'', N'', 1, CAST(0x0000A2F60170FDE3 AS DateTime), NULL, 0, NULL, NULL)
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (14, 14, N'sdfs', N'sdfs', NULL, N'', NULL, N'', N'', N'', N'', 1, CAST(0x0000A2F60187A03F AS DateTime), NULL, 0, NULL, NULL)
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (15, 27, N'asdfafa', N'sd', NULL, N'', NULL, N'', N'', N'', N'', 1, CAST(0x0000A2FA0004EFC8 AS DateTime), NULL, 0, NULL, NULL)
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (16, 28, N'raj', N'sss', N'', N'', NULL, N'KS', N'', N'', N'', 1, CAST(0x0000A2FA000C77D5 AS DateTime), CAST(0x0000A2FA000C91AD AS DateTime), 0, 0, NULL)
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (17, 34, N'sb', N'asfdsa', N'ss122', N'', NULL, N'IL', N'', N'', N'', 1, CAST(0x0000A2FB000614B5 AS DateTime), CAST(0x0000A2FB0006237E AS DateTime), 0, 0, N'ss2')
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (18, 37, N'sam', N'bb', N'ssdf', N'asdfas', NULL, N'CT', N'2343', N'safas', N'afsda', 1, CAST(0x0000A2FB017F557C AS DateTime), CAST(0x0000A2FB01822C8C AS DateTime), 0, 0, N'sdfsfs')
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (19, 41, N'tej', N'asdasf', N'test1111', N'', NULL, N'LA', N'', N'', N'', 1, CAST(0x0000A2FB018252A8 AS DateTime), CAST(0x0000A2FC0002415C AS DateTime), 0, 0, N'')
INSERT [dbo].[tbl_contact_info] ([id], [emp_id], [first_name], [last_name], [address_line1], [city_name], [country_name], [state_name], [zip_code], [tele_phone], [fax_number], [is_active_record], [create_date], [update_date], [create_by], [update_by], [address_line2]) VALUES (20, 51, N'patel', N'siva', N'ada1', N'asfdsafdasf', NULL, N'IN', N'3242', N'sfasdfd', N'asfda', 1, CAST(0x0000A2FD002C2822 AS DateTime), CAST(0x0000A2FD002C3291 AS DateTime), 0, 0, N'adfasf2')
SET IDENTITY_INSERT [dbo].[tbl_contact_info] OFF
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_GetAll]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_employees_GetAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'   
CREATE Procedure [dbo].[sp_comp_tbl_employees_GetAll]    
@facility_id int = null,
@lastname varchar(50) = null
As    
Begin    
declare @sql varchar(max)

set @sql = ''
 Select     
  e.[id],    
  e.[email_address],    
  e.[login_password],    
  e.[emp_type],    
  e.facility_id,  
  f.[facility_name],    
  e.[position],    
  e.[date_of_hire],    
  e.[licence_number],    
  e.[licence_expiry],    
  e.[date_last_exclusion_check],    
  isnull(e.[is_deleted],0) is_deleted,  
  e.[is_active_record],    
 e.[create_date],    
  e.[update_date],    
  e.[create_by],  
  e.[employee_type_text],
 e.[update_by],
 isnull(c.first_name,'''''''') + '''' '''' + isnull(c.last_name,'''''''') as [name]
 From tbl_employees  e  
 inner join tbl_contact_info c on c.emp_id = e.id
  left outer join tbl_facility f  on e.facility_id = f.id   
  
 Where    
  e.[is_active_record] = 1    
  AND c.[is_active_record] = 1 
  AND isnull(e.[is_deleted],0) = 0  
  AND e.[emp_type] = 1 ''
 
 if ISNULL(@lastname,'''') <>''''                                        
   begin                                                        
	set @sql = @sql +  '' and c.last_name like ''''%'' + @lastname + ''%''''''
   end
   
   set @sql = @sql + '' Order by c.first_name ''
    
    exec (@sql)                                                        
 
 
End    
    
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_DeleteByIds]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_employees_DeleteByIds]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE Procedure [dbo].[sp_comp_tbl_employees_DeleteByIds]    
       @id varchar(1000),
       @update_by varchar(10)
As    
Begin    
declare @que as varchar(2000)
set @que = ''update tbl_employees set is_deleted=1,update_by='' + @update_by + '' where id in ('' + @id + '')''
exec (@que)
End    


' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_DeleteById]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_employees_DeleteById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE Procedure [dbo].[sp_comp_tbl_employees_DeleteById]    
       @id int,
       @update_by int
As    
Begin    
update tbl_employees set is_deleted=1,update_by=@update_by where id =@id
End    
   
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_department]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_department]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
Create PROCEDURE [dbo].[sp_comp_tbl_department] 
(
	@id INT=NULL
)
AS
BEGIN
	
	SELECT 
		id
		,department_name
	FROM 
		tbl_department
	
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_contact_info_Update]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_contact_info_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_comp_tbl_contact_info_Update] 
(
	 @id  INT = 0, 
	 @emp_id INT = 0, 
	 @first_name VARCHAR(100) = NULL, 
	 @last_name VARCHAR(100) = NULL, 
	 @address_line1 VARCHAR(300) = NULL, 
	 @address_line2 VARCHAR(300) = NULL, 
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
		address_line1 = @address_line1, 
		address_line2 = @address_line2, 
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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_contact_info_SelectRow]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_contact_info_SelectRow]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE Procedure [dbo].[sp_comp_tbl_contact_info_SelectRow]  
 @email_address varchar(500)  
As  
Begin  
 Select   
  c.[id],  
  c.[emp_id],  
  c.[first_name],  
  c.[last_name],  
  c.[address_line1],  
  c.[address_line2],  
  c.[city_name],  
  c.[state_name],  
  c.[zip_code],  
  c.[tele_phone],  
  c.[fax_number],  
  c.[is_active_record],  
  c.[create_date],  
  c.[update_date],  
  c.[create_by],  
  c.[update_by],
  c.[country_name] 
 From tbl_contact_info c  
 inner Join tbl_employees e on c.emp_id = e.id  
   
  Where  
     e.email_address = @email_address  
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_employees_Information_Insert]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_employees_Information_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROC [dbo].[sp_employees_Information_Insert]
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
    @create_by INT = 0,
    @employee_type_text varchar(50)
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
                          create_by ,
                          employee_type_text                       
                        
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
                          0 ,
                          @employee_type_text
                        
                        )
                SELECT  SCOPE_IDENTITY() 

            END
        
    END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_contact_Information_Insert]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_contact_Information_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROC [dbo].[sp_contact_Information_Insert]
    @emp_id INT ,
    @first_name VARCHAR(100) = NULL ,
    @last_name VARCHAR(100) = NULL ,
    @address_line1 VARCHAR(300) = NULL ,
    @address_line2 VARCHAR(300) = NULL ,
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
                  address_line1 ,
                  address_line2 ,
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
                  @address_line1 , -- address_line1 - varchar(300)
                  @address_line2 , -- address_line2 - varchar(300)
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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_compliance_get_training_users_to_assign_to_course]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_compliance_get_training_users_to_assign_to_course]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[sp_compliance_get_training_users_to_assign_to_course]
@course_id int,
@facility_id int = null
as
begin

declare @course_name varchar(100)
select @course_name = course_title from tbl_course_master where course_id = @course_id
and isnull(is_active_record,0) = 1 
and isnull(is_deleted,0) = 0

select emp.id as employeeid,
emp.email_address,
emp.facility_id,
cinfo.first_name firstname,
cinfo.last_name lastname,
@course_name as course_name,
@course_id as course_id
 from tbl_employees emp inner join
tbl_contact_info cinfo on cinfo.emp_id = emp.id
where emp.id not in 
(select emp_id from tbl_training_assignments where course_id = @course_id)

end
-- end sp' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_compliance_get_active_training_courses]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_compliance_get_active_training_courses]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create proc [dbo].[sp_compliance_get_active_training_courses]
as
begin

select course_id,
course_title,
create_by,
update_by,
create_date,
update_date,
is_deleted,
is_active_record from 
tbl_course_master
order by course_title
end' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_compliance_assign_user_to_training_course]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_compliance_assign_user_to_training_course]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[sp_compliance_assign_user_to_training_course]
@id int = null,
@course_id int,
@employee_id int,
@user_by int,
@status_id int = null,
@due_date datetime = null
as
begin

declare @cnt int

select @cnt = count(1) from tbl_training_assignments
where course_id = @course_id and emp_id = @employee_id

if (@cnt = 0)
begin
insert into tbl_training_assignments
( course_id,emp_id,date_assigned,due_date,completion_status,created_by,create_date)
values
(@course_id,@employee_id,getdate(), null, isnull(@status_id,1) , @user_by , getdate())

end
else
begin
update tbl_training_assignments
set completion_status = isnull(@status_id,1),
due_date = @due_date
where emp_id = @employee_id and course_id = @course_id
and id = @id

end

end
-- end sp' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_incident_person_insert]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_incident_person_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_comp_tbl_incident_person_insert]     
(  
	@incident_id INT = NULL, 
	@person_first_name VARCHAR(100) = NULL, 
	@person_last_name VARCHAR(100) = NULL, 
	@create_by INT = NULL
)  
AS    
BEGIN    
 	SET NOCOUNT ON;    
	--DECLARE @IDTable TABLE(ID INT);
	INSERT INTO tbl_incident_person (
								incident_id,
								person_first_name,
								person_last_name,
								is_active_record, 
								create_date, 
								create_by
							)
				--OUTPUT INSERTED.id INTO @IDTable							
				VALUES 
							(
								@incident_id,
								@person_first_name, 
								@person_last_name,
								1,
								GETDATE(),
								@create_by
							)  

		--SELECT ID FROM @IDTable
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_incident_insert]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_incident_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_comp_tbl_incident_insert]     
(  
	@incident_reported_date DATETIME = NULL,
	@incident_occured_date DATETIME = NULL, 
	@incident_description NVARCHAR(MAX) = NULL, 
	@is_aonymously BIT = NULL, 
	@create_by INT = NULL
)  
AS    
BEGIN    
 	SET NOCOUNT ON;    
	DECLARE @IDTable TABLE(ID INT);
	INSERT INTO tbl_incident (
								incident_reported_date, 
								incident_occured_date, 
								incident_description, 
								is_aonymously, 
								is_active_record, 
								create_date, 
								create_by
							)
				OUTPUT INSERTED.id INTO @IDTable							
				VALUES 
							(
								@incident_reported_date,
								@incident_occured_date, 
								@incident_description, 
								@is_aonymously, 
								1,
								GETDATE(),
								@create_by
							)  

		SELECT ID FROM @IDTable
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_incident_department_insert]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_incident_department_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_comp_tbl_incident_department_insert]     
(  
	@incident_id INT = NULL, 
	@department_id INT = NULL, 
	@create_by INT = NULL
)  
AS    
BEGIN    
 	SET NOCOUNT ON;    
	--DECLARE @IDTable TABLE(ID INT);
	INSERT INTO tbl_incident_department (
								incident_id,
								department_id,
								is_active_record, 
								create_date, 
								create_by
							)
				--OUTPUT INSERTED.id INTO @IDTable							
				VALUES 
							(
								@incident_id,
								@department_id, 
								1,
								GETDATE(),
								@create_by
							)  

		--SELECT ID FROM @IDTable
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_Update]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_employees_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'  
CREATE PROCEDURE [dbo].[sp_comp_tbl_employees_Update]     
(    
  @id  INT = 0,     
  @position VARCHAR(100) = NULL,     
  @date_of_hire DATETIME = NULL,     
  @licence_number VARCHAR(100) = NULL,    
  @licence_expiry DATETIME = NULL,     
  @date_last_exclusion_check DATETIME = NULL,    
  @create_by INT = NULL,     
  @update_by INT = NULL ,  
  @password varchar(100),  
  @employee_type_text varchar(50) ,
  @is_active_record bit = null
)    
AS    
BEGIN    
     
  
insert into tbl_employees  
   (  
 create_date,  
 update_date,  
 create_by,  
 update_by,  
 is_active_record,  
 is_deleted,  
 position,  
 login_password,date_of_hire,  
 licence_number,  
 licence_expiry,  
 date_last_exclusion_check,  
 email_address,emp_type,facility_id,employee_type_text)  
 select  
 create_date,  
 update_date,  
 create_by,  
 update_by,  
 0,  
 is_deleted,  
 position,  
 login_password,date_of_hire,  
 licence_number,  
 licence_expiry,  
 date_last_exclusion_check,  
 email_address,emp_type,facility_id,  
 employee_type_text  
 from tbl_employees where id = @id and   
 is_active_record = 1  
     
   If ( @@RowCount > 0)  
   Begin  
  UPDATE      
   dbo.tbl_employees    
  SET     
    position = @position,   
    [login_password] = @password  ,  
    date_of_hire = @date_of_hire,     
    licence_number = @licence_number,    
    licence_expiry = @licence_expiry,     
    date_last_exclusion_check = @date_last_exclusion_check,    
    update_by = @update_by,    
    employee_type_text=@employee_type_text,  
    update_date = GETDATE(),
    is_active_record = @is_active_record
   WHERE     
    id=@id    
End  
      
  select @id    
END  
  ' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_SelectRow_ByEmail]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_employees_SelectRow_ByEmail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE Procedure [dbo].[sp_comp_tbl_employees_SelectRow_ByEmail]  
 @email_address varchar(500),  
 @login_password varchar(100)  
As  
Begin  
 Select   
  e.[id],  
  [email_address],  
  [login_password],  
  [emp_type],  
  e.facility_id,
  f.[facility_name],  
  [position],  
  [date_of_hire],  
  [licence_number],  
  [licence_expiry],  
  [date_last_exclusion_check],  
  [is_deleted],  
  [is_active_record],  
  [create_date],  
  [update_date],  
  [create_by],  
  [update_by]  ,
  e.employee_type_text
 From tbl_employees  e
 left outer join tbl_facility f
 on e.facility_id = f.id 
 Where  
  [email_address] = @email_address  
  AND [login_password] = @login_password  
  AND [is_active_record] = 1  
End  
  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_comp_tbl_employees_GetByid]    Script Date: 03/29/2014 17:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_comp_tbl_employees_GetByid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_comp_tbl_employees_GetByid] @id INT = 0
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
                ISNULL(c.first_name, '''') + '' '' + ISNULL(c.last_name, '''') AS [name]
        FROM    tbl_employees e
                INNER JOIN tbl_contact_info c ON c.emp_id = e.id
                LEFT OUTER JOIN tbl_facility f ON e.facility_id = f.id
        WHERE   e.[is_active_record] = 1
                AND c.[is_active_record] = 1
                AND ISNULL(e.[is_deleted], 0) = 0
                AND e.[emp_type] = 1 -- level 1 employee 
                AND e.[id] = @id 
    END
' 
END
GO
