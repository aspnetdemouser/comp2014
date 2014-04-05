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

    private void GetActionList()
    {

        if (Session["emp2014br2"] != null)
        {
            employee employee = Session["emp2014br2"] as employee;
            if (employee.EmployeeType == 2) //level 2 user
            {
                List<DisciplinaryAction> actionList = new List<DisciplinaryAction>();
                BLCompliance.BLDisciplinaryAction.GetDisciplinaryActions(GetSelectedEmployeeId(), out actionList);
                gvTraining.DataSource = actionList;
                gvTraining.DataBind();
                SetFacilityInfo(employee);
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