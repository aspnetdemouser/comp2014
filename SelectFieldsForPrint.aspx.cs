using System;


public partial class SelectFieldsForPrint : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        string fields = string.Empty;

        if (chkUserName.Checked)
            fields += "e.[email_address], ";

        if (chkAddress.Checked)
            fields += "c.[Address_line1], c.[Address_line2], ";

        if (chkTelephone.Checked)
            fields += "c.[Tele_phone], ";

        if (chkJobTitle.Checked)
            fields += "e.[Position], ";

        if (chkEmployeeType.Checked)
            fields += "e.[Employee_Type_Text], ";

        if (chkDateOfHire.Checked)
            fields += "e.[Date_Of_Hire], ";

        if (chkLicense.Checked)
            fields += "e.[Licence_Number], ";

        if (chkLicenseExp.Checked)
            fields += "e.[Licence_Expiry], ";

        if (chkDateLastCheck.Checked)
            fields += "e.[Date_Last_Exclusion_Check], ";

        if (Session["EmpIdForPrint"] != null)
        {
            Session["EmpIdForPrint"] = Session["EmpIdForPrint"] + "~" + fields;
            Response.Redirect("~/PrintReport.aspx");
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/manage_facility_employees.aspx");
    }
}