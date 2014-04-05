using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using BLCompliance.Model;

namespace BLCompliance
{
    public class BLManageFacility
    {

        public static Result GetEmployees(int facility_id, string lastNameToSearch, bool isActiveOnly, out List<BLCompliance.Model.employee> employeeList)
        {
            employeeList = new List<Model.employee>();
            Result result = new Result(0, false, "get employee fails");

            DataSet ds = null;

            try
            {
                SqlParameter[] prms = new SqlParameter[3];
                prms[0] = new SqlParameter("@facility_id", SqlDbType.Int);
                if (facility_id > 0)
                {
                    prms[0].Value = facility_id;
                }
                else
                {
                    prms[0].Value = System.DBNull.Value;
                }


                prms[1] = new SqlParameter("@lastname", SqlDbType.VarChar);
                if (lastNameToSearch.Trim() != "")
                {
                    prms[1].Value = lastNameToSearch;
                }
                else
                {
                    prms[1].Value = System.DBNull.Value;
                }

                prms[2] = new SqlParameter("@is_active_only", SqlDbType.Bit);
                prms[2].Value = isActiveOnly;



                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_comp_tbl_employees_GetAll", prms);

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        employee employee = new employee();



                        employee.Id = int.Parse(dr["id"].ToString());
                        employee.EmailAddress = Convert.ToString(dr["email_address"]);
                        employee.EmployeeTypeText = Convert.ToString(dr["employee_type_text"]);
                        employee.Password = Convert.ToString(dr["login_password"]);
                        string colName = "emp_type";

                        if (!CheckNullOrBlank(dr, colName))
                            employee.EmployeeType = int.Parse(dr[colName].ToString());

                        colName = "position";
                        if (!CheckNullOrBlank(dr, colName))
                            employee.Position = dr[colName].ToString();

                        colName = "name";

                        if (!CheckNullOrBlank(dr, colName))
                            employee.ContactName = dr[colName].ToString();


                        //facility_id
                        colName = "facility_id";
                        if (!CheckNullOrBlank(dr, colName))
                            employee.FacilityId = int.Parse(dr[colName].ToString());

                        colName = "facility_name";
                        if (!CheckNullOrBlank(dr, colName))
                            employee.FacilityName = dr[colName].ToString();

                        colName = "licence_number";
                        if (!CheckNullOrBlank(dr, colName))
                            employee.Licence_Number = dr[colName].ToString();

                        colName = "position";
                        if (!CheckNullOrBlank(dr, colName))
                            employee.Position = dr[colName].ToString();

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

                        employeeList.Add(employee);
                    }
                    result.ResultCode = 1;
                    result.ResultMessage = "Success";


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


        #region "kg date - 21-march-2014"
        public static Result GetEmployeeById(Int32 EmployeeId, out BLCompliance.Model.employee employee)
        {
            employee = null;
            Result result = new Result(0, false, "get employee fails");

            DataSet ds = null;
            try
            {

                SqlParameter[] prms = new SqlParameter[1];
                prms[0] = new SqlParameter("@id", SqlDbType.Int);
                if (EmployeeId > 0)
                {
                    prms[0].Value = EmployeeId;
                }



                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_comp_tbl_employees_GetByid", prms);

                if (ds != null &&  ds.Tables.Count> 0 && ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count == 1)
                    {
                        employee = new Model.employee();

                        DataRow dr = ds.Tables[0].Rows[0];

                        employee.Id = int.Parse(dr["id"].ToString());
                        employee.EmailAddress = Convert.ToString(dr["email_address"]);
                        employee.EmployeeTypeText = Convert.ToString(dr["employee_type_text"]);
                        employee.Password = Convert.ToString(dr["login_password"]);
                        string colName = "emp_type";

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

                        colName = "licence_number";
                        if (!CheckNullOrBlank(dr, colName))
                            employee.Licence_Number = dr[colName].ToString();

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
        public static Result InsertEmployeeInfo(BLCompliance.Model.employee employee, out BLCompliance.Model.employee Objemployee)
        {
            Objemployee = null;
            object employeeid = 0;
            Result result = new Result(0, false, "insert employee fails");
            try
            {
                SqlParameter[] parameters =
                        {    
                          new SqlParameter("@email_address", SqlDbType.VarChar) { Value = employee.EmailAddress },
                          new SqlParameter("@login_password", SqlDbType.VarChar) { Value = employee.Password },
                          new SqlParameter("@employee_type_text", SqlDbType.VarChar) { Value = employee.EmployeeTypeText },
                          new SqlParameter("@facility_id", SqlDbType.VarChar) { Value = employee.FacilityId },
                          new SqlParameter("@emp_type", SqlDbType.Int) { Value = employee.EmployeeType },
                          new SqlParameter("@position", SqlDbType.VarChar) { Value = employee.Position },
                          new SqlParameter("@date_of_hire", SqlDbType.DateTime) { Value = employee.DateOfHire },
                          new SqlParameter("@licence_number", SqlDbType.VarChar) { Value = employee.Licence_Number },
                          new SqlParameter("@licence_expiry", SqlDbType.DateTime) { Value = employee.Licence_Expiry },
                          new SqlParameter("@date_last_exclusion_check", SqlDbType.DateTime) { Value = employee.DateLastExclusionCheck },
                          new SqlParameter("@is_deleted", SqlDbType.Bit) { Value = employee.IsDeleted },
                          new SqlParameter("@is_active_record", SqlDbType.Bit) { Value = employee.IsActiveRecord },
                          new SqlParameter("@create_by", SqlDbType.Int) { Value = employee.create_by }
                        };

                employeeid = CData.ExecuteScalar(CommandType.StoredProcedure, "sp_employees_Information_Insert", parameters);
                if (Convert.ToInt32(employeeid) > 0)
                {
                    Objemployee = new Model.employee();
                    Objemployee.Id = Convert.ToInt32(employeeid);
                    result.ResultCode = 1;
                    result.ResultMessage = "Success";
                }
                else if (Convert.ToInt32(employeeid) > -1)
                {
                    result.ResultCode = -1;
                    result.ResultMessage = "Email Address already exist";
                }
                else
                {
                    result.ResultMessage = "Fail  to Save Employee. Please try again.";
                    result.ResultCode = 1001;
                }
                employee = null;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }
        public static Result UpdateEmployeeInfo(BLCompliance.Model.employee employee, out BLCompliance.Model.employee Objemployee)
        {
            Objemployee = null;
            object employeeid = 0;
            Result result = new Result(0, false, "update employee fails");
            try
            {
                SqlParameter[] parameters =
                        {    
                          new SqlParameter("@id", SqlDbType.Int) { Value = employee.Id },
                          new SqlParameter("@position", SqlDbType.VarChar) { Value = employee.Position },
                          new SqlParameter("@password", SqlDbType.VarChar) { Value = employee.Password },
                          new SqlParameter("@employee_type_text", SqlDbType.VarChar) { Value = employee.EmployeeTypeText },
                          new SqlParameter("@date_of_hire", SqlDbType.DateTime) { Value = employee.DateOfHire },
                          new SqlParameter("@licence_number", SqlDbType.VarChar) { Value = employee.Licence_Number },
                          new SqlParameter("@licence_expiry", SqlDbType.DateTime) { Value = employee.Licence_Expiry },
                          new SqlParameter("@date_last_exclusion_check", SqlDbType.DateTime) { Value = employee.DateLastExclusionCheck },
                          new SqlParameter("@update_by", SqlDbType.Int) { Value = employee.create_by },
                          new SqlParameter("@is_active_record", SqlDbType.Bit) { Value = employee.IsActiveRecord },
                          new SqlParameter("@is_deleted", SqlDbType.Bit) { Value = employee.IsDeleted }
                        };

                employeeid = CData.ExecuteScalar(CommandType.StoredProcedure, "sp_comp_tbl_employees_Update", parameters);
                if (Convert.ToInt32(employeeid) > 0)
                {
                    Objemployee = new Model.employee();
                    Objemployee.Id = Convert.ToInt32(employeeid);
                    result.ResultCode = 1;
                    result.ResultMessage = "Success";
                }

                else
                {
                    result.ResultMessage = "Update employee fails";
                    result.ResultCode = 1001;
                }
                employee = null;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }
        #endregion
    }
}
