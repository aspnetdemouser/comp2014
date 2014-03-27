using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;


public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void txtPassword_TextChanged(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        lblErr.Visible = false;
        Validate("login");
       
        if (Page.IsValid)
        {
            BLCompliance.Model.employee employee;
            BLCompliance.Result result = BLCompliance.Login.GetEmployee(txtEmail.Text.Trim(), txtPassword.Text.Trim(), out employee);

            if (employee != null && result.ResultCode == 1)
            {
                Session["emp2014br2"] = employee;

                //level 2 user
                if (employee.EmployeeType == 2)
                {
                    Response.Redirect("manage_facility_employees.aspx");
                }
                else
                {

                    var bytes = Encoding.UTF8.GetBytes(employee.Id.ToString());
                    var base64 = Convert.ToBase64String(bytes);
                    Response.Redirect("employeeprofile.aspx?enc=" + base64);

                }
            }
            else
            {
                lblErr.Visible = true;
            }
        }

    }
}