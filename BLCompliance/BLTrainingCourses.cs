using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using BLCompliance.Model;

namespace BLCompliance
{
    public class BLTrainingCourses
    {

        public static Result GetAllActiveTrainingCourses(out List<BLCompliance.Model.TrainingCourse> courses)
        {
            courses = new List<Model.TrainingCourse>();
            Result result = new Result(0, false, "GetAllActiveTrainingCourses");

            DataSet ds = null;

            try
            {
                SqlParameter[] prms = new SqlParameter[0];


                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_compliance_get_active_training_courses", prms);

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        Model.TrainingCourse course = new Model.TrainingCourse();



                        course.course_id = int.Parse(dr["course_id"].ToString());

                        string colName = "course_title";

                        if (!CheckNullOrBlank(dr, colName))
                            course.course_title = dr[colName].ToString();


                        colName = "create_by";
                        if (!CheckNullOrBlank(dr, colName))
                            course.create_by = Convert.ToInt32(dr[colName].ToString());

                        colName = "update_by";
                        if (!CheckNullOrBlank(dr, colName))
                            course.update_by = Convert.ToInt32(dr[colName].ToString());


                        colName = "is_deleted";
                        if (!CheckNullOrBlank(dr, colName))
                            course.is_deleted = Convert.ToBoolean(dr[colName].ToString());

                        colName = "is_active_record";
                        if (!CheckNullOrBlank(dr, colName))
                            course.is_active_record = Convert.ToBoolean(dr[colName].ToString());


                        colName = "update_date";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                course.update_date = tempData;
                            }
                        }

