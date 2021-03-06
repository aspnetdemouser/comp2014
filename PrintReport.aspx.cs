﻿using System;
using System.Collections.Generic;
using System.Text;
using BLCompliance.Model;

public partial class PrintReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GetData();
    }

    private void GetData()
    {
        if (Session["EmpIdForPrint"] != null)
        {
            var paramsVal = Session["EmpIdForPrint"].ToString().Split('~');
            Session["EmpIdForPrint"] = null;
            List<employee> employeeList;
            BLCompliance.BLManageFacility.GetEmployeeDetailsForPrint(paramsVal[0], paramsVal[1], out employeeList);
            var sb = new StringBuilder();
            sb.Append("<table style='font-family: Arial;font-size: 12px;'>");
            foreach (var emp in employeeList)
            {
                sb.Append("<tr>");
                sb.Append("<td style='width:200px;'><b>");
                sb.Append("Employee Name:");
                sb.Append("</b></td>");
                sb.Append("<td>" + emp.ContactName);
                sb.Append("</td>");
                sb.Append("</tr>");
                if (!string.IsNullOrEmpty(emp.EmailAddress))
                {
                    sb.Append("<tr>");
                    sb.Append("<td><b>");
                    sb.Append("Username :");
                    sb.Append("</b></td>");
                    sb.Append("<td>" + emp.EmailAddress);
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }
                bool hasAddress1 = false;
                if (!string.IsNullOrEmpty(emp.EmployeeContact.AddressLine1))
                {
                    sb.Append("<tr>");
                    sb.Append("<td><b>");
                    sb.Append("Address:");
                    sb.Append("</b></td>");
                    sb.Append("<td>" + emp.EmployeeContact.AddressLine1);
                    sb.Append("</td>");
                    sb.Append("</tr>");
                    hasAddress1 = true;
                }

                if (!string.IsNullOrEmpty(emp.EmployeeContact.AddressLine2))
                {
                    sb.Append("<tr>");
                    sb.Append("<td>");
                    if (hasAddress1 == false)
                    {
                        sb.Append("<b>Address:</b>");
                    }
                    sb.Append("</td>");
                    sb.Append("<td>" + emp.EmployeeContact.AddressLine2);
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }

                if (!string.IsNullOrEmpty(emp.EmployeeContact.TelePhone))
                {
                    sb.Append("<tr>");
                    sb.Append("<td><b>");
                    sb.Append("Telephone :");
                    sb.Append("</b></td>");
                    sb.Append("<td>" + emp.EmployeeContact.TelePhone);
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }

                if (!string.IsNullOrEmpty(emp.Position))
                {
                    sb.Append("<tr>");
                    sb.Append("<td><b>");
                    sb.Append("Job Title:");
                    sb.Append("</b></td>");
                    sb.Append("<td>" + emp.Position);
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }

                if (!string.IsNullOrEmpty(emp.EmployeeTypeText))
                {
                    sb.Append("<tr>");
                    sb.Append("<td><b>");
                    sb.Append("Employee Type :");
                    sb.Append("</b></td>");
                    sb.Append("<td>" + emp.EmployeeTypeText);
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }

                if (emp.DateOfHire != null)
                {
                    sb.Append("<tr>");
                    sb.Append("<td><b>");
                    sb.Append("Date of hire :");
                    sb.Append("</b></td>");
                    sb.Append("<td>" + emp.DateOfHire.Value.ToString("MMM dd, yyyy"));
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }

                if (!string.IsNullOrEmpty(emp.Licence_Number))
                {
                    sb.Append("<tr>");
                    sb.Append("<td><b>");
                    sb.Append("License # :");
                    sb.Append("</b></td>");
                    sb.Append("<td>" + emp.Licence_Number);
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }

                if (emp.Licence_Expiry != null)
                {
                    sb.Append("<tr>");
                    sb.Append("<td><b>");
                    sb.Append("License Expiration # :");
                    sb.Append("</b></td>");
                    sb.Append("<td>" + emp.Licence_Expiry.Value.ToString("MMM dd, yyyy"));
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }

                if (emp.DateLastExclusionCheck != null)
                {
                    sb.Append("<tr>");
                    sb.Append("<td><b>");
                    sb.Append("Date of Last Exclusion Check: ");
                    sb.Append("</b></td>");
                    sb.Append("<td>" + emp.DateLastExclusionCheck.Value.ToString("MMM dd, yyyy"));
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }

                sb.Append("<tr><td colspan='2'>&nbsp;</td></tr>");
            }
            sb.Append("</table>");

            dvPrint.InnerHtml = sb.ToString();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/manage_facility_employees.aspx");
    }
}