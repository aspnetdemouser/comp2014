using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace BLCompliance
{
    public class BLReportinginfo
    {

        public static Result DepartmentreportList(out List<BLCompliance.Model.reportinginfo> DepartmentreportList)
        {
            DepartmentreportList = new List<Model.reportinginfo>();
            Result result = new Result(0, false, "Get Department Information fails");

            DataSet ds = null;


            try
            {
                SqlParameter[] prms = null;


                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_comp_tbl_department", prms);

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {

                        Model.reportinginfo reportinginfo = new Model.reportinginfo();



                        reportinginfo.DepartmentId = int.Parse(dr["id"].ToString());


                        string colName = "department_name";
                        if (!CheckNullOrBlank(dr, colName))
                            reportinginfo.DepartmentName = dr[colName].ToString();

                        DepartmentreportList.Add(reportinginfo);

                    }

                    result.ResultCode = 1;
                    result.ResultMessage = "Success";
                }
                else
                {
                    result.ResultMessage = "Department Not Found";
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

        public static Result InsertIncidentInfo(BLCompliance.Model.reportinginfo reportinginfo, out Model.reportinginfo objincident)
        {
            objincident = null;
            object IncidentId = 0;
            Result result = new Result(0, false, "insert incident info fails");
            try
            {
                SqlParameter[] parameters =
                        {    
                         
                          new SqlParameter("@is_aonymously", SqlDbType.Bit) { Value = reportinginfo.IsAonymously },
                          new SqlParameter("@incident_description", SqlDbType.VarChar) { Value = reportinginfo.IncidentDescription },
                          new SqlParameter("@incident_reported_date", SqlDbType.DateTime) { Value = reportinginfo.IncidentReportedDate },
                          new SqlParameter("@incident_occured_date", SqlDbType.DateTime) { Value = reportinginfo.IncidentOccuredDate },
                          new SqlParameter("@create_by", SqlDbType.Int) { Value = reportinginfo.create_by }
                        };

                IncidentId = CData.ExecuteScalar(CommandType.StoredProcedure, "sp_comp_tbl_incident_insert", parameters);
                if (Convert.ToInt32(IncidentId) > 0)
                {
                    objincident = new Model.reportinginfo();
                    objincident.IncidentId = Convert.ToInt32(IncidentId);
                    result.ResultCode = 1;
                    result.ResultMessage = "Success";
                }
                else
                {
                    result.ResultMessage = "insert incident info fails";
                    result.ResultCode = 1001;
                }


            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public static Result InsertDepartmentInfo(BLCompliance.Model.reportinginfo reportinginfo, out Model.reportinginfo objDepartment)
        {
            objDepartment = null;
            object DepartmentId = 0;
            Result result = new Result(0, false, "insert department info fails");
            try
            {
                
                    SqlParameter[] parameters =
                        {    
                          new SqlParameter("@incident_id", SqlDbType.Int) { Value = reportinginfo.IncidentId },
                          new SqlParameter("@department_id", SqlDbType.Int) { Value = reportinginfo.DepartmentId },
                          new SqlParameter("@create_by", SqlDbType.Int) { Value = reportinginfo.create_by }
                        };

                    CData.ExecuteNonQuery(CommandType.StoredProcedure, "sp_comp_tbl_incident_department_insert", parameters);
              
                result.ResultCode = 1;
                result.ResultMessage = "Success";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public static Result InsertPersonInfo(BLCompliance.Model.reportinginfo reportinginfo, out Model.reportinginfo objIncidentPerson)
        {
            objIncidentPerson = null;
            object DepartmentId = 0;
            Result result = new Result(0, false, "insert department info fails");
            try
            {
                
                    SqlParameter[] parameters =
                        {    
                          new SqlParameter("@incident_id", SqlDbType.Int) { Value = reportinginfo.IncidentId },
                          new SqlParameter("@person_first_name", SqlDbType.VarChar) { Value = reportinginfo.PersonFirstName },
                          new SqlParameter("@person_last_name", SqlDbType.VarChar) { Value = reportinginfo.PersonLastName },
                          new SqlParameter("@create_by", SqlDbType.Int) { Value = reportinginfo.create_by }
                        };

                    CData.ExecuteNonQuery(CommandType.StoredProcedure, "sp_comp_tbl_incident_person_insert", parameters);
                
                result.ResultCode = 1;
                result.ResultMessage = "Success";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

    }

}
