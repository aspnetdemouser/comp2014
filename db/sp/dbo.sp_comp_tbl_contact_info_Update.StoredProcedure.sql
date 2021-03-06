  
alter PROCEDURE [dbo].[sp_comp_tbl_contact_info_Update]   
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
   
   declare @fn varchar(100)
   declare @ln varchar(100)
   
   select @fn= first_name, @ln = last_name from tbl_contact_info
   where id=@id 
   
   
declare @history_create bit
set   @history_create = 0

if upper(ltrim(rtrim(@fn))) != upper(ltrim(rtrim(@first_name)))
begin
	-- create history record
set @history_create = 1
end  

if upper(ltrim(rtrim(@ln))) != upper(ltrim(rtrim(@last_name)))
begin
	-- create history record
	set @history_create = 1

end  

if @history_create = 1
begin

insert into tbl_contact_info
	( emp_id,first_name,last_name,address_line1,city_name,country_name,
state_name,zip_code,tele_phone,fax_number,is_active_record,create_date,update_date,
create_by,update_by,address_line2)
select emp_id,first_name,last_name,address_line1,city_name,country_name,
state_name,zip_code,tele_phone,fax_number,0,create_date,update_date,
create_by,update_by,address_line2 from tbl_contact_info where id = @id
and is_active_record = 1
end


   
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