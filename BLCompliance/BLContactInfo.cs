using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace BLCompliance
{
    /// <summary>
    /// business logic - Contact Info
    /// </summary>
    public class BLContactInfo
    {
        public static Result GetEmployeeContactInfo(string emailAddress, out BLCompliance.Model.employee_contact_info contactInfo)
        {
            contactInfo = null;
            Result result = new Result(0, false, "Get Contact Information fails");

            DataSet ds = null;
            if (emailAddress.Trim() == "")
            {
                result.ResultMessage = "Not Sufficient Information Provided.";
                result.ResultCode = 500;
                return result;
            }

            try
            {
                SqlParameter[] prms = new SqlParameter[1];
                prms[0] = new SqlParameter("@email_address", SqlDbType.VarChar);
                prms[0].Value = emailAddress.Trim();


                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_comp_tbl_contact_info_SelectRow", prms);

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count == 1)
                    {
                        contactInfo = new Model.employee_contact_info();

                        DataRow dr = ds.Tables[0].Rows[0];

                        contactInfo.ContactInfoId = int.Parse(dr["id"].ToString());


                        string colName = "first_name";
                        if (!CheckNullOrBlank(dr, colName))
                            contactInfo.FirstName = dr[colName].ToString();

                        colName = "last_name";
                        if (!CheckNullOrBlank(dr, colName))
                            contactInfo.LastName = dr[colName].ToString();

                        colName = "address_line";
                        if (!CheckNullOrBlank(dr, colName))
                            contactInfo.AddressLine = dr[colName].ToString();

                        colName = "city_name";
                        if (!CheckNullOrBlank(dr, colName))
                            contactInfo.City = dr[colName].ToString();

                        colName = "state_name";
                        if (!CheckNullOrBlank(dr, colName))
                            contactInfo.State = dr[colName].ToString();

                        colName = "country_name";
                        if (!CheckNullOrBlank(dr, colName))
                            contactInfo.CountryName = dr[colName].ToString();

                        colName = "zip_code";
                        if (!CheckNullOrBlank(dr, colName))
                            contactInfo.ZipCode = dr[colName].ToString();

                        colName = "tele_phone";
                        if (!CheckNullOrBlank(dr, colName))
                            contactInfo.TelePhone = dr[colName].ToString();

                        colName = "fax_number";
                        if (!CheckNullOrBlank(dr, colName))
                            contactInfo.FaxNumber = dr[colName].ToString();

                        colName = "is_active_record";
                        if (!CheckNullOrBlank(dr, colName))
                            contactInfo.IsActiveRecord = Convert.ToBoolean(dr[colName].ToString());

                        colName = "update_date";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                contactInfo.Update_date = tempData;
                            }
                        }

                        colName = "create_date";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                contactInfo.Create_date = tempData;
                            }
                        }

                        result.ResultCode = 1;
                        result.ResultMessage = "Success";
                    }
                    else
                    {
                        result.ResultMessage = "More than one record found.";
                        result.ResultCode = 1002;
                    }

                }
                else
                {
                    result.ResultMessage = "Employee Not Found";
                    result.ResultCode = 1001;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        private static bool CheckNullOrBlank(DataRow dr, string ColName)
        {
            if (dr[ColName] == System.DBNull.Value)
            {
                return true;
            }
            else if (dr[ColName] == null)
            {
                return true;
            }
            else if (String.IsNullOrEmpty(dr[ColName].ToString()))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static Result InsertContactInfo(BLCompliance.Model.employee_contact_info contactinfo, out Model.employee_contact_info Objcontactinfo)
        {
            Objcontactinfo = null;
            object Contactid = 0;
            Result result = new Result(0, false, "insert employee contact info fails");
            try
            {
                SqlParameter[] parameters =
                        {    
                         new SqlParameter("@emp_id", SqlDbType.Int) { Value = contactinfo.EmployeeId },
                          new SqlParameter("@first_name", SqlDbType.VarChar) { Value = contactinfo.FirstName },
                          new SqlParameter("@last_name", SqlDbType.VarChar) { Value = contactinfo.LastName },
                          new SqlParameter("@city_name", SqlDbType.VarChar) { Value = contactinfo.City },
                          new SqlParameter("@state_name", SqlDbType.VarChar) { Value = contactinfo.State },
                          new SqlParameter("@zip_code", SqlDbType.VarChar) { Value = contactinfo.ZipCode },
                          new SqlParameter("@tele_phone", SqlDbType.VarChar) { Value = contactinfo.TelePhone },
                          new SqlParameter("@fax_number", SqlDbType.VarChar) { Value = contactinfo.FaxNumber },
                          new SqlParameter("@is_active_record", SqlDbType.Bit) { Value = contactinfo.IsActiveRecord },
                          new SqlParameter("@create_by", SqlDbType.Int) { Value = contactinfo.create_by }
                        };

                Contactid = CData.ExecuteScalar(CommandType.StoredProcedure, "sp_contact_Information_Insert", parameters);
                if (Convert.ToInt32(Contactid) > 0)
                {
                    Objcontactinfo = new Model.employee_contact_info();
                    Objcontactinfo.ContactInfoId = Convert.ToInt32(Contactid);
                    result.ResultCode = 1;
                    result.ResultMessage = "Success";
                }
                else
                {
                    result.ResultMessage = "insert employee contact info fails";
                    result.ResultCode = 1001;
                }
                contactinfo = null;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public static Result UpdateContactInfo(BLCompliance.Model.employee_contact_info contactinfo, out Model.employee_contact_info Objcontactinfo)
        {
            Objcontactinfo = null;
            object Contactid = 0;
            Result result = new Result(0, false, "Update employee contact info fails");
            try
            {
                SqlParameter[] parameters =
                        {     
                            
                          new SqlParameter("@id", SqlDbType.Int) { Value = contactinfo.ContactInfoId },
                          new SqlParameter("@emp_id", SqlDbType.Int) { Value = contactinfo.EmployeeId },
                          new SqlParameter("@address_line", SqlDbType.VarChar) { Value = contactinfo.AddressLine },
                          new SqlParameter("@first_name", SqlDbType.VarChar) { Value = contactinfo.FirstName },
                          new SqlParameter("@last_name", SqlDbType.VarChar) { Value = contactinfo.LastName },
                          new SqlParameter("@city_name", SqlDbType.VarChar) { Value = contactinfo.City },
                          new SqlParameter("@state_name", SqlDbType.VarChar) { Value = contactinfo.State },
                          new SqlParameter("@zip_code", SqlDbType.VarChar) { Value = contactinfo.ZipCode },
                          new SqlParameter("@tele_phone", SqlDbType.VarChar) { Value = contactinfo.TelePhone },
                          new SqlParameter("@fax_number", SqlDbType.VarChar) { Value = contactinfo.FaxNumber },
                          new SqlParameter("@update_by", SqlDbType.Int) { Value = contactinfo.create_by }
                        };

                Contactid = CData.ExecuteScalar(CommandType.StoredProcedure, "sp_comp_tbl_contact_info_Update", parameters);
                if (Convert.ToInt32(Contactid) > 0)
                {
                    Objcontactinfo = new Model.employee_contact_info();
                    Objcontactinfo.ContactInfoId = Convert.ToInt32(Contactid);
                    result.ResultCode = 1;
                    result.ResultMessage = "Success";
                }
                else
                {
                    result.ResultMessage = "update employee contact info fails";
                    result.ResultCode = 1001;
                }
                contactinfo = null;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public static Result DeleteContactInfo(int id, int updatedBy)
        {
            object Contactid = 0;
            Result result = new Result(0, false, "Update employee contact info fails");
            try
            {
                SqlParameter[] parameters =
                        {     
                            
                          new SqlParameter("@id", SqlDbType.Int) { Value = id },                          
                          new SqlParameter("@update_by", SqlDbType.Int) { Value = updatedBy }
                        };

                Contactid = CData.ExecuteNonQuery(CommandType.StoredProcedure, "sp_comp_tbl_employees_DeleteById", parameters);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public static void DeleteEmployees(string id, int updatedBy)
        {
            object Contactid = 0;
            try
            {
                SqlParameter[] parameters =
                        {     
                            
                          new SqlParameter("@id", SqlDbType.VarChar) { Value = id },                          
                          new SqlParameter("@update_by", SqlDbType.VarChar) { Value = updatedBy.ToString() }
                        };

                Contactid = CData.ExecuteNonQuery(CommandType.StoredProcedure, "sp_comp_tbl_employees_DeleteByIds", parameters);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }
    }
}