                        colName = "create_date";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                course.create_date = tempData;
                            }
                        }

                        courses.Add(course);
                    }
                    result.ResultCode = 1;
                    result.ResultMessage = "Success";


                }
                else
                {
                    result.ResultMessage = "Courses Not Found";
                    result.ResultCode = 1001;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public static Result GetUnAssingedUserList(int courseId, out List<BLCompliance.Model.TraningCourseUsers> unAssignedUsers)
        {
            unAssignedUsers = new List<Model.TraningCourseUsers>();
            Result result = new Result(0, false, "GetUnAssingedUserList For Given Course");

            DataSet ds = null;

            try
            {

                SqlParameter[] prms = new SqlParameter[2];
                prms[0] = new SqlParameter("@course_id", SqlDbType.Int);
                prms[0].Value = courseId;

                prms[1] = new SqlParameter("@facility_id", SqlDbType.Int);
                prms[1].Value = System.DBNull.Value;



                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_compliance_get_training_users_to_assign_to_course", prms);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        Model.TraningCourseUsers user = new Model.TraningCourseUsers();
                        user.EmployeeId = int.Parse(dr["employeeid"].ToString());
                        user.CourseId = int.Parse(dr["course_id"].ToString());


                        string colName = "firstname";

                        if (!CheckNullOrBlank(dr, colName))
                            user.EmployeeName = dr[colName].ToString();

                        colName = "facility_id";
                        if (!CheckNullOrBlank(dr, colName))
                            user.FacilityId = int.Parse(dr[colName].ToString());

                        colName = "lastname";
                        if (!CheckNullOrBlank(dr, colName))
                            user.EmployeeName = user.EmployeeName + " " + dr[colName].ToString();

                        colName = "course_name";
                        if (!CheckNullOrBlank(dr, colName))
                            user.CourseName = dr[colName].ToString();

                        colName = "email_address";
                        if (!CheckNullOrBlank(dr, colName))
                            user.EmailAddress = dr[colName].ToString();

                        unAssignedUsers.Add(user);
                    }
                    result.ResultCode = 1;
                    result.ResultMessage = "Success";


                }
                else
                {
                    result.ResultMessage = "Courses Not Found";
                    result.ResultCode = 1001;
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            return result;
        }

        public static Result AssignUserToCourse(int courseId, int employeeId, int user_by, DateTime dueDate)
        {
            Result result = new Result(0, false, "Failed Assign User To Course");
            try
            {

                SqlParameter[] prms = new SqlParameter[6];
                prms[0] = new SqlParameter("@id", SqlDbType.Int);
                prms[0].Value = System.DBNull.Value;

                prms[1] = new SqlParameter("@course_id", SqlDbType.Int);
                prms[1].Value = courseId;

                prms[2] = new SqlParameter("@employee_id", SqlDbType.Int);
                prms[2].Value = employeeId;

                prms[3] = new SqlParameter("@user_by", SqlDbType.Int);
                prms[3].Value = user_by;

                prms[4] = new SqlParameter("@status_id", SqlDbType.Int);
                prms[4].Value = System.DBNull.Value;

                prms[5] = new SqlParameter("@due_date", SqlDbType.DateTime);
                if (dueDate == DateTime.MinValue)
                {
                    prms[5].Value = System.DBNull.Value;
                }
                else
                {
                    prms[5].Value = dueDate;
                }

                CData.ExecuteNonQuery(CommandType.StoredProcedure, "sp_compliance_assign_user_to_training_course", prms);
                result.ResultCode = 1;
                result.ResultMessage = "Success";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public static Result UnAssignUserToCourse(int courseId, int employeeId, int user_by)
        {
            Result result = new Result(0, false, "Failed Assign User To Course");
            try
            {

                SqlParameter[] prms = new SqlParameter[2];

                prms[0] = new SqlParameter("@count_id", SqlDbType.Int);
                prms[0].Value = courseId;

                prms[1] = new SqlParameter("@emp_id", SqlDbType.Int);
                prms[1].Value = employeeId;

                CData.ExecuteNonQuery(CommandType.StoredProcedure, "sp_compliance_remove_assignments_from_course", prms);
                result.ResultCode = 1;
                result.ResultMessage = "Success";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        public static Result GetEmployeesUnderCourse(int courseId, out List<BLCompliance.Model.TraningCourseUsers> assignedUsers)
        {
            Result result = new Result(0, false, "GetEmployeesUnderCourse");
            assignedUsers = new List<TraningCourseUsers>();
            try
            {
                SqlParameter[] prms = new SqlParameter[1];
                prms[0] = new SqlParameter("@course_id", SqlDbType.Int);
                prms[0].Value = courseId;

                DataSet ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_compliance_get_employees_under_course", prms);
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        Model.TraningCourseUsers user = new Model.TraningCourseUsers();
                        user.EmployeeId = int.Parse(dr["employeeid"].ToString());
                        user.CourseId = int.Parse(dr["course_id"].ToString());

                        string colName = "firstname";

                        if (!CheckNullOrBlank(dr, colName))
                            user.EmployeeName = dr[colName].ToString();

                        colName = "facility_id";
                        if (!CheckNullOrBlank(dr, colName))
                            user.FacilityId = int.Parse(dr[colName].ToString());

                        colName = "lastname";
                        if (!CheckNullOrBlank(dr, colName))
                            user.EmployeeName = user.EmployeeName + " " + dr[colName].ToString();

                        colName = "course_name";
                        if (!CheckNullOrBlank(dr, colName))
                            user.CourseName = dr[colName].ToString();

                        colName = "email_address";
                        if (!CheckNullOrBlank(dr, colName))
                            user.EmailAddress = dr[colName].ToString();

                        colName = "due_date";
                        if (!CheckNullOrBlank(dr, colName))
                        {
                            DateTime tempData;
                            if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                            {
                                user.DueDate = tempData;
                            }
                        }

                        assignedUsers.Add(user);
                    }
                }

                result.ResultCode = 1;
                result.ResultMessage = "Success";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        

        /// <summary>
        /// Get training assignments to me (logged in employee)
        /// </summary>
        /// <param name="employeeId"></param>
        /// <param name="myTrainingAssignments"></param>
        /// <returns></returns>
        public static Result GetMyTrainingAssignmetns(int employeeId, out List<BLCompliance.Model.TraningCourseUsers> myTrainingAssignments)
        {
            myTrainingAssignments = new List<Model.TraningCourseUsers>();
            Result result = new Result(0, false, "GetMyTrainingAssignmetns");

            DataSet ds = null;

            try
            {

                SqlParameter[] prms = new SqlParameter[1];
                prms[0] = new SqlParameter("@emp_id", SqlDbType.Int);
                prms[0].Value = employeeId;


                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_comp_get_training_assigments_to_me", prms);

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        Model.TraningCourseUsers ta = new Model.TraningCourseUsers();
                        PopulateTrainingAssignMentFromDataRow(ref ta, dr);
                        myTrainingAssignments.Add(ta);
                    }
                    result.ResultCode = 1;
                    result.ResultMessage = "Success";


                }
                else
                {
                    result.ResultMessage = "Courses Not Found";
                    result.ResultCode = 1001;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        /// <summary>
        /// Get training assignments all ( level 2)
        /// 2 = completed
        /// 1 = not completed
        /// </summary>
        /// <param name="employeeId"></param>
        /// <param name="completionStatus"></param>
        /// <param name="myTrainingAssignments"></param>
        /// <returns></returns>
        public static Result GetAllTrainingAssignments(int employeeId, int completionStatus, out List<BLCompliance.Model.TraningCourseUsers> myTrainingAssignments)
        {
            myTrainingAssignments = new List<Model.TraningCourseUsers>();
            Result result = new Result(0, false, "GetAllTrainingAssignments");

            DataSet ds = null;

            try
            {

                SqlParameter[] prms = new SqlParameter[2];
                prms[0] = new SqlParameter("@created_by", SqlDbType.Int);
                prms[0].Value = employeeId;

                prms[1] = new SqlParameter("@completion_status", SqlDbType.Int);
                prms[1].Value = completionStatus;


                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_comp_get_training_assigments_to_manage", prms);

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        Model.TraningCourseUsers ta = new Model.TraningCourseUsers();
                        PopulateTrainingAssignMentFromDataRow(ref ta, dr);
                        myTrainingAssignments.Add(ta);
                    }
                    result.ResultCode = 1;
                    result.ResultMessage = "Success";


                }
                else
                {
                    result.ResultMessage = " Not Found";
                    result.ResultCode = 1001;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

               


        /// <summary>
        /// Add new course master
        /// </summary>
        /// <param name="courseTitle"></param>
        /// <param name="createdBy"></param>
        /// <returns></returns>
        public static int AddCourse(string courseTitle, int createdBy)
        {

            int courseId = 0;
            try
            {

                if (!string.IsNullOrEmpty(courseTitle))
                {
                    SqlParameter[] prms = new SqlParameter[2];
                    prms[0] = new SqlParameter("@course_title", SqlDbType.VarChar);
                    prms[0].Value = courseTitle.Trim();

                    prms[1] = new SqlParameter("@create_by", SqlDbType.Int);
                    prms[1].Value = createdBy;

                    object returnData = CData.ExecuteScalar(CommandType.StoredProcedure, "sp_comp_insert_course", prms);
                    if (returnData != null)
                    {
                        int.TryParse(returnData.ToString(), out courseId);
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return courseId;
        }

        /// <summary>
        /// Get training assigned course for edit
        /// </summary>
        /// <param name="recordId"></param>
        /// <param name="assignedTraining"></param>
        /// <returns></returns>
        public static Result GetTrainingCourseToEdit(int recordId, out BLCompliance.Model.TraningCourseUsers assignedTraining)
        {
            assignedTraining = null;
            Result result = new Result(0, false, "GetTrainingCourseToEdit fails");
            DataSet ds = null;

            try
            {
                SqlParameter[] prms = new SqlParameter[1];
                prms[0] = new SqlParameter("@id", SqlDbType.Int);
                prms[0].Value = recordId;

                ds = CData.ExecuteDataset(CommandType.StoredProcedure, "sp_comp_get_training_assigments_by_id", prms);

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        Model.TraningCourseUsers ta = new Model.TraningCourseUsers();
                        PopulateTrainingAssignMentFromDataRow(ref ta, dr);
                        assignedTraining = ta;
                    }
                    result.ResultCode = 1;
                    result.ResultMessage = "Success";
                }
                else
                {
                    result.ResultMessage = "Assigned training Not Found";
                    result.ResultCode = 1001;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        /// <summary>
        /// Update training status to completed or not
        /// 1 = not completed, 2 = completed
        /// </summary>
        /// <param name="recordId"></param>
        /// <param name="statusId"></param>
        /// <param name="updateBy"></param>
        /// <returns></returns>
        public static void UpdateTrainingAssignedStatus(int recordId, int statusId , int updateBy)
        {
            try
            {
                if (recordId > 0 && updateBy > 0)
                {
                    SqlParameter[] prms = new SqlParameter[3];
                    prms[0] = new SqlParameter("@record_id", SqlDbType.Int);
                    prms[0].Value = recordId;

                    prms[1] = new SqlParameter("@update_by", SqlDbType.Int);
                    prms[1].Value = updateBy;

                    prms[2] = new SqlParameter("@status_id", SqlDbType.Int);
                    prms[2].Value = statusId;

                   CData.ExecuteNonQuery(CommandType.StoredProcedure, "sp_comp_update_training_completion_status", prms);

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public static void UpdateTrainingAssignmentById(int recordId, int statusId, int updateBy,DateTime dateAssigned, DateTime dateDue, int courseId)
        {
            try
            {
                if (recordId > 0 && updateBy > 0)
                {
                    SqlParameter[] prms = new SqlParameter[6];
                    prms[0] = new SqlParameter("@record_id", SqlDbType.Int);
                    prms[0].Value = recordId;

                    prms[1] = new SqlParameter("@update_by", SqlDbType.Int);
                    prms[1].Value = updateBy;

                    prms[2] = new SqlParameter("@status_id", SqlDbType.Int);
                    prms[2].Value = statusId;

                    prms[3] = new SqlParameter("@course_id", SqlDbType.Int);
                    if (courseId > 0)
                    {
                        prms[3].Value = courseId;
                    }
                    else
                    {
                        prms[3].Value = System.DBNull.Value;
                    }


                    prms[4] = new SqlParameter("@date_assigned", SqlDbType.DateTime);
                    if (dateAssigned != DateTime.MinValue)
                    {
                        prms[4].Value = dateAssigned;
                    }
                    else
                    {
                        prms[4].Value = System.DBNull.Value;
                    }


                    prms[5] = new SqlParameter("@date_due", SqlDbType.DateTime);
                    if (dateDue != DateTime.MinValue)
                    {
                        prms[5].Value = dateDue;
                    }
                    else
                    {
                        prms[5].Value = System.DBNull.Value;
                    }

                    CData.ExecuteNonQuery(CommandType.StoredProcedure, "sp_comp_update_training_completion_status", prms);

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

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

        private static void PopulateTrainingAssignMentFromDataRow(ref BLCompliance.Model.TraningCourseUsers assignedTraining, DataRow dr)
        {
            assignedTraining.CourseId = int.Parse(dr["course_id"].ToString());

            string colName = "course_title";

            if (!CheckNullOrBlank(dr, colName))
                assignedTraining.CourseName = dr[colName].ToString();

            colName = "emp_name";
            if (!CheckNullOrBlank(dr, colName))
                assignedTraining.EmployeeName = dr[colName].ToString();

            colName = "emp_id";
            assignedTraining.EmployeeId = int.Parse(dr[colName].ToString());

            colName = "ta_id";
            assignedTraining.TrainingAssignmentId = int.Parse(dr[colName].ToString());

            try
            {
                colName = "emp_type";
                assignedTraining.EmpType = int.Parse(dr[colName].ToString());
            }
            catch (Exception ex)
            {

            }
            colName = "completion_status";
            if (!CheckNullOrBlank(dr, colName))
                assignedTraining.CompletionStatus = int.Parse(dr[colName].ToString());


            colName = "date_assigned";
            if (!CheckNullOrBlank(dr, colName))
            {
                DateTime tempData;
                if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                {
                    assignedTraining.DateAssigned = tempData;
                }
            }

            colName = "due_date";
            if (!CheckNullOrBlank(dr, colName))
            {
                DateTime tempData;
                if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                {
                    assignedTraining.DueDate = tempData;
                }
            }
        }

        #endregion

    }
}




