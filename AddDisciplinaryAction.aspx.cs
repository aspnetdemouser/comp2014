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

                if (employee.EmployeeType != 2) //not level 2
                {
                    lnkActions.Visible = false;
                }


                if (Request.QueryString["enc"] != null)
                {
                    int selectedEmpId = GetSelectedEmployeeId();
                    if (selectedEmpId > 0)
                    {
                        ddlEmpName.SelectedValue = selectedEmpId.ToString();
                    }
                    SetNavigateUrl();
                }
                else if (Request.QueryString["edit"] != null)
                {
                    //edit 
                    int idToFind = GetRecordId();
                    if (idToFind > 0)
                    {
                        EditRecord(idToFind);
                        SetNavigateUrl();
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
            lit_readonly_emp_name.Text = ddlEmpName.SelectedItem.Text;
            ddlEmpName.Visible = false;
            //txtEmpName.Visible = true;
            lit_readonly_emp_name.Visible = true; //now we are showing in edit mode label
            //txtEmpName.ReadOnly = true;

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

    private void BindEmployees()
    {
        List<employee> employeeList = new List<employee>();
        BLCompliance.BLManageFacility.GetEmployees(0, "", true, out employeeList);

        employee empDummy = new employee();
        empDummy.Id = 0;
        empDummy.ContactName = "";
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

                    btnAddAction.Visible = false;
                    ddlEmpName.Visible = txtDateOfAction.Visible = txtDesc.Visible = txtInfraction.Visible = false;
                    txtInfraction.Width = 1;
                    txtDesc.Width = 1;
                    lit_readonly_emp_name.Text = ddlEmpName.SelectedItem.Text;
                    lit_readonly_date_of_action.Text = txtDateOfAction.Text;
                    lit_readonly_infraction.Text = txtInfraction.Text;
                    lit_readonly_action_taken.Text = txtDesc.Text;
                    //txtEmpName.Visible = false;
                    lit_readonly_action_taken.Visible = lit_readonly_date_of_action.Visible = lit_readonly_emp_name.Visible = lit_readonly_infraction.Visible = true;
                    hdnRecordId.Value = insertId.ToString();
                    btnEdit.Visible = true;
                    star1.Visible = star2.Visible = star3.Visible = false;
                    btnCancel.Visible = true;
                }
            }
            else
            {
                int idToFind = GetRecordId();
                if (idToFind > 0)
                {
                    hdnRecordId.Value = idToFind.ToString();
                    BLDisciplinaryAction.UpdateDisciplinaryActions(idToFind, selectedEmpId, infraction.Replace(Environment.NewLine, "<br/>"), dtAction, description.Replace(Environment.NewLine, "<br/>"), updateBy);
                    lbltxt.Text = "Disciplinary action updated successfully.";
                    btnAddAction.Visible =  false;
                    txtInfraction.Width = 1;
                    txtDesc.Width = 1;
                    ddlEmpName.Visible = txtDateOfAction.Visible = txtDesc.Visible = txtInfraction.Visible = false;
                    lit_readonly_emp_name.Text = ddlEmpName.SelectedItem.Text;
                    lit_readonly_date_of_action.Text = txtDateOfAction.Text;
                    lit_readonly_infraction.Text = txtInfraction.Text;
                    lit_readonly_action_taken.Text = txtDesc.Text;
                    lit_readonly_action_taken.Visible = lit_readonly_date_of_action.Visible = lit_readonly_emp_name.Visible = lit_readonly_infraction.Visible = true;
                    star1.Visible = star2.Visible = star3.Visible = false;
                    btnCancel.Visible = btnEdit.Visible = true;
                   // txtEmpName.Visible = false;
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

    private void SetNavigateUrl()
    {
        if (Request.QueryString["enc"] != null)
        {
            try
            {
                SetEmployeeInfo(GetSelectedEmployeeId());
            }
            catch (Exception exsetting2)
            {

            }

        }
        else
        {
            if (Request.QueryString["edit"] != null)
            {
                var bytes = Encoding.UTF8.GetBytes(ddlEmpName.SelectedValue.ToString());
                var base64 = Convert.ToBase64String(bytes);
                lnkActions.NavigateUrl = "ManageDisciplinaryAction.aspx?enc=" + base64;

                try
                {
                    SetEmployeeInfo(int.Parse(ddlEmpName.SelectedValue.ToString()));
                }
                catch (Exception exsetting2)
                {

                }
                lnkActions.NavigateUrl = "ManageDisciplinaryAction.aspx?enc=" + base64;
                lnkEmployeeInfo.NavigateUrl = "employeeprofile.aspx?enc=" + base64;

            }
            else
            {
                lnkActions.NavigateUrl = "manage_facility_employees.aspx";
            }
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        int recordId = 0;

        int.TryParse(hdnRecordId.Value, out recordId);
        if (recordId > 0)
        {
            var bytes = Encoding.UTF8.GetBytes(recordId.ToString());
            var base64 = Convert.ToBase64String(bytes);
            Response.Redirect("AddDisciplinaryAction.aspx?edit=" + base64);
        }
    }
}