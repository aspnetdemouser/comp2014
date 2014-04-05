using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using BLCompliance.Model;

namespace BLCompliance
{
    public class BLDisciplinaryAction
    {
        #region public methods

        public static Result GetDisciplinaryActions(int employeeId, out List<BLCompliance.Model.DisciplinaryAction> actionList)
        {
            actionList = new List<Model.DisciplinaryAction>();
            Result result = new Result(0, false, "get Disciplinary Actions fails");

            DataSet ds = null;

            try
            {
                SqlParameter[] prms = new SqlParameter[1];
                prms[0] = new SqlParameter("@emp_id", SqlDbType.Int);
                prms[0].Value = employeeId;

                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_comp_get_all_disciplinary_action", prms);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        DisciplinaryAction action = new DisciplinaryAction();
                        FillModelFromDataRow(dr, ref action);
                        actionList.Add(action);
                    }
                    result.ResultCode = 1;
                    result.ResultMessage = "Success";
                }
                else
                {
                    result.ResultMessage = "Not Found";
                    result.ResultCode = 1001;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public static Result GetDisciplinaryActionById(int recordId, out BLCompliance.Model.DisciplinaryAction disciplinaryAction)
        {
            disciplinaryAction = null;
            Result result = new Result(0, false, "Fail Get Disciplinary Action By Id");

            DataSet ds = null;

            try
            {
                SqlParameter[] prms = new SqlParameter[1];
                prms[0] = new SqlParameter("@id", SqlDbType.Int);
                prms[0].Value = recordId;

                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_comp_get_disciplinary_action_by_id", prms);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count == 1)
                    {
                        DataRow dr = ds.Tables[0].Rows[0];
                        disciplinaryAction = new DisciplinaryAction();
                        FillModelFromDataRow(dr, ref disciplinaryAction);

                        result.ResultCode = 1;
                        result.ResultMessage = "Success";
                    }
                    else
                    {
                        result.ResultMessage = string.Format("Only expected 1 record but {0} records found", ds.Tables[0].Rows.Count.ToString());
                        result.ResultCode = 1002;
                    }
                }
                else
                {
                    result.ResultMessage = "Not Found";
                    result.ResultCode = 1001;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public static Result InsertDisciplinaryActions(int employeeId, string infraction, DateTime dateOfAction, string actionDescription, int create_by, out int insertId)
        {
            Result result = new Result(0, false, "Failed Insert Disciplinary Actions");
            insertId = 0;
            try
            {

                SqlParameter[] prms = new SqlParameter[5];
                prms[0] = new SqlParameter("@emp_id", SqlDbType.Int);
                prms[0].Value = employeeId;

                prms[1] = new SqlParameter("@infraction", SqlDbType.VarChar);
                prms[1].Value = infraction;

                prms[2] = new SqlParameter("@date_of_action", SqlDbType.DateTime);
                prms[2].Value = dateOfAction.Date;

                prms[3] = new SqlParameter("@action_desc", SqlDbType.VarChar);
                prms[3].Value = actionDescription;

                prms[4] = new SqlParameter("@create_by", SqlDbType.Int);
                prms[4].Value = create_by;
                object id = CData.ExecuteScalar(CommandType.StoredProcedure, "sp_comp_insert_update_disciplinary_action", prms);
                if (id != null)
                    insertId = Convert.ToInt32(id.ToString());

                result.ResultCode = 1;
                result.ResultMessage = "Success";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public static Result UpdateDisciplinaryActions(int recordId, int employeeId, string infraction, DateTime dateOfAction, string actionDescription, int updateBy)
        {
            Result result = new Result(0, false, "Failed Update Disciplinary Actions");
           
            try
            {

                SqlParameter[] prms = new SqlParameter[6];
                int indx = 0;
                prms[indx] = new SqlParameter("@id", SqlDbType.Int);
                prms[indx].Value = recordId;
                indx = indx + 1;
                prms[indx] = new SqlParameter("@emp_id", SqlDbType.Int);
                prms[indx].Value = employeeId;
                indx = indx + 1;

                prms[indx] = new SqlParameter("@infraction", SqlDbType.VarChar);
                prms[indx].Value = infraction;
                indx = indx + 1;

                prms[indx] = new SqlParameter("@date_of_action", SqlDbType.DateTime);
                prms[indx].Value = dateOfAction.Date;
                indx = indx + 1;

                prms[indx] = new SqlParameter("@action_desc", SqlDbType.VarChar);
                prms[indx].Value = actionDescription;
                indx = indx + 1;

                prms[indx] = new SqlParameter("@update_by", SqlDbType.Int);
                prms[indx].Value = updateBy;
                
                
                CData.ExecuteNonQuery(CommandType.StoredProcedure, "sp_comp_insert_update_disciplinary_action", prms);
                

                result.ResultCode = 1;
                result.ResultMessage = "Success";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        #endregion

        #region private methods
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

        private static void FillModelFromDataRow(DataRow dr, ref DisciplinaryAction action)
        {
            action.Id = int.Parse(dr["id"].ToString());

            string colName = "emp_id";
            if (!CheckNullOrBlank(dr, colName))
                action.EmployeeId = int.Parse(dr[colName].ToString());

            colName = "emp_name";
            if (!CheckNullOrBlank(dr, colName))
                action.EmployeeName = dr[colName].ToString();

            colName = "infraction";
            if (!CheckNullOrBlank(dr, colName))
            {
                action.Infraction = dr[colName].ToString();
                action.Infraction_ShortText = action.Infraction;
                if (action.Infraction.Length > 50)
                {
                    action.Infraction_ShortText = action.Infraction.Substring(0, 48) + "...";
                }
            }

            colName = "action_desc";
            if (!CheckNullOrBlank(dr, colName))
            {
                action.ActionDescription = dr[colName].ToString();
                action.ActionDescription_ShortText = action.ActionDescription;
                if (action.ActionDescription.Length > 50)
                {
                    action.ActionDescription_ShortText = action.ActionDescription.Substring(0, 48) + "...";
                }
            }


            colName = "date_of_action";
            if (!CheckNullOrBlank(dr, colName))
            {
                DateTime tempData;
                if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                {
                    action.DateOfAction = tempData;
                }
            }

            colName = "create_date";
            if (!CheckNullOrBlank(dr, colName))
            {
                DateTime tempData;
                if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                {
                    action.CreatedDate = tempData;
                }
            }
        }
        #endregion
    }
}
