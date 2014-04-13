<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true"
    CodeFile="SelectFieldsForPrint.aspx.cs" Inherits="SelectFieldsForPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />
    <script language="javascript" type="text/javascript" src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script language="javascript" type="text/javascript" src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script type="text/javascript" language="javascript">
       
    </script>
    <style type="text/css">
        .style1
        {
            font-size: small;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content">
        <table>
            <tr>
                <td>
                    <div class="title" style="text-align: left; margin-left: -4px;">
                        Select fields for print.</div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="chkEmpName" runat="server" Text="Employee Name" Checked="True"
                        Enabled="False" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="chkUserName" runat="server" Text="Compliasense User Name" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <div class="title" style="text-align: left; margin-left: -4px;">
                        Contact Information</div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="chkAddress" runat="server" Text="Address" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="chkTelephone" runat="server" Text="Telephone" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <div class="title" style="text-align: left; margin-left: -4px;">
                        Additional Information</div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="chkJobTitle" runat="server" Text="Job Title" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="chkEmployeeType" runat="server" Text="Employee Type" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="chkDateOfHire" runat="server" Text="Date Of Hire" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="chkLicense" runat="server" Text="License #" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="chkLicenseExp" runat="server" Text="License Expiration" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="chkDateLastCheck" runat="server" Text="Date of Last Exclusion Check" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnPrint" runat="server" Text="Print" 
                        onclick="btnPrint_Click" />&nbsp;<asp:Button ID="btnBack"
                        runat="server" Text="Back" onclick="btnBack_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
