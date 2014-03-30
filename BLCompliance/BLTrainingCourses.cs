using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

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
                throw ex;
            }
            return result;
        }

        public static Result AssignUserToCourse(int courseId, int employeeId, int user_by)
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
                prms[5].Value = System.DBNull.Value;

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

        /// <summary>
        /// Get training assignments to me (logged in employee)
        /// </summary>
        /// <param name="employeeId"></param>
        /// <param name="myTrainingAssignments"></param>
        /// <returns></returns>
        public static Result GetMyTrainingAssignmetns (int employeeId, out List<BLCompliance.Model.TraningCourseUsers> myTrainingAssignments)
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
        /// </summary>
        /// <param name="employeeId"></param>
        /// <param name="myTrainingAssignments"></param>
        /// <returns></returns>
        public static Result GetAllTrainingAssignments(int employeeId, out List<BLCompliance.Model.TraningCourseUsers> myTrainingAssignments)
        {
            myTrainingAssignments = new List<Model.TraningCourseUsers>();
            Result result = new Result(0, false, "GetAllTrainingAssignments");

            DataSet ds = null;

            try
            {

                SqlParameter[] prms = new SqlParameter[1];
                prms[0] = new SqlParameter("@created_by", SqlDbType.Int);
                prms[0].Value = employeeId;
                
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


        private static void PopulateTrainingAssignMentFromDataRow(ref BLCompliance.Model.TraningCourseUsers trainingAssigment, DataRow dr)
        {
            trainingAssigment.CourseId = int.Parse(dr["course_id"].ToString());

            string colName = "course_title";

            if (!CheckNullOrBlank(dr, colName))
                trainingAssigment.CourseName = dr[colName].ToString();

            colName = "emp_name";
            if (!CheckNullOrBlank(dr, colName))
                trainingAssigment.EmployeeName = dr[colName].ToString();

            colName = "emp_id";
            trainingAssigment.EmployeeId = int.Parse(dr[colName].ToString());

            colName = "ta_id";
            trainingAssigment.TrainingAssignmentId = int.Parse(dr[colName].ToString());

            colName = "completion_status";
            if (!CheckNullOrBlank(dr, colName))
                trainingAssigment.CompletionStatus = int.Parse(dr[colName].ToString());


            colName = "date_assigned";
            if (!CheckNullOrBlank(dr, colName))
            {
                DateTime tempData;
                if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                {
                    trainingAssigment.DateAssigned = tempData;
                }
            }

            colName = "due_date";
            if (!CheckNullOrBlank(dr, colName))
            {
                DateTime tempData;
                if (DateTime.TryParse(dr[colName].ToString(), out tempData))
                {
                    trainingAssigment.DueDate = tempData;
                }
            }
        }
    }
}




