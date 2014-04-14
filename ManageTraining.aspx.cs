using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLCompliance;
using BLCompliance.Model;

public partial class ManageTraining : System.Web.UI.Page
{
    protected void Page_PreInit(object sender, EventArgs e)
    {

        Control ht = this.Master.FindControl("hdnTS");
        if (ht != null)
        {
            if (ht is HiddenField)
            {
                HiddenField ht1 = ht as HiddenField;
                ht1.Value = "sel";
            }
        }

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] == null) // if logged in
        {
            Response.Redirect("login.aspx");
        }

        if (Page.IsPostBack == false)
        {
            GetAllTrainingAssignmentList();
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
        //BLCompliance.Model.employee empLoggedIn = HttpContext.Current.Session["emp2014br2"] as BLCompliance.Model.employee;
        //BLCompliance.BLTrainingCourses.AssignUserToCourse(courseId, empId, empLoggedIn.Id);
        return result;
    }

    private void GetAllTrainingAssignmentList()
    {

        if (Session["emp2014br2"] != null)
        {
            employee employee = Session["emp2014br2"] as employee;

            if (employee.EmployeeType == 2) //level 2 user
            {

                List<TraningCourseUsers> employeeList = new List<TraningCourseUsers>();
                if (chkActive.Checked)
                {
                    BLCompliance.BLTrainingCourses.GetAllTrainingAssignments(employee.Id, 1, out employeeList);
                }
                else
                {
                    BLCompliance.BLTrainingCourses.GetAllTrainingAssignments(employee.Id, 0, out employeeList);
                }
                gvTraining.DataSource = employeeList;
                gvTraining.DataBind();

                SetFacilityInfo(employee);
            }
        }
    }
    protected void gvTraining_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TraningCourseUsers empRow = e.Row.DataItem as TraningCourseUsers;
            Control ctrl = e.Row.FindControl("lblCompleted");

            if (ctrl != null)
            {
                if (ctrl is Label)
                {
                    if (empRow.CompletionStatus == 1)
                    {
                        (ctrl as Label).Text = "No"; // not completed.
                    }
                    else if (empRow.CompletionStatus == 2)
                    {
                        (ctrl as Label).Text = "Yes"; //  completed.
                    }
                }

            }


            if (empRow.DateAssigned.HasValue && empRow.DateAssigned.Value != DateTime.MinValue)
            {
                ctrl = e.Row.FindControl("lblDateAssigned");

                if (ctrl != null)
                {
                    if (ctrl is Label)
                    {
                        (ctrl as Label).Text = empRow.DateAssigned.Value.ToString("MMM dd, yyyy");
                    }

                }
            }

            if (empRow.DueDate.HasValue && empRow.DueDate.Value != DateTime.MinValue)
            {
                ctrl = e.Row.FindControl("lblDueDate");

                if (ctrl != null)
                {
                    if (ctrl is Label)
                    {
                        (ctrl as Label).Text = empRow.DueDate.Value.ToString("MMM dd, yyyy");
                    }

                }
            }

        }
    }
    protected void gvTraining_PageIndexChanged(object sender, EventArgs e)
    {




    }
    protected void gvTraining_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvTraining.PageIndex = e.NewPageIndex;
        GetAllTrainingAssignmentList();
    }

    protected void chkActive_CheckedChanged(object sender, EventArgs e)
    {
        GetAllTrainingAssignmentList();
    }

    private void SetFacilityInfo(BLCompliance.Model.employee employee)
    {
        lblFacilityName.Text = employee.FacilityName;

        employee_contact_info contactInfo = null;
        Result result = BLContactInfo.GetEmployeeContactInfo(employee.EmailAddress, out contactInfo);
        if (result.ResultCode == 1 && contactInfo != null)
        {

            if (!string.IsNullOrEmpty(contactInfo.State))
            {
                lblInfo1.Text = string.Format("{0} - {1}, {2}", employee.FacilityName, contactInfo.City, contactInfo.State);
            }
            else
            {
                lblInfo1.Text = string.Format("{0} - {1}", "", employee.FacilityName, contactInfo.City);
            }

            lblCityStateZip.Text = string.Format("{0}, {1}, {2}", contactInfo.City, contactInfo.State, contactInfo.ZipCode);
            lblCountry.Text = contactInfo.CountryName;
        }


    }
}
