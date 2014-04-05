using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLCompliance.Model;
using BLCompliance;
using System.Globalization;
using System.Text;

public partial class AddDisciplinaryAction : System.Web.UI.Page
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
        if (Session["emp2014br2"] == null)
        {
            Response.Redirect("login.aspx");
        }
        if (!IsPostBack)
        {
            BindEmployees();

            if (Session["emp2014br2"] != null)
            {
                employee employee = Session["emp2014br2"] as employee;
                if (employee.EmployeeType == 2)
                {
                    SetFacilityInfo(employee);
                }

                if (Request.QueryString["enc"] != null)
                {
                    int selectedEmpId = GetSelectedEmployeeId();
                    if (selectedEmpId > 0)
                    {
                        ddlEmpName.SelectedValue = selectedEmpId.ToString();
                    }
                }
                else if (Request.QueryString["edit"] != null)
                {
                    //edit 
                    int idToFind = GetRecordId();
                    if (idToFind > 0)
                    {
                        EditRecord(idToFind);
                    }
                }
            }
        }
    }

    private void EditRecord(int id)
    {
        DisciplinaryAction action = null;
        Result result = BLDisciplinaryAction.GetDisciplinaryActionById(id, out action);
        if (result.ResultCode == 1 && action != null)
        {
            ddlEmpName.SelectedValue = action.EmployeeId.ToString();
            ddlEmpName.Enabled = false;
            txtDateOfAction.Text = action.DateOfAction.ToString("MM/dd/yyyy");
            txtInfraction.Text = action.Infraction.Replace("<br/>", Environment.NewLine);
            txtDesc.Text = action.ActionDescription.Replace("<br/>", Environment.NewLine);
        }
    }
    protected int GetSelectedEmployeeId()
    {
        int employeeId = 0;
        if (Request.QueryString["enc"] != null)
        {
            byte[] data = Convert.FromBase64String(Request.QueryString["enc"].ToString());
            string decodedString = Encoding.UTF8.GetString(data);
            int.TryParse(decodedString, out employeeId);
        }
        return employeeId;
    }

    protected int GetRecordId()
    {
        int recordId = 0;
        if (Request.QueryString["edit"] != null)
        {
            byte[] data = Convert.FromBase64String(Request.QueryString["edit"].ToString());
            string decodedString = Encoding.UTF8.GetString(data);
            int.TryParse(decodedString, out recordId);
        }
        return recordId;
    }

    private void SetFacilityInfo(BLCompliance.Model.employee employee)
    {
        lblFacilityName.Text = employee.FacilityName;
        employee_contact_info contactInfo = null;
        Result result = BLContactInfo.GetEmployeeContactInfo(employee.EmailAddress, out contactInfo);
        if (result.ResultCode == 1 && contactInfo != null)
        {
                  
            lblCityStateZip.Text = string.Format("{0}, {1}, {2}", contactInfo.City, contactInfo.State, contactInfo.ZipCode);
            lblCountry.Text = contactInfo.CountryName;
        }
    }

    private void BindEmployees()
    {
        List<employee> employeeList = new List<employee>();
        BLCompliance.BLManageFacility.GetEmployees(0,"", true, out employeeList);
        
        employee empDummy = new employee();
        empDummy.Id=0;
        empDummy.ContactName="";
        employeeList.Insert(0, empDummy);

        ddlEmpName.DataSource = employeeList;
        ddlEmpName.DataValueField = "Id";
        ddlEmpName.DataTextField = "ContactName";
        ddlEmpName.DataBind();
        ddlEmpName.SelectedIndex = 0;
    }
    protected void btnAddAction_Click(object sender, EventArgs e)
    {
        lbltxt.Text = "";

        if (Session["emp2014br2"] != null)
        {
            employee employee = Session["emp2014br2"] as employee;
           
            int createBy = employee.Id;
            int updateBy = employee.Id;

            string infraction = txtInfraction.Text.Trim();
            string description = txtDesc.Text.Trim();
            string dateOfAction = txtDateOfAction.Text.Trim();
            DateTime dtAction = DateTime.MinValue;
            if (ddlEmpName.SelectedValue.ToString() == "" || ddlEmpName.SelectedValue.ToString() == "0")
            {
                lbltxt.Text = "Please fill all required inputs.";
                return;
            }
            
            int selectedEmpId = int.Parse(ddlEmpName.SelectedValue);

            if (string.IsNullOrEmpty(infraction) || string.IsNullOrEmpty(description) || string.IsNullOrEmpty(dateOfAction))
            {
                lbltxt.Text = "Please fill all required inputs.";
                return;
            }
            if (!string.IsNullOrEmpty(dateOfAction))
            {
                DateTime tempDate;
                if (DateTime.TryParseExact(dateOfAction, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                {
                    dtAction = tempDate;
                }
                else if (DateTime.TryParseExact(dateOfAction, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate))
                {
                    dtAction = tempDate;
                }

            }

            int insertId = 0;
            if (Request.QueryString["edit"] == null)
            {
                BLDisciplinaryAction.InsertDisciplinaryActions(selectedEmpId, infraction.Replace(Environment.NewLine, "<br/>"), dtAction, description.Replace(Environment.NewLine, "<br/>"), createBy, out insertId);
                if (insertId > 0)
                {
                    lbltxt.Text = "Disciplinary action added successfully.";

                }
            }
            else
            {
                int idToFind = GetRecordId();
                if (idToFind > 0)
                {
                    BLDisciplinaryAction.UpdateDisciplinaryActions(idToFind, selectedEmpId, infraction.Replace(Environment.NewLine, "<br/>"), dtAction, description.Replace(Environment.NewLine, "<br/>"), updateBy);
                    lbltxt.Text = "Disciplinary action updated successfully.";
                }
            }
            
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["enc"] != null)
        {
            Response.Redirect("ManageDisciplinaryAction.aspx?enc=" + Request.QueryString["enc"].ToString());
        }
        else
        {
            if (Request.QueryString["edit"] != null)
            {
                var bytes = Encoding.UTF8.GetBytes(ddlEmpName.SelectedValue.ToString());
                var base64 = Convert.ToBase64String(bytes);
                Response.Redirect("ManageDisciplinaryAction.aspx?enc=" + base64);

            }
            else
            {

                Response.Redirect("manage_facility_employees.aspx");
            }
        }
    }
}