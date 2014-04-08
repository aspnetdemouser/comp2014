using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLCompliance.Model;
using BLCompliance;
using System.Text;

public partial class main : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] != null)
        {

            employee employee = Session["emp2014br2"] as employee;
            SetFacilityInfo(employee);
        }
    }

    public string fs_selected
    {
        get
        {
           return hdnFS.Value;
        }

        set
        {
            hdnFS.Value = value;
        }
    }

    public string ts_selected
    {
        get
        {
            return hdnTS.Value;
        }

        set
        {
            hdnTS.Value = value;
        }
    }

    private void SetFacilityInfo(BLCompliance.Model.employee employee)
    {
        lblFacilityName.Text = employee.FacilityName;
        employee_contact_info contactInfo = null;
        Result result = BLContactInfo.GetEmployeeContactInfo(employee.EmailAddress, out contactInfo);
        if (result.ResultCode == 1 && contactInfo != null)
        {
            string firstName = contactInfo.FirstName;
            if (contactInfo.FirstName.Length > 1)
            {
                try
                {
                    firstName = contactInfo.FirstName.Substring(0,1).ToUpper() + contactInfo.FirstName.Substring(1).ToLower();
                }
                catch(Exception ex0)
                {
                    firstName = contactInfo.FirstName;
                }
            }

            string lastName = contactInfo.LastName;
            if (contactInfo.LastName.Length > 1)
            {
                try
                {
                    lastName = contactInfo.LastName.Substring(0,1).ToUpper() + contactInfo.LastName.Substring(1).ToLower();
                }
                catch (Exception ex0)
                {
                    lastName = contactInfo.LastName;
                }
            }

            lblEmpName.Text = firstName + " " + lastName;
        }

    }
    protected void lnkProfileC_Click(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] != null)
        {
            employee employee = Session["emp2014br2"] as employee;

            var bytes = Encoding.UTF8.GetBytes(employee.Id.ToString());
            var base64 = Convert.ToBase64String(bytes);
            Response.Redirect("employeeprofile.aspx?enc=" + base64);
        }
    }
}
