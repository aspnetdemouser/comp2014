using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLCompliance;
using BLCompliance.Model;
using System.Text;
public partial class manage_facility_employees : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] != null)
        {
            employee employee = Session["emp2014br2"] as employee;

            if (employee.EmployeeType == 1) //level 1 emp
            {
                var bytes = Encoding.UTF8.GetBytes(employee.Id.ToString());
                var base64 = Convert.ToBase64String(bytes);
                Response.Redirect("employeeprofile.aspx?enc=" + base64);
            }
            else
            {
                SetFacilityInfo(employee);
                if (!IsPostBack)
                    BindEmployees();
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }

    private void SetFacilityInfo(BLCompliance.Model.employee employee)
    {
        lblFacilityName.Text = employee.FacilityName;

        employee_contact_info contactInfo = null;
        Result result = BLContactInfo.GetEmployeeContactInfo(employee.EmailAddress, out contactInfo);
        if (result.ResultCode == 1 && contactInfo != null)
        {

            //if (!string.IsNullOrEmpty(contactInfo.State))
            //{
            //    lblInfo1.Text = string.Format("{0} - {1}, {2}", employee.FacilityName, contactInfo.City, contactInfo.State);
            //}
            //else
            //{
            //    lblInfo1.Text = string.Format("{0} - {1}", "", employee.FacilityName, contactInfo.City);
            //}

            lblCityStateZip.Text = string.Format("{0}, {1}, {2}", contactInfo.City, contactInfo.State, contactInfo.ZipCode);
            lblCountry.Text = contactInfo.CountryName;
        }


    }

    private void BindEmployees()
    {
        List<employee> employeeList = new List<employee>();
        BLCompliance.BLManageFacility.GetEmployees(0, search_text.Text.Trim(), chkActive.Checked, out employeeList);
        gvEmployees.DataSource = employeeList;
        gvEmployees.DataBind();
    }

    protected void btnSearchSubmit_Click(object sender, EventArgs e)
    {
        //search by last name
        BindEmployees();
        //List<employee> employeeList = new List<employee>();
        //BLCompliance.BLManageFacility.GetEmployees(0, search_text.Text.Trim(), chkActive.Checked, out employeeList);
        //gvEmployees.DataSource = employeeList;
        //gvEmployees.DataBind();

    }

    protected void gvEmployees_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            employee empRow = e.Row.DataItem as employee;
            Control ctrl = e.Row.FindControl("lblLicNumberAndExp");

            if (ctrl != null)
            {
                if (ctrl is Label)
                {
                    (ctrl as Label).Text = empRow.Licence_Number + " " + (empRow.Licence_Expiry.HasValue ? empRow.Licence_Expiry.Value.ToString("MMM dd, yyyy") : string.Empty);
                }

            }

        }
    }

    protected void gvEmployees_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.ToLower() == "editemployee")
        {
            int selectedEmpId = int.Parse(e.CommandArgument.ToString());
            var bytes = Encoding.UTF8.GetBytes(selectedEmpId.ToString());
            var base64 = Convert.ToBase64String(bytes);
            Response.Redirect("employeeprofile.aspx?enc=" + base64);

        }
        else if (e.CommandName.ToLower() == "deleteemployee")
        {
            employee employee = Session["emp2014br2"] as employee;

            int selectedEmpId = int.Parse(e.CommandArgument.ToString());
            DeleteEmployees(selectedEmpId, employee.Id);

        }
    }

    private void DeleteEmployees(int id, int updatedBy)
    {
        BLCompliance.BLContactInfo.DeleteContactInfo(id, updatedBy);
        BindEmployees();

    }

    protected void imgRemoveEmp_Click(object sender, EventArgs e)
    {
        string ids = string.Empty;
        employee employee = Session["emp2014br2"] as employee;

        foreach (GridViewRow row in gvEmployees.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox ChkBoxRows = (CheckBox)row.FindControl("chkboxSelectEmp");
                if (ChkBoxRows.Checked)
                    ids += gvEmployees.DataKeys[row.RowIndex].Value + ",";


            }
        }

        if (!string.IsNullOrEmpty(ids))
        {
            ids = ids.Substring(0, ids.Length - 1);
            BLCompliance.BLContactInfo.DeleteEmployees(ids, employee.Id);
            BindEmployees();
        }
    }
    protected void btnResetSearch_Click(object sender, ImageClickEventArgs e)
    {
        search_text.Text = string.Empty;
        BindEmployees();

    }
    protected void chkActive_CheckedChanged(object sender, EventArgs e)
    {
        BindEmployees();
    }
    protected void gvEmployees_PageIndexChanged(object sender, EventArgs e)
    {

    }
    protected void gvEmployees_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvEmployees.PageIndex = e.NewPageIndex;
        BindEmployees();
    }
}