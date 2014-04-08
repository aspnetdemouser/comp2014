using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLCompliance.Model;
using System.Text;
using BLCompliance;

public partial class ManageDisciplinaryAction : System.Web.UI.Page
{
    protected void Page_PreInit(object sender, EventArgs e)
    {

        Control hf = this.Master.FindControl("hdnFS");
        if (hf != null)
        {
            if (hf is HiddenField)
            {
                HiddenField hf1 = hf as HiddenField;
                hf1.Value = "sel";
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
            GetActionList();
        }
    }

    protected void gvTraining_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DisciplinaryAction empRow = e.Row.DataItem as DisciplinaryAction;

            if (empRow.DateOfAction != DateTime.MinValue)
            {
                Control ctrl = e.Row.FindControl("lblDateAssigned");

                if (ctrl != null)
                {
                    if (ctrl is Label)
                    {
                        (ctrl as Label).Text = empRow.DateOfAction.ToString("MMM dd, yyyy");
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
        GetActionList();
    }

    private void SetEmployeeInfo(int selectedEmployeeId)
    {
        employee_contact_info contactInfo = null;
        Result result = BLContactInfo.GetEmployeeContactInfo(selectedEmployeeId, out contactInfo);
        if (result.ResultCode == 1 && contactInfo != null)
        {
            namespan.InnerText = contactInfo.FirstName + " " + contactInfo.LastName;
        }
        if (Request.QueryString["enc"] != null)
        {
            lnkActions.NavigateUrl = "ManageDisciplinaryAction.aspx?enc=" + Request.QueryString["enc"].ToString();
            lnkEmployeeInfo.NavigateUrl = "employeeprofile.aspx?enc=" + Request.QueryString["enc"].ToString();
        }
    }

    private void GetActionList()
    {

        if (Session["emp2014br2"] != null)
        {
            employee employee = Session["emp2014br2"] as employee;
            if (employee.EmployeeType == 2) //level 2 user
            {
                int selectedEmpoyeeId = 0;
                selectedEmpoyeeId = GetSelectedEmployeeId();
                List<DisciplinaryAction> actionList = new List<DisciplinaryAction>();
                BLCompliance.BLDisciplinaryAction.GetDisciplinaryActions(selectedEmpoyeeId, out actionList);
                gvTraining.DataSource = actionList;
                gvTraining.DataBind();
                
                SetEmployeeInfo(selectedEmpoyeeId);
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }

    protected int GetSelectedEmployeeId()
    {
        int employeeId = 0;
        lnkAddDiscAction.NavigateUrl = "AddDisciplinaryAction.aspx";
        if (Request.QueryString["enc"] != null)
        {
            lnkAddDiscAction.NavigateUrl = "AddDisciplinaryAction.aspx?enc=" + Request.QueryString["enc"].ToString();

            byte[] data = Convert.FromBase64String(Request.QueryString["enc"].ToString());
            string decodedString = Encoding.UTF8.GetString(data);
            int.TryParse(decodedString, out employeeId);
        }
        return employeeId;
    }
    protected void gvTraining_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.ToLower() == "edit")
        {
            int recordId = int.Parse(e.CommandArgument.ToString());
            var bytes = Encoding.UTF8.GetBytes(recordId.ToString());
            var base64 = Convert.ToBase64String(bytes);
            Response.Redirect("AddDisciplinaryAction.aspx?edit=" + base64);

        }
    }
}