<%@ page title="Manage Disciplinary Action" language="C#" masterpagefile="~/main.master" CodeFile="ManageDisciplinaryAction.aspx.cs" autoeventwireup="true" inherits="ManageDisciplinaryAction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
                            <a href="#"></a>
                        </div>
                    </div>
                    <div class="spaser" style="height: 1px;">
                        &nbsp;</div>
                </div>
            </div>
             <%--<span style="font-size: 28px; font-weight: normal; color: #CECECE; margin-left: 310px;">
                        Disciplinary Actions</span>--%>
            <span style="padding-left: 0px; padding-top: 0px; font-size: 25px;">
                Disciplinary Actions
                <asp:Literal ID="lblInfo1" runat="server" Visible ="false"></asp:Literal>
            </span>
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
                <div class="jScrollPaneContainer" style="margin-left:10px;margin-right:5px;margin-top:5px;">
                    <div class="spaser">
                    </div>
                   
                    <asp:GridView ID="gvTraining" runat="server" AutoGenerateColumns="false" PageSize="15"
                        HorizontalAlign="Right" AllowPaging="true" Width="100%" BorderStyle="None" PagerSettings-Mode="NextPreviousFirstLast"
                        PagerSettings-Position="Top" PagerStyle-HorizontalAlign="Center" DataKeyNames="Id"
                        AlternatingRowStyle-CssClass="gray" OnRowDataBound="gvTraining_RowDataBound"
                        OnPageIndexChanged="gvTraining_PageIndexChanged" OnPageIndexChanging="gvTraining_PageIndexChanging"
                        PagerSettings-FirstPageText="First" PagerSettings-LastPageText="Last" PagerSettings-NextPageText="Next"
                        PagerSettings-PreviousPageText="Previous" 
                        onrowcommand="gvTraining_RowCommand">
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
                                            CommandName="edit" runat="server" ToolTip='<%# DataBinder.Eval(Container, "DataItem.Infraction") %>' Text='<%# DataBinder.Eval(Container, "DataItem.Infraction_ShortText") %>'></asp:LinkButton>

                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Date of disciplinary action">
                                <ItemTemplate>
                                    <asp:Label ID="lblDateAssigned" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <asp:Label ID="lblDescription" ToolTip='<%# DataBinder.Eval(Container, "DataItem.ActionDescription") %>' runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ActionDescription_ShortText") %>'></asp:Label>
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

