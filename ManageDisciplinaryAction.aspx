<%@ Page Title="Manage Disciplinary Action" Language="C#" MasterPageFile="~/main.master"
    CodeFile="ManageDisciplinaryAction.aspx.cs" AutoEventWireup="true" Inherits="ManageDisciplinaryAction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content">
        <div class="gray_box facility_gray_box employee_box">
            <div class="box_title" id="divOfficerInfo" runat="server">
                <h2>
                    <asp:Label ID="lblProfile" runat="server" Text="Employee Profile" Style="font-size: 25px; !important"></asp:Label>
                </h2>
                <br />
                <div class="form_block carrent_acc">
                    <div class="title" align="center" style="height: 50px;">
                        <span id="namespan" runat="server" style="text-transform: capitalize"></span>
                    </div>
                    <div style="font-size: 14px; padding-top: 20px;">
                        <span>
                            <asp:HyperLink ID="lnkEmployeeInfo" runat="server" Text="Employee Info"></asp:HyperLink>
                        </span>
                    </div>
                    <div style="font-size: 14px; padding-top: 20px;">
                        <span>
                            <asp:HyperLink ID="lnkActions" runat="server" Text="Disciplinary Actions"></asp:HyperLink>
                        </span>
                    </div>
                    <div class="spaser">
                    </div>
                </div>
            </div>
            <div class="box_cont">
                <div class="delim">
                </div>
                <div class="add">
                    <asp:HyperLink ID="lnkAddDiscAction" runat="server">Add Disciplinary Action</asp:HyperLink>
                </div>
                <%--                <div class="spaser">
                </div>--%>
                <div class="spaser">
                </div>
                <div class="jScrollPaneContainer" style="margin-left: 10px; margin-right: 5px; margin-top: 5px;">
                    <div class="spaser">
                    </div>
                    <asp:GridView ID="gvTraining" runat="server" AutoGenerateColumns="false" PageSize="15"
                        HorizontalAlign="Right" AllowPaging="true" Width="100%" BorderStyle="None" PagerSettings-Mode="NextPreviousFirstLast"
                        PagerSettings-Position="Top" PagerStyle-HorizontalAlign="Center" DataKeyNames="Id"
                        AlternatingRowStyle-CssClass="gray" OnRowDataBound="gvTraining_RowDataBound"
                        OnPageIndexChanged="gvTraining_PageIndexChanged" OnPageIndexChanging="gvTraining_PageIndexChanging"
                        PagerSettings-FirstPageText="First" PagerSettings-LastPageText="Last" PagerSettings-NextPageText="Next"
                        PagerSettings-PreviousPageText="Previous" OnRowCommand="gvTraining_RowCommand">
                        <HeaderStyle CssClass="Header1" />
                        <Columns>
                            <asp:TemplateField HeaderText="Employee name">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmpName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Infraction">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.Id") %>'
                                        CommandName="edit" runat="server" ToolTip='<%# DataBinder.Eval(Container, "DataItem.Infraction") %>'
                                        Text='<%# DataBinder.Eval(Container, "DataItem.Infraction_ShortText") %>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date of disciplinary action">
                                <ItemTemplate>
                                    <asp:Label ID="lblDateAssigned" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <asp:Label ID="lblDescription" ToolTip='<%# DataBinder.Eval(Container, "DataItem.ActionDescription") %>'
                                        runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ActionDescription_ShortText") %>'></asp:Label>
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
