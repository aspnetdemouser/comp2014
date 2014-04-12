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


        public static Result ReportingList(int? id, int? createby, string CriteriaSearch, string ReportType, out List<BLCompliance.Model.reportinginfo> ReportingList)
        {
            ReportingList = new List<Model.reportinginfo>();
            Result result = new Result(0, false, "Get Reporting Information fails");

            DataSet ds = null;


            try
            {
                if (id == 0)
                {
                    id = null;
                }
                SqlParameter[] prms =
                        {    
                          new SqlParameter("@id", SqlDbType.Int) { Value = id },
                          new SqlParameter("@create_by", SqlDbType.Int) { Value = createby },
                          new SqlParameter("@search_criteria", SqlDbType.VarChar) { Value = CriteriaSearch },
                          new SqlParameter("@is_aonymously", SqlDbType.Bit) { Value = null },
                          new SqlParameter("@incident_type", SqlDbType.VarChar) { Value = ReportType }
                        };


                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_comp_tbl_incident_GetAll", prms);

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {

                        Model.reportinginfo reportinginfo = new Model.reportinginfo();



                        reportinginfo.IncidentId = int.Parse(dr["id"].ToString());
                        reportinginfo.InboxId = int.Parse(dr["id"].ToString());

                        string colName = "incident_reported_date";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                reportinginfo.IncidentReportedDate = tempData;
                            }
                        }

                        colName = "incident_occured_date";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                reportinginfo.IncidentOccuredDate = tempData;
                            }
                        }

                        colName = "create_date";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                reportinginfo.CreateDate = tempData;

                                reportinginfo.Date = tempData.ToString("dd-MMM-yyyy HH:mm tt");
                            }
                        }

                        colName = "is_active_record";
                        if (!CheckNullOrBlank(dr, colName))
                            reportinginfo.IsActiveRecord = Convert.ToBoolean(dr[colName].ToString());

                        colName = "is_aonymously";
                        if (!CheckNullOrBlank(dr, colName))
                            reportinginfo.IsAonymously = Convert.ToBoolean(dr[colName].ToString());

                        colName = "create_by";
                        if (!CheckNullOrBlank(dr, colName))
                            reportinginfo.create_by = int.Parse(dr[colName].ToString());


                        colName = "department_id";
                        if (!CheckNullOrBlank(dr, colName))
                            reportinginfo.DepartmentId = int.Parse(dr[colName].ToString());

                        colName = "update_by";
                        if (!CheckNullOrBlank(dr, colName))
                            reportinginfo.update_by = int.Parse(dr[colName].ToString());

                        colName = "IncidentDepartment";
                        if (!CheckNullOrBlank(dr, colName))
                            reportinginfo.DepartmentName = dr[colName].ToString();

                        colName = "incident_type";
                        if (!CheckNullOrBlank(dr, colName))
                            reportinginfo.ReportType = dr[colName].ToString();

                        colName = "IncidentPerson";
                        if (!CheckNullOrBlank(dr, colName))
                            reportinginfo.PersonInvolved = dr[colName].ToString();

                        colName = "first_name";
                        string fname = string.Empty;
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            fname = dr[colName].ToString();

                        }
                        colName = "last_name";
                        string lname = string.Empty;
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            lname = dr[colName].ToString();
                        }
                        reportinginfo.From = fname + " " + lname;

                        //colName = "CSVIncidentDepartment";
                        //if (!CheckNullOrBlank(dr, colName))
                        //    reportinginfo.CSVIncidentDepartment = dr[colName].ToString();

                        //colName = "CSVIncidentPerson";
                        //if (!CheckNullOrBlank(dr, colName))
                        //    reportinginfo.CSVIncidentPerson = dr[colName].ToString();

                        colName = "incident_description";
                        if (!CheckNullOrBlank(dr, colName))
                            reportinginfo.IncidentDescription = dr[colName].ToString();



                        ReportingList.Add(reportinginfo);

                    }

                    result.ResultCode = 1;
                    result.ResultMessage = "Success";
                }
                else
                {
                    result.ResultMessage = "Reporting Not Found";
                    result.ResultCode = 1001;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public static Result ReportingTypeCountList(string IncidentType, out List<BLCompliance.Model.reportinginfo> ReportingTypeCountList)
        {
            ReportingTypeCountList = new List<Model.reportinginfo>();
            Result result = new Result(0, false, "Get Reporting Information fails");

            DataSet ds = null;


            try
            {

                SqlParameter[] prms =
                        {    
                          new SqlParameter("@incident_type", SqlDbType.VarChar) { Value = IncidentType }
                          
                        };


                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_comp_tbl_incident_type_count_Get", prms);

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {

                        Model.reportinginfo reportinginfo = new Model.reportinginfo();

                        string colName = "incident_type_cnt";
                        if (!CheckNullOrBlank(dr, colName))
                            reportinginfo.IncidentTypeCount = Convert.ToString(dr[colName].ToString());

                        colName = "incident_type";
                        if (!CheckNullOrBlank(dr, colName))
                            reportinginfo.ReportType = dr[colName].ToString();

                        ReportingTypeCountList.Add(reportinginfo);

                    }

                    result.ResultCode = 1;
                    result.ResultMessage = "Success";
                }
                else
                {
                    result.ResultMessage = "Reporting Not Found";
                    result.ResultCode = 1001;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

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
                          new SqlParameter("@incident_type", SqlDbType.VarChar) { Value = reportinginfo.ReportType },
                          new SqlParameter("@person_involved", SqlDbType.VarChar) { Value = reportinginfo.PersonInvolved },
                           new SqlParameter("@department_id", SqlDbType.Int) { Value = reportinginfo.DepartmentId },
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



        public static Result UpdateTrackingIncidentInfo(BLCompliance.Model.reportinginfo reportinginfo, out Model.reportinginfo objincident)
        {
            objincident = null;
            object IncidentId = 0;
            Result result = new Result(0, false, "update incident info fails");
            try
            {
                SqlParameter[] parameters =
                        {    
                          new SqlParameter("@id", SqlDbType.VarChar) { Value = reportinginfo.IncidentId },
                          new SqlParameter("@resolution", SqlDbType.VarChar) { Value = reportinginfo.Resolution },
                          new SqlParameter("@incident_status", SqlDbType.VarChar) { Value = reportinginfo.Status },
                          new SqlParameter("@closed_date", SqlDbType.DateTime) { Value = reportinginfo.IncidentDateClosed },
                          new SqlParameter("@update_by", SqlDbType.Int) { Value = reportinginfo.create_by }
                        };

                CData.ExecuteScalar(CommandType.StoredProcedure, "sp_comp_tbl_incident_Update", parameters);


                result.ResultCode = 1;
                result.ResultMessage = "Success";



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

        public static Result ReportingDelete(int id)
        {
            Result result = new Result(0, false, "Delete Reporting Information fails");
            try
            {

                SqlParameter[] prms =
                        {    
                          new SqlParameter("@IncidentId", SqlDbType.Int) { Value = id }
                         
                        };

                CData.ExecuteNonQuery(CommandType.StoredProcedure, "sp_comp_tbl_incident_Delete", prms);

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
