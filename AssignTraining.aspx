<%@ Page Title="Assign Training" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true"
    CodeFile="AssignTraining.aspx.cs" Inherits="AssignTraining" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />
    <script language="javascript" type="text/javascript" src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script language="javascript" type="text/javascript" src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            $("#<%= txtDueDate.ClientID %>").datepicker();
            $("#<%= txtReadOnly2_DateAssigned.ClientID %>").datepicker();
            $("#<%= txtReadOnly3_DateDue.ClientID %>").datepicker();
            
            
        });
        $(function () {
            $("#<%= txtDueDate.ClientID %>").datepicker();
            $("#<%= txtReadOnly2_DateAssigned.ClientID %>").datepicker();
            $("#<%= txtReadOnly3_DateDue.ClientID %>").datepicker();
        });
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
        <div class="gray_box facility_gray_box employee_box">
            <div class="box_title">
                <h2>
                    <asp:Literal ID="lblFacilityName" runat="server"></asp:Literal>
                </h2>
                <br>
                <div class="cats_articles">
                    <div class="facillity_info">
                        <div>
                            <asp:Literal ID="lblAddress1" runat="server"></asp:Literal><br />
                            <asp:Literal ID="lblCityStateZip" runat="server"></asp:Literal><br />
                            <asp:Literal ID="lblCountry" runat="server"></asp:Literal>
                        </div>
                    </div>
                    <div class="spaser" style="height: 1px;">
                        &nbsp;</div>
                </div>
            </div>
            <p style="font-size:25px;margin-top:25px;">
                <asp:Literal ID="lblInfo1" runat="server">Assign Training</asp:Literal>
            </p>
            <div class="box_cont form_block">
                <div class="delim">
                </div>
                <div>
                    <span></span>
                    <asp:Label ID="lbltxt" runat="server" CssClass="error_mess" Style="width: 300px;"></asp:Label>
                </div>
                <div id="formEdit1" runat="server">
                    <span style="color: #FFFFFF; font-size: 13px; vertical-align: text-top; width: auto;
                        margin-left: 10px;">Training Assigned:&nbsp;</span>
                    <asp:TextBox ID="txtCourseName" runat="server" MaxLength="50" CssClass="mandatory"></asp:TextBox>
                </div>
                <table cellpadding="3" cellspacing="5" id="formEdit" runat="server">
                    <tr>
                        <td colspan="3" style="background-color: transparent !important;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td style="color: #FFFFFF; font-size: 13px; font-weight: normal; background-color: transparent !important;">
                            Choose Employees
                        </td>
                        <td style="background-color: transparent !important;">
                        </td>
                        <td style="color: #FFFFFF; font-size: 13px; font-weight: normal; background-color: transparent !important;">
                            Selected Employees
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ListBox ID="ListBox1" runat="server" Style="font-size: 13px;" Width="300" Height="200"
                                OnSelectedIndexChanged="ListBox1_SelectedIndexChanged"></asp:ListBox>
                        </td>
                        <td>
                            <asp:Button ID="btn1" runat="server" Text=">" Width="50" OnClick="btn1_Click" /><br />
                            <asp:Button ID="btn2" runat="server" Text=">>" Width="50" OnClick="btn2_Click" /><br />
                            <asp:Button ID="btn3" runat="server" Text="<" Width="50" OnClick="btn3_Click" /><br />
                            <asp:Button ID="btn4" runat="server" Text="<<" Width="50" OnClick="btn4_Click" />
                        </td>
                        <td>
                            <asp:ListBox ID="ListBox2" runat="server" Style="font-size: 13px;" Width="300" Height="200">
                            </asp:ListBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <span style="color: #FFFFFF; font-size: 13px; font-weight: normal; background-color: transparent !important;">
                                Due Date:&nbsp;</span>
                            <asp:TextBox ID="txtDueDate" Style="font-size: 13px; color: #FFFFFF; font-family: arial;
                                border: 1px solid #C6C6C6; background: none repeat scroll 0 0 #757575;" runat="server"
                                size="15" autocomplete="off" CssClass="GeneralInputBox"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:CheckBox ID="chkCompleted" Text="Completed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="center">
                            <asp:Button ID="btnSave" runat="server" Text="Assign Training" CssClass="submit_button_new"
                                Style="font-size: 15px; padding: 2px 15px; border: 1px solid #C6C6C6; font-size: 13px;
                                color: #FFFFFF; font-family: arial; background: none repeat scroll 0 0 #757575;"
                                OnClick="btnSave_Click" />
                            <asp:Button runat="server" ID="btnCancel" Text="Back to List" CssClass="cancel_new"
                                Style="font-size: 15px; padding: 2px 15px; border: 1px solid #C6C6C6; font-size: 13px;
                                color: #FFFFFF; font-family: arial; background: none repeat scroll 0 0 #757575;"
                                OnClick="btnCancel_Click" />
                        </td>
                    </tr>
                </table>
                <div id="formReadOnly0" runat="server" visible="false">
                    <span>Employee Name:&nbsp;</span>
                    <asp:Label ID="lblReadOnly0_EmpName" runat="server" Style="text-align: left;
                        margin-left: 10px;"></asp:Label>
                </div>
                <div id="formReadOnly1" runat="server" visible="false">
                    <asp:HiddenField ID="hdnRecordId" runat="server" Value="" />
                    <span>Training Assigned:&nbsp;</span>
                    <asp:Label ID="lblReadOnly1_CourseTitle" runat="server" Style="text-align: left;
                        margin-left: 10px;"></asp:Label>
                    <asp:TextBox ID="txtReadonly1_CourseTitle" runat="server" MaxLength="50"></asp:TextBox>
                </div>
                <div id="formReadOnly2" runat="server" visible="false">
                    <span>Date Assigned:&nbsp;</span>
                    <asp:Label ID="lblReadonly2_DateAssigned" runat="server" Style="text-align: left;
                        margin-left: 10px;"></asp:Label>
                         <asp:TextBox ID="txtReadOnly2_DateAssigned" Style="font-size: 13px; color: #FFFFFF; font-family: arial;
                                border: 1px solid #C6C6C6; background: none repeat scroll 0 0 #757575;" runat="server"
                                size="15" autocomplete="off" CssClass="GeneralInputBox"></asp:TextBox>
                </div>
                <div id="formReadOnly3" runat="server" visible="false">
                    <span>Due Date:&nbsp;</span>
                    <asp:Label ID="lblReadOnly3_DueDate" runat="server" Style="text-align: left; margin-left: 10px;"></asp:Label>
                    <asp:TextBox ID="txtReadOnly3_DateDue" Style="font-size: 13px; color: #FFFFFF; font-family: arial;
                                border: 1px solid #C6C6C6; background: none repeat scroll 0 0 #757575;" runat="server"
                                size="15" autocomplete="off" CssClass="GeneralInputBox"></asp:TextBox>
                </div>
                <div id="formReadOnly4" runat="server" visible="false">
                    <span style="vertical-align:text-top">Completed:&nbsp;</span>
                    <asp:CheckBox ID="chkIsCompleted" Text="" style="vertical-align:text-top" runat="server" />
                </div>
                <div class="spaser" style="height: 15px;">
                </div>
                <left style="margin-left:40px;">
                
                    <asp:Button runat="server" ID="btnEditStatus" Text="Update Status" CssClass="submit_button_new"
                        
                    Style="font-size: 15px; padding: 2px 15px; border: 1px solid #C6C6C6; font-size: 13px;
                        color: #FFFFFF; font-family: arial; background: none repeat scroll 0 0 #757575;" onclick="btnEditStatus_Click"
                         />
                    <asp:Button runat="server" ID="btnEditStatusCancel" Text="Back To List" CssClass="submit_button_new"
                        
                    Style="font-size: 15px; padding: 2px 15px; border: 1px solid #C6C6C6; font-size: 13px;
                        color: #FFFFFF; font-family: arial; background: none repeat scroll 0 0 #757575;" onclick="btnEditStatusCancel_Click"
                         />
                </left>
            </div>
        </div>
    </div>
</asp:Content>

