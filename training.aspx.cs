using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLCompliance.Model;
using System.Text;

public partial class training : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] != null)
        {
            employee employee = Session["emp2014br2"] as employee;
            if (employee.EmployeeType == 1)
            {
                //this is for level1 emp only
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
        //get training assigned to me  (my login)
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
    protected void gvTraining_PageIndexChanged(object sender, EventArgs e)
    {
        
        
        
        
    }
    protected void gvTraining_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvTraining.PageIndex = e.NewPageIndex;
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
    protected void gvTraining_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.ToLower() == "edit")
        {
            int recordId = int.Parse(e.CommandArgument.ToString());
            var bytes = Encoding.UTF8.GetBytes(recordId.ToString());
            var base64 = Convert.ToBase64String(bytes);
            Response.Redirect("AssignTraining.aspx?edit=" + base64);
        }
    }
}