using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BLCompliance
{
    public class Login
    {
        public static Result GetEmployee(string emailAddress, string password, out BLCompliance.Model.employee employee)
        {
            employee = null;
            Result result = new Result(0, false, "Validate Login fails");

            DataSet ds = null;
            if (emailAddress.Trim() == "" || password.Trim() == "")
            {
                result.ResultMessage = "Not Sufficient Information Provided.";
                result.ResultCode = 500;
                return result;
            }

            try
            {
                SqlParameter[] prms = new SqlParameter[2];
                prms[0] = new SqlParameter("@email_address", SqlDbType.VarChar);
                prms[0].Value = emailAddress.Trim();

                prms[1] = new SqlParameter("@login_password", SqlDbType.VarChar);
                prms[1].Value = password.Trim();

                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_comp_tbl_employees_SelectRow_ByEmail", prms);

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count == 1)
                    {
                        employee = new Model.employee();

                        DataRow dr = ds.Tables[0].Rows[0];

                        employee.Id = int.Parse(dr["id"].ToString());
                        employee.EmailAddress = Convert.ToString(dr["email_address"]);
                        employee.Password = Convert.ToString(dr["login_password"]);
                        string colName ="emp_type";
                        
                        if (!CheckNullOrBlank(dr, colName))
                            employee.EmployeeType = int.Parse(dr[colName].ToString());

                        colName = "position";
                        if (!CheckNullOrBlank(dr, colName))
                            employee.Position = dr[colName].ToString();
                        //facility_id
                        colName = "facility_id";
                        if (!CheckNullOrBlank(dr, colName))
                            employee.FacilityId = int.Parse(dr[colName].ToString());

                        colName = "facility_name";
                        if (!CheckNullOrBlank(dr, colName))
                            employee.FacilityName = dr[colName].ToString();

                        
                        colName = "date_of_hire";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                employee.DateOfHire = tempData;
                            }
                        }

                        colName = "licence_expiry";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                employee.Licence_Expiry = tempData;
                            }
                        }

                        colName = "date_last_exclusion_check";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                employee.DateLastExclusionCheck = tempData;
                            }
                        }


                        colName = "is_deleted";
                        if (!CheckNullOrBlank(dr, colName))
                            employee.IsDeleted = Convert.ToBoolean(dr[colName].ToString());

                        colName = "is_active_record";
                        if (!CheckNullOrBlank(dr, colName))
                            employee.IsActiveRecord = Convert.ToBoolean(dr[colName].ToString());


                        colName = "update_date";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                employee.LastUpdateDate = tempData;
                            }
                        }

                        colName = "create_date";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                employee.CreateDate = tempData;
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

    }
}
