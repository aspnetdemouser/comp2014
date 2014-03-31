<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true"
    CodeFile="AssignTraining.aspx.cs" Inherits="AssignTraining" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content">
        <div>
            <span>Select training :</span>
            <asp:DropDownList ID="dlstTraining" runat="server" CssClass="mandatory" 
                size="1" Style="width: 100px;" 
                onselectedindexchanged="dlstTraining_SelectedIndexChanged" AutoPostBack="True">
            </asp:DropDownList>
        </div>
        <table>
            <tr>
                <td style="float: right; font-size: 15px; font-family: Arial,Helvetica,sans-serif;
                    font-weight: normal;">
                    Choose user
                </td>
                <td>
                </td>
                <td style="float: right; font-size: 15px; font-family: Arial,Helvetica,sans-serif;
                    font-weight: normal;">
                    Selected user
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ListBox ID="ListBox1" runat="server" Width="250" Height="200"></asp:ListBox>
                </td>
                <td>
                    <asp:Button ID="btn1" runat="server" Text=">" Width="50" OnClick="btn1_Click" /><br />
                    <asp:Button ID="btn2" runat="server" Text=">>" Width="50" OnClick="btn2_Click" /><br />
                    <asp:Button ID="btn3" runat="server" Text="<" Width="50" OnClick="btn3_Click" /><br />
                    <asp:Button ID="btn4" runat="server" Text="<<" Width="50" OnClick="btn4_Click" />
                </td>
                <td>
                    <asp:ListBox ID="ListBox2" runat="server" Width="250" Height="200"></asp:ListBox>
                </td>
            </tr>
            <tr>
                <td colspan="3" style="color: red; font-weight: bold; font-size: medium;" align="center">
                    <asp:Label ID="lbltxt" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" align="center">
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
