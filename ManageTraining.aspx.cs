using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLCompliance;

public partial class ManageTraining : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] == null) // if logged in
        {
            Response.Redirect("login.aspx");
        }
    }

    [System.Web.Services.WebMethod]
    public static List<BLCompliance.Model.TraningCourseUsers> GetUserListForCourse(int cId)
    {
        List<BLCompliance.Model.TraningCourseUsers> users = new List<BLCompliance.Model.TraningCourseUsers>();
        BLCompliance.BLTrainingCourses.GetUnAssingedUserList(cId, out users);
        return users;
    }

    [System.Web.Services.WebMethod(true)]
    public static BLCompliance.Result AssignCourseToUser(int empId, int courseId)
    {
        Result result = new Result();
        BLCompliance.Model.employee empLoggedIn = HttpContext.Current.Session["emp2014br2"] as BLCompliance.Model.employee;
        BLCompliance.BLTrainingCourses.AssignUserToCourse(courseId, empId, empLoggedIn.Id);
        return result;
    }
}