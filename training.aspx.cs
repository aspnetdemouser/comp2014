using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLCompliance.Model;

public partial class training : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] != null)
        {
            employee employee = Session["emp2014br2"] as employee;
            if (employee.EmployeeType == 1)
            {
                BindEmployees(employee.Id);
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }
    private void BindEmployees(int empId)
    {
        List<TraningCourseUsers> employeeList = new List<TraningCourseUsers>();
        BLCompliance.BLTrainingCourses.GetMyTrainingAssignmetns(empId, out employeeList);

        gvTraining.DataSource = employeeList;
        gvTraining.DataBind();

        lblNoOfActions.Text = employeeList.Count().ToString();
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
                    if(empRow.CompletionStatus == 1)
                    {
                        (ctrl as Label).Text = "No"; // not completed.
                    }
                    else if (empRow.CompletionStatus == 2)
                    {
                        (ctrl as Label).Text = "Yes"; //  completed.
                    }
                }

            }


            if (empRow.DateAssigned.HasValue && empRow.DateAssigned.Value!= DateTime.MinValue)
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
}