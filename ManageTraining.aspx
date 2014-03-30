<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true"
    CodeFile="ManageTraining.aspx.cs" Inherits="ManageTraining" %>

<%@ Register Src="~/controls/training_courses_listing.ascx" TagName="courses" TagPrefix="TC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript" src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script language="javascript" type="text/javascript" src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script src="JS/managetraining.js" type="text/javascript" language="javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <TC:courses ID="trainingcoures1" runat="server" />
    <div class="facility_gray_box">
       
        <span style="font-size:28px;font-weight:normal;color:#CECECE;">
            Training Assignments</span>
        <div>
        </div>
        <asp:GridView ID="gvTraining" runat="server" AutoGenerateColumns="false" PageSize="25"
            HorizontalAlign="Right" AllowPaging="true" Width="82%" BorderStyle="None" PagerSettings-Mode="NextPreviousFirstLast"
            PagerSettings-Position="Top" PagerStyle-HorizontalAlign="Center" DataKeyNames="TrainingAssignmentId"
            AlternatingRowStyle-CssClass="gray" OnRowDataBound="gvTraining_RowDataBound"
            OnPageIndexChanged="gvTraining_PageIndexChanged" OnPageIndexChanging="gvTraining_PageIndexChanging">
            <HeaderStyle CssClass="Header1" />
            <Columns>
                <asp:TemplateField HeaderText="Employee name">
                    <ItemTemplate>
                        <asp:Label ID="lblEmpName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Training assigned">
                    <ItemTemplate>
                        <asp:Label ID="lblTraingAssigned" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CourseName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date assigned">
                    <ItemTemplate>
                        <asp:Label ID="lblDateAssigned" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date due">
                    <ItemTemplate>
                        <asp:Label ID="lblDueDate" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Completed">
                    <ItemTemplate>
                        <asp:Label ID="lblCompleted" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
