using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLCompliance;
using BLCompliance.Model;

public partial class controls_training_courses_listing : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] != null) // if logged in
        {
            BLCompliance.Model.employee employee = Session["emp2014br2"] as BLCompliance.Model.employee;
            if (employee.EmployeeType == 2) // level 2
            {
                BindCourses();
                SetFacilityInfo(employee);
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }

    }

    private void BindCourses()
    {
        List<TrainingCourse> courses = new List<TrainingCourse>();
        BLCompliance.BLTrainingCourses.GetAllActiveTrainingCourses(out courses);

        rptData.DataSource = courses;
        rptData.DataBind();
    }
    protected void rptData_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        rptData.CurrentPageIndex = e.NewPageIndex;
        BindCourses();
    }
    private void SetFacilityInfo(BLCompliance.Model.employee employee)
    {
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
        }
    }
}