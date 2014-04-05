<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true"
    CodeFile="AssignTraining.aspx.cs" Inherits="AssignTraining" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                        <div>
                            Tel:
                            <asp:Literal ID="lblPhone" runat="server"></asp:Literal>
                            <br>
                            Fax:
                            <asp:Literal ID="lblFax" runat="server"></asp:Literal></div>
                        <div>
                            <a href="#"></a>
                        </div>
                    </div>
                    <div class="spaser" style="height: 1px;">
                        &nbsp;</div>
                </div>
            </div>
            <span style="padding-left: 0px; padding-top: 0px; font-size: 25px;">
                <asp:Literal ID="lblInfo1" runat="server">Assign Training</asp:Literal>
            </span>
            <div class="box_cont form_block">
                <div class="delim">
                </div>
                <div>
                    <span></span>
                    <asp:Label ID="lbltxt" runat="server" CssClass="error_mess" Style="width: 300px;"></asp:Label>
                </div>
                <div>
                    <span style="font-size: 20px; vertical-align: text-top; width: auto; margin-left: 10px;">
                        Select Course :</span>
                    <asp:DropDownList ID="dlstTraining" runat="server" CssClass="mandatory" size="1"
                        Style="width: 300px; margin-left: 10px;" OnSelectedIndexChanged="dlstTraining_SelectedIndexChanged"
                        AutoPostBack="True">
                    </asp:DropDownList>
                </div>
                <table cellpadding="3" cellspacing="5">
                    <tr>
                        <td style="font-size: 15px; font-weight: normal; background-color: transparent !important;">
                            Choose Employee
                        </td>
                        <td style="background-color: transparent !important;">
                        </td>
                        <td style="font-size: 15px; font-weight: normal; background-color: transparent !important;">
                            Selected Employee
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ListBox ID="ListBox1" runat="server" Style="font-size: 15px;" Width="300" Height="200">
                            </asp:ListBox>
                        </td>
                        <td>
                            <asp:Button ID="btn1" runat="server" Text=">" Width="50" OnClick="btn1_Click" /><br />
                            <asp:Button ID="btn2" runat="server" Text=">>" Width="50" OnClick="btn2_Click" /><br />
                            <asp:Button ID="btn3" runat="server" Text="<" Width="50" OnClick="btn3_Click" /><br />
                            <asp:Button ID="btn4" runat="server" Text="<<" Width="50" OnClick="btn4_Click" />
                        </td>
                        <td>
                            <asp:ListBox ID="ListBox2" runat="server" Style="font-size: 15px;" Width="300" Height="200">
                            </asp:ListBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="center">
                            <asp:Button ID="btnSave" runat="server" Text="Assign Training" Style="font-size: 15px;
                                padding: 2px 15px;" OnClick="btnSave_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
