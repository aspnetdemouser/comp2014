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

    private void SetFacilityInfo(BLCompliance.Model.employee employee)
    {
        lblFacilityName.Text = employee.FacilityName;
        employee_contact_info contactInfo = null;
        Result result = BLContactInfo.GetEmployeeContactInfo(employee.EmailAddress, out contactInfo);
        if (result.ResultCode == 1 && contactInfo != null)
        {
            lblEmpName.Text = contactInfo.FirstName;
        }
       
    }
    protected void lnkProfileC_Click(object sender, EventArgs e)
    {
        if (Session["emp2014br2"] != null)
        {
            employee employee = Session["emp2014br2"] as employee;

            var bytes = Encoding.UTF8.GetBytes(employee.Id.ToString());
            var base64 = Convert.ToBase64String(bytes);
            Response.Redirect("emploeeprofile.aspx?enc=" + base64);
        }
    }
}
