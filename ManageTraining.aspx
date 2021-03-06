﻿<%@ Page Title="Manage Training" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true"
    CodeFile="ManageTraining.aspx.cs" Inherits="ManageTraining" %>

<%@ Register Src="~/controls/training_courses_listing.ascx" TagName="courses" TagPrefix="TC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript" src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script language="javascript" type="text/javascript" src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script src="JS/managetraining.js" type="text/javascript" language="javascript"></script>
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
                <asp:Literal ID="lblInfo1" runat="server">Training Assignments</asp:Literal>
            </p>
            <div class="box_cont">
                <div class="delim">
                </div>
                <div class="add">
                    <a href="AssignTraining.aspx">Assign Training</a></div>
                <div class="spaser">
                </div>
                <div style="float: left; margin-left: 22px;">
                    <asp:CheckBox runat="server" ID="chkActive" AutoPostBack="True" Text="Uncompleted training only"
                        OnCheckedChanged="chkActive_CheckedChanged" Checked="True" /></div>
                <div class="spaser">
                </div>
                <div class="jScrollPaneContainer" style="margin-left: 10px; margin-right: 5px; margin-top: 5px;">
                    <div class="spaser">
                    </div>
                    <asp:GridView ID="gvTraining" runat="server" AutoGenerateColumns="false" PageSize="15"
                        HorizontalAlign="Right" AllowPaging="true" Width="100%" BorderStyle="None" PagerSettings-Mode="NextPreviousFirstLast"
                        PagerSettings-Position="Top" PagerStyle-HorizontalAlign="Center" DataKeyNames="TrainingAssignmentId"
                        AlternatingRowStyle-CssClass="gray" OnRowDataBound="gvTraining_RowDataBound"
                        OnPageIndexChanged="gvTraining_PageIndexChanged" OnPageIndexChanging="gvTraining_PageIndexChanging"
                        PagerSettings-FirstPageText="First" PagerSettings-LastPageText="Last" PagerSettings-NextPageText="Next"
                        PagerSettings-PreviousPageText="Previous" OnRowCommand="gvTraining_RowCommand">
                        <HeaderStyle CssClass="Header1" HorizontalAlign="Left" />
                        <Columns>
                            <asp:TemplateField HeaderText="&nbsp;&nbsp;Employee name">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmpName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="&nbsp;&nbsp;Training assigned">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.TrainingAssignmentId") %>'
                                        CommandName="edit" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CourseName") %>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="&nbsp;&nbsp;Date assigned">
                                <ItemTemplate>
                                    <asp:Label ID="lblDateAssigned" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="&nbsp;&nbsp;Due date">
                                <ItemTemplate>
                                    <asp:Label ID="lblDueDate" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="&nbsp;&nbsp;Completed" ItemStyle-Width="70">
                                <ItemTemplate>
                                    <asp:Label ID="lblCompleted" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="spaser">
                </div>
                <div class="spaser">
                </div>
            </div>
        </div>
        <!--10 pixels gap between middle and bottom-->
        <div class="spaser" style="height: 10px;">
        </div>
    </div>
</asp:Content>
